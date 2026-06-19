extends Panel
class_name DungeonViewportUI
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

const CommandOverlayUIScript = preload("res://scripts/ui/CommandOverlayUI.gd")
const CombatMonsterDisplayUIScript = preload("res://scripts/ui/CombatMonsterDisplayUI.gd")
const InGameMenuPanelUIScript = preload("res://scripts/ui/InGameMenuPanelUI.gd")
const AutoMapUIScript = preload("res://scripts/ui/AutoMapUI.gd")

const DEFAULT_CAMERA_FAR_DISTANCE: float = 24.0

signal in_game_menu_save_requested
signal in_game_menu_quit_requested
signal exploration_command_pressed(command_id: String)
signal combat_command_pressed(command_index: int)

var subviewport_container: SubViewportContainer = null
var world_subviewport: SubViewport = null
var viewport_camera: Camera3D = null
var source_camera: Camera3D = null
var dungeon_root: Node = null

var current_theme = null

var fog_curtains: Array[MeshInstance3D] = []

var view_status_panel: Panel = null
var view_status_label: Label = null
var view_status_bar: ProgressBar = null

var command_overlay = null
var exploration_map_overlay_root: Control = null
var exploration_map_overlay_panel: Panel = null
var exploration_map_auto_map = null
var exploration_map_return_button: Button = null

var stored_map_layout: Array[String] = []
var stored_map_discovered_cells: Dictionary = {}
var stored_map_player_position: Vector2i = Vector2i.ZERO
var stored_map_facing_name: String = ""

var ui_built: bool = false

var monster_display = null
var last_enemy_hp: int = -1
var last_enemy_name: String = ""

var last_party_hp_for_attack_feedback: Dictionary = {}
var in_game_menu_panel = null

func _ready() -> void:
	build_ui()


func _process(_delta: float) -> void:
	sync_3d_viewport()


func setup_camera_source(p_dungeon_root: Node) -> void:
	ensure_ui_ready()

	dungeon_root = p_dungeon_root
	find_and_copy_source_camera()


func set_dungeon_theme(theme) -> void:
	current_theme = theme

	if ui_built:
		rebuild_fog_curtains()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.02, 0.015, 0.01, 1.0),
			Color(0.50, 0.32, 0.13, 1.0),
			4
		)
	)

	build_subviewport()
	build_fog_curtains()
	build_monster_display()
	build_enemy_status_overlay()
	build_command_overlay()
	build_exploration_map_overlay()
	build_in_game_menu_panel()


func build_in_game_menu_panel() -> void:
	in_game_menu_panel = InGameMenuPanelUIScript.new()
	in_game_menu_panel.name = "InGameMenuPanelUI"
	in_game_menu_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(in_game_menu_panel)

	in_game_menu_panel.save_requested.connect(on_in_game_menu_save_requested)
	in_game_menu_panel.quit_requested.connect(on_in_game_menu_quit_requested)


func open_in_game_menu(party: Array) -> void:
	ensure_ui_ready()
	close_exploration_map_overlay(false)

	if command_overlay != null:
		command_overlay.visible = false

	if view_status_panel != null:
		view_status_panel.visible = false

	if monster_display != null:
		monster_display.visible = false

	if in_game_menu_panel != null:
		in_game_menu_panel.open_menu(party)


func close_in_game_menu() -> void:
	ensure_ui_ready()

	if in_game_menu_panel != null:
		in_game_menu_panel.close_menu()


func toggle_in_game_menu(party: Array) -> void:
	if is_in_game_menu_open():
		close_in_game_menu()
	else:
		open_in_game_menu(party)


func is_in_game_menu_open() -> bool:
	if in_game_menu_panel == null:
		return false

	return in_game_menu_panel.is_menu_open()


func show_in_game_menu_message(text: String) -> void:
	if in_game_menu_panel == null:
		return

	in_game_menu_panel.show_message(text)


func on_in_game_menu_save_requested() -> void:
	in_game_menu_save_requested.emit()


func on_in_game_menu_quit_requested() -> void:
	in_game_menu_quit_requested.emit()



# ------------------------------------------------------------
# CARTE AGRANDIE D'EXPLORATION
# Affiche la même carte découverte que l'automap, mais dans le viewport.
# ------------------------------------------------------------

func build_exploration_map_overlay() -> void:
	exploration_map_overlay_root = Control.new()
	exploration_map_overlay_root.name = "ExplorationMapOverlayRoot"
	exploration_map_overlay_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	exploration_map_overlay_root.mouse_filter = Control.MOUSE_FILTER_STOP
	exploration_map_overlay_root.visible = false
	add_child(exploration_map_overlay_root)

	exploration_map_overlay_panel = Panel.new()
	exploration_map_overlay_panel.name = "ExplorationMapOverlay"
	exploration_map_overlay_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	exploration_map_overlay_panel.offset_left = 14
	exploration_map_overlay_panel.offset_top = 14
	exploration_map_overlay_panel.offset_right = -14
	exploration_map_overlay_panel.offset_bottom = -14
	exploration_map_overlay_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	exploration_map_overlay_panel.add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.035, 0.024, 0.016, 0.98),
			Color(0.58, 0.36, 0.14, 1.0),
			4
		)
	)
	exploration_map_overlay_root.add_child(exploration_map_overlay_panel)

	var margin: MarginContainer = MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 8)
	exploration_map_overlay_panel.add_child(margin)

	exploration_map_auto_map = AutoMapUIScript.new()
	exploration_map_auto_map.name = "ExplorationMapFullAutoMap"
	exploration_map_auto_map.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	exploration_map_auto_map.size_flags_vertical = Control.SIZE_EXPAND_FILL
	margin.add_child(exploration_map_auto_map)

	exploration_map_return_button = Button.new()
	exploration_map_return_button.text = "Retour"
	exploration_map_return_button.custom_minimum_size = Vector2(62, 22)
	exploration_map_return_button.focus_mode = Control.FOCUS_NONE
	exploration_map_return_button.z_index = 20
	exploration_map_return_button.set_anchors_preset(Control.PRESET_BOTTOM_LEFT)
	exploration_map_return_button.offset_left = 8
	exploration_map_return_button.offset_top = -28
	exploration_map_return_button.offset_right = 70
	exploration_map_return_button.offset_bottom = -6
	exploration_map_return_button.add_theme_font_size_override("font_size", 11)
	exploration_map_return_button.add_theme_color_override("font_color", Color(0.90, 0.80, 0.58))
	exploration_map_return_button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	exploration_map_return_button.add_theme_color_override("font_pressed_color", Color(1.0, 0.92, 0.48))
	exploration_map_return_button.add_theme_stylebox_override(
		"normal",
		UIFrameStyleScript.create_button_style(
			Color(0.11, 0.07, 0.04, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			1
		)
	)
	exploration_map_return_button.add_theme_stylebox_override(
		"hover",
		UIFrameStyleScript.create_button_style(
			Color(0.18, 0.10, 0.05, 1.0),
			Color(0.55, 0.34, 0.13, 1.0),
			1
		)
	)
	exploration_map_return_button.add_theme_stylebox_override(
		"pressed",
		UIFrameStyleScript.create_button_style(
			Color(0.28, 0.16, 0.06, 1.0),
			Color(0.95, 0.72, 0.28, 1.0),
			2
		)
	)
	exploration_map_return_button.pressed.connect(close_exploration_map_overlay)
	exploration_map_overlay_panel.add_child(exploration_map_return_button)


func update_exploration_map_data(
	layout: Array[String],
	discovered_cells: Dictionary,
	player_position: Vector2i,
	facing_name: String
) -> void:
	stored_map_layout = layout.duplicate()
	stored_map_discovered_cells = discovered_cells.duplicate(true)
	stored_map_player_position = player_position
	stored_map_facing_name = facing_name

	if is_exploration_map_overlay_open():
		refresh_exploration_map_overlay()
	call_deferred("refresh_exploration_map_overlay")


func open_exploration_map_overlay(
	layout: Array[String],
	discovered_cells: Dictionary,
	player_position: Vector2i,
	facing_name: String
) -> void:
	ensure_ui_ready()

	update_exploration_map_data(
		layout,
		discovered_cells,
		player_position,
		facing_name
	)

	if exploration_map_overlay_root != null:
		exploration_map_overlay_root.visible = true

	if command_overlay != null:
		command_overlay.visible = false

	if view_status_panel != null:
		view_status_panel.visible = false

	if monster_display != null:
		monster_display.visible = false

	refresh_exploration_map_overlay()


func close_exploration_map_overlay(restore_exploration_commands: bool = true) -> void:
	ensure_ui_ready()

	if exploration_map_overlay_root != null:
		exploration_map_overlay_root.visible = false

	if restore_exploration_commands:
		show_exploration_commands()


func is_exploration_map_overlay_open() -> bool:
	if exploration_map_overlay_root == null:
		return false

	return exploration_map_overlay_root.visible


func refresh_exploration_map_overlay() -> void:
	if exploration_map_auto_map == null:
		return

	if exploration_map_auto_map.has_method("update_full_map"):
		exploration_map_auto_map.update_full_map(
			stored_map_layout,
			stored_map_discovered_cells,
			stored_map_player_position,
			stored_map_facing_name
		)


func build_monster_display() -> void:
	monster_display = CombatMonsterDisplayUIScript.new()
	monster_display.name = "CombatMonsterDisplayUI"
	add_child(monster_display)

# ------------------------------------------------------------
# SUBVIEWPORT 3D
# ------------------------------------------------------------

func build_subviewport() -> void:
	subviewport_container = SubViewportContainer.new()
	subviewport_container.name = "DungeonViewContainer"
	subviewport_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	subviewport_container.offset_left = 7
	subviewport_container.offset_top = 7
	subviewport_container.offset_right = -7
	subviewport_container.offset_bottom = -7
	subviewport_container.stretch = true
	subviewport_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(subviewport_container)

	world_subviewport = SubViewport.new()
	world_subviewport.name = "DungeonSubViewport"
	world_subviewport.size = Vector2i(640, 360)
	world_subviewport.transparent_bg = false
	world_subviewport.render_target_update_mode = SubViewport.UPDATE_ALWAYS
	subviewport_container.add_child(world_subviewport)

	viewport_camera = Camera3D.new()
	viewport_camera.name = "DungeonViewportCamera"
	viewport_camera.current = true
	viewport_camera.far = DEFAULT_CAMERA_FAR_DISTANCE
	world_subviewport.add_child(viewport_camera)


func find_and_copy_source_camera() -> void:
	if dungeon_root == null:
		return

	if not dungeon_root.has_node("Player/Camera3D"):
		return

	source_camera = dungeon_root.get_node("Player/Camera3D") as Camera3D

	if source_camera == null:
		return

	if world_subviewport != null:
		world_subviewport.world_3d = source_camera.get_world_3d()

	if viewport_camera != null:
		copy_camera_settings()


func sync_3d_viewport() -> void:
	if world_subviewport == null:
		return

	if subviewport_container != null:
		var container_size: Vector2 = subviewport_container.size

		if container_size.x > 8 and container_size.y > 8:
			var new_size: Vector2i = Vector2i(
				int(container_size.x),
				int(container_size.y)
			)

			if world_subviewport.size != new_size:
				world_subviewport.size = new_size

	if source_camera == null or not is_instance_valid(source_camera):
		find_and_copy_source_camera()

	if source_camera == null:
		return

	if world_subviewport.world_3d == null:
		world_subviewport.world_3d = source_camera.get_world_3d()

	copy_camera_settings()
	update_fog_curtains()


func copy_camera_settings() -> void:
	if source_camera == null:
		return

	if viewport_camera == null:
		return

	viewport_camera.current = true
	viewport_camera.global_transform = source_camera.global_transform
	viewport_camera.fov = source_camera.fov
	viewport_camera.near = source_camera.near
	viewport_camera.projection = source_camera.projection
	viewport_camera.size = source_camera.size
	viewport_camera.far = DEFAULT_CAMERA_FAR_DISTANCE


# ------------------------------------------------------------
# BROUILLARD DE PROFONDEUR
# ------------------------------------------------------------

func rebuild_fog_curtains() -> void:
	for fog_curtain in fog_curtains:
		if fog_curtain != null and is_instance_valid(fog_curtain):
			fog_curtain.queue_free()

	fog_curtains.clear()
	build_fog_curtains()


func build_fog_curtains() -> void:
	if viewport_camera == null:
		return

	fog_curtains.clear()

	var distances: Array = get_fog_distances()
	var alphas: Array = get_fog_alphas()

	var curtain_count: int = min(distances.size(), alphas.size())

	for i in range(curtain_count):
		var distance: float = distances[i]
		var alpha: float = alphas[i]

		var fog_mesh: QuadMesh = QuadMesh.new()
		fog_mesh.size = Vector2(8.0, 5.0)

		var fog_material: StandardMaterial3D = StandardMaterial3D.new()
		fog_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
		fog_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		fog_material.cull_mode = BaseMaterial3D.CULL_DISABLED
		fog_material.albedo_color = get_fog_color_with_alpha(alpha)

		var fog_curtain: MeshInstance3D = MeshInstance3D.new()
		fog_curtain.name = "FogCurtain" + str(i + 1)
		fog_curtain.mesh = fog_mesh
		fog_curtain.material_override = fog_material
		fog_curtain.position = Vector3(0.0, 0.0, -distance)

		viewport_camera.add_child(fog_curtain)
		fog_curtains.append(fog_curtain)

	update_fog_curtains()


func update_fog_curtains() -> void:
	if viewport_camera == null:
		return

	if world_subviewport == null:
		return

	var viewport_size: Vector2 = Vector2(world_subviewport.size)

	if viewport_size.y <= 0:
		return

	var aspect_ratio: float = viewport_size.x / viewport_size.y
	var distances: Array = get_fog_distances()

	for i in range(fog_curtains.size()):
		if i >= distances.size():
			continue

		var fog_curtain: MeshInstance3D = fog_curtains[i]

		if fog_curtain == null:
			continue

		var distance: float = distances[i]

		fog_curtain.position = Vector3(0.0, 0.0, -distance)

		var visible_height: float = 2.0 * tan(deg_to_rad(viewport_camera.fov * 0.5)) * distance
		var visible_width: float = visible_height * aspect_ratio

		var fog_mesh: QuadMesh = fog_curtain.mesh as QuadMesh

		if fog_mesh != null:
			fog_mesh.size = Vector2(
				visible_width * 1.15,
				visible_height * 1.15
			)


func get_fog_distances() -> Array:
	if current_theme != null:
		if "fog_curtain_distances" in current_theme:
			return current_theme.fog_curtain_distances

	return [
		4.25,
		5.25,
		6.25
	]


func get_fog_alphas() -> Array:
	if current_theme != null:
		if "fog_curtain_alphas" in current_theme:
			return current_theme.fog_curtain_alphas

	return [
		0.44,
		0.64,
		0.96
	]


func get_fog_color_with_alpha(alpha: float) -> Color:
	var fog_color: Color = Color(0.0, 0.0, 0.0, 1.0)

	if current_theme != null:
		if "fog_color" in current_theme:
			fog_color = current_theme.fog_color

	fog_color.a = alpha

	return fog_color


# ------------------------------------------------------------
# OVERLAY ENNEMI
# ------------------------------------------------------------

func build_enemy_status_overlay() -> void:
	view_status_panel = Panel.new()
	view_status_panel.name = "ViewStatusPanel"

	view_status_panel.add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.055, 0.035, 0.025, 0.95),
			Color(0.42, 0.27, 0.12, 1.0),
			2
		)
	)

	view_status_panel.anchor_left = 0.30
	view_status_panel.anchor_top = 0.0
	view_status_panel.anchor_right = 0.70
	view_status_panel.anchor_bottom = 0.0
	view_status_panel.offset_left = 0
	view_status_panel.offset_top = 12
	view_status_panel.offset_right = 0
	view_status_panel.offset_bottom = 56
	add_child(view_status_panel)

	var status_box: VBoxContainer = VBoxContainer.new()
	status_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	status_box.offset_left = 8
	status_box.offset_top = 5
	status_box.offset_right = -8
	status_box.offset_bottom = -5
	status_box.add_theme_constant_override("separation", 3)
	view_status_panel.add_child(status_box)

	view_status_label = create_label("", 14, Color(0.95, 0.82, 0.48))
	view_status_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	status_box.add_child(view_status_label)

	view_status_bar = create_bar(
		Color(0.65, 0.14, 0.10),
		Color(0.08, 0.04, 0.03)
	)
	status_box.add_child(view_status_bar)

	view_status_panel.visible = false

func update_party_damage_feedback(party: Array) -> void:
	if monster_display == null:
		return

	var monster_should_attack: bool = false

	for hero in party:
		if hero == null:
			continue

		var hero_key: String = hero.character_name
		var current_hp: int = hero.hp

		if last_party_hp_for_attack_feedback.has(hero_key):
			var previous_hp: int = last_party_hp_for_attack_feedback[hero_key]

			if current_hp < previous_hp:
				monster_should_attack = true

		last_party_hp_for_attack_feedback[hero_key] = current_hp

	if monster_should_attack:
		monster_display.play_attack_motion()

func show_enemy(enemy) -> void:
	ensure_ui_ready()

	if enemy == null:
		hide_enemy()
		return

	if view_status_panel == null:
		return

	view_status_panel.visible = true

	view_status_label.text = enemy.monster_name
	view_status_bar.max_value = max(1, enemy.max_hp)
	view_status_bar.value = enemy.hp

	if monster_display != null:
		monster_display.show_monster(enemy)

	var enemy_name: String = enemy.monster_name
	var enemy_hp: int = enemy.hp

	if last_enemy_name == enemy_name:
		if last_enemy_hp >= 0 and enemy_hp < last_enemy_hp:
			if monster_display != null:
				monster_display.play_hit_flash()

	last_enemy_name = enemy_name
	last_enemy_hp = enemy_hp

func hide_enemy() -> void:
	ensure_ui_ready()

	if view_status_panel != null:
		view_status_panel.visible = false

	if monster_display != null:
		monster_display.hide_monster()

	last_enemy_hp = -1
	last_enemy_name = ""
	last_party_hp_for_attack_feedback.clear()

# ------------------------------------------------------------
# OVERLAY COMMANDES
# ------------------------------------------------------------

func build_command_overlay() -> void:
	command_overlay = CommandOverlayUIScript.new()
	command_overlay.name = "CommandOverlayUI"
	add_child(command_overlay)
	connect_command_overlay_signals()


func connect_command_overlay_signals() -> void:
	if command_overlay == null:
		return

	if command_overlay.has_signal("exploration_command_pressed"):
		if not command_overlay.exploration_command_pressed.is_connected(on_command_overlay_exploration_command_pressed):
			command_overlay.exploration_command_pressed.connect(on_command_overlay_exploration_command_pressed)

	if command_overlay.has_signal("combat_command_pressed"):
		if not command_overlay.combat_command_pressed.is_connected(on_command_overlay_combat_command_pressed):
			command_overlay.combat_command_pressed.connect(on_command_overlay_combat_command_pressed)


func on_command_overlay_exploration_command_pressed(command_id: String) -> void:
	exploration_command_pressed.emit(command_id)


func on_command_overlay_combat_command_pressed(command_index: int) -> void:
	combat_command_pressed.emit(command_index)


func show_exploration_commands() -> void:
	ensure_ui_ready()

	if command_overlay != null:
		command_overlay.show_exploration_commands()


func show_combat_commands(
	commands: Array[String],
	selected_command_index: int
) -> void:
	ensure_ui_ready()
	close_exploration_map_overlay(false)

	if command_overlay != null:
		command_overlay.show_combat_commands(
			commands,
			selected_command_index
		)


func hide_commands() -> void:
	ensure_ui_ready()

	if command_overlay != null:
		command_overlay.hide_commands()


# ------------------------------------------------------------
# OUTILS VISUELS
# ------------------------------------------------------------

func create_panel_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBox:
	return UIFrameStyleScript.create_panel_style(
		background_color,
		border_color,
		border_width
	)


func create_label(
	text: String,
	font_size: int,
	font_color: Color
) -> Label:
	var label: Label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label


func create_bar(
	fill_color: Color,
	background_color: Color
) -> ProgressBar:
	var bar: ProgressBar = ProgressBar.new()
	bar.custom_minimum_size = Vector2(0, 12)
	bar.show_percentage = false
	bar.min_value = 0
	bar.max_value = 1
	bar.value = 1

	var background_style: StyleBoxFlat = StyleBoxFlat.new()
	background_style.bg_color = background_color
	background_style.set_border_width_all(1)
	background_style.border_color = Color(0.02, 0.015, 0.01)

	var fill_style: StyleBoxFlat = StyleBoxFlat.new()
	fill_style.bg_color = fill_color

	bar.add_theme_stylebox_override("background", background_style)
	bar.add_theme_stylebox_override("fill", fill_style)

	return bar


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
