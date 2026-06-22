extends CanvasLayer
class_name GameUI

const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const LogPanelUIScript = preload("res://scripts/ui/LogPanelUI.gd")
const DungeonViewportUIScript = preload("res://scripts/ui/DungeonViewportUI.gd")
const PartyStatusUIScript = preload("res://scripts/ui/PartyStatusUI.gd")
const AutoMapUIScript = preload("res://scripts/ui/AutoMapUI.gd")

const OUTER_MARGIN: float = 10.0
const SIDE_WIDTH: float = 210.0
const BOTTOM_HEIGHT: float = 200.0
const GAP: float = 10.0

const LOG_JOURNAL: String = "journal"
const LOG_COMBAT: String = "combat"

signal in_game_menu_save_requested
signal in_game_menu_quit_requested
signal exploration_command_pressed(command_id: String)
signal combat_command_pressed(command_index: int)

var root: Control = null
var main_ui_root: Control = null
var creation_ui_root: Control = null

var party_status_ui = null
var dungeon_viewport = null
var log_panel = null
var auto_map_ui = null

var current_screen_mode: String = ""


func _ready() -> void:
	build_ui()


func build_ui() -> void:
	root = Control.new()
	root.name = "GameUIRoot"
	root.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(root)

	build_main_ui()
	build_creation_ui()

	log_panel.add_system_message("Interface initialisée.")
	log_panel.add_system_message("Canaux disponibles : Tous, Journal, Combat, Système.")

	creation_ui_root.visible = false
	main_ui_root.visible = true


func build_main_ui() -> void:
	main_ui_root = Control.new()
	main_ui_root.name = "MainUI"
	main_ui_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(main_ui_root)

	var screen_background: ColorRect = ColorRect.new()
	screen_background.name = "UIScreenBackground"
	screen_background.color = Color(0.025, 0.018, 0.014, 1.0)
	screen_background.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_ui_root.add_child(screen_background)

	build_party_status_ui()
	build_dungeon_viewport()
	build_bottom_area()


func build_party_status_ui() -> void:
	party_status_ui = PartyStatusUIScript.new()
	party_status_ui.name = "PartyStatusUI"
	party_status_ui.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_ui_root.add_child(party_status_ui)


func build_dungeon_viewport() -> void:
	dungeon_viewport = DungeonViewportUIScript.new()
	dungeon_viewport.name = "DungeonViewportUI"

	dungeon_viewport.anchor_left = 0.0
	dungeon_viewport.anchor_top = 0.0
	dungeon_viewport.anchor_right = 1.0
	dungeon_viewport.anchor_bottom = 1.0

	dungeon_viewport.offset_left = OUTER_MARGIN + SIDE_WIDTH + GAP
	dungeon_viewport.offset_top = OUTER_MARGIN
	dungeon_viewport.offset_right = -OUTER_MARGIN - SIDE_WIDTH - GAP
	dungeon_viewport.offset_bottom = -OUTER_MARGIN - BOTTOM_HEIGHT - GAP

	main_ui_root.add_child(dungeon_viewport)
	dungeon_viewport.setup_camera_source(get_parent())

	if dungeon_viewport.has_signal("in_game_menu_save_requested"):
		dungeon_viewport.in_game_menu_save_requested.connect(on_in_game_menu_save_requested)

	if dungeon_viewport.has_signal("in_game_menu_quit_requested"):
		dungeon_viewport.in_game_menu_quit_requested.connect(on_in_game_menu_quit_requested)

	if dungeon_viewport.has_signal("exploration_command_pressed"):
		dungeon_viewport.exploration_command_pressed.connect(on_dungeon_viewport_exploration_command_pressed)

	if dungeon_viewport.has_signal("combat_command_pressed"):
		dungeon_viewport.combat_command_pressed.connect(on_dungeon_viewport_combat_command_pressed)


func open_in_game_menu(party: Array) -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("open_in_game_menu"):
		dungeon_viewport.open_in_game_menu(party)


func close_in_game_menu() -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("close_in_game_menu"):
		dungeon_viewport.close_in_game_menu()


func toggle_in_game_menu(party: Array) -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("toggle_in_game_menu"):
		dungeon_viewport.toggle_in_game_menu(party)


func is_in_game_menu_open() -> bool:
	if dungeon_viewport == null:
		return false

	if not dungeon_viewport.has_method("is_in_game_menu_open"):
		return false

	return dungeon_viewport.is_in_game_menu_open()


func show_in_game_menu_message(text: String) -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("show_in_game_menu_message"):
		dungeon_viewport.show_in_game_menu_message(text)


func open_exploration_map(
	layout: Array[String],
	discovered_map_cells: Dictionary,
	position: Vector2i,
	facing_name: String
) -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("open_exploration_map_overlay"):
		dungeon_viewport.open_exploration_map_overlay(
			layout,
			discovered_map_cells,
			position,
			facing_name
		)


func close_exploration_map() -> void:
	if dungeon_viewport == null:
		return

	if dungeon_viewport.has_method("close_exploration_map_overlay"):
		dungeon_viewport.close_exploration_map_overlay()


func is_exploration_map_open() -> bool:
	if dungeon_viewport == null:
		return false

	if not dungeon_viewport.has_method("is_exploration_map_overlay_open"):
		return false

	return dungeon_viewport.is_exploration_map_overlay_open()


func on_in_game_menu_save_requested() -> void:
	in_game_menu_save_requested.emit()


func on_in_game_menu_quit_requested() -> void:
	in_game_menu_quit_requested.emit()


func on_dungeon_viewport_exploration_command_pressed(command_id: String) -> void:
	exploration_command_pressed.emit(command_id)


func on_dungeon_viewport_combat_command_pressed(command_index: int) -> void:
	combat_command_pressed.emit(command_index)


func set_dungeon_theme(theme) -> void:
	if dungeon_viewport != null:
		dungeon_viewport.set_dungeon_theme(theme)


func build_bottom_area() -> void:
	var bottom_panel: Panel = create_panel(
		Color(0.055, 0.035, 0.025, 1.0),
		Color(0.42, 0.27, 0.12, 1.0),
		3
	)
	bottom_panel.name = "BottomPanel"
	bottom_panel.anchor_left = 0.0
	bottom_panel.anchor_top = 1.0
	bottom_panel.anchor_right = 1.0
	bottom_panel.anchor_bottom = 1.0
	bottom_panel.offset_left = OUTER_MARGIN + SIDE_WIDTH + GAP
	bottom_panel.offset_top = -OUTER_MARGIN - BOTTOM_HEIGHT
	bottom_panel.offset_right = -OUTER_MARGIN - SIDE_WIDTH - GAP
	bottom_panel.offset_bottom = -OUTER_MARGIN
	main_ui_root.add_child(bottom_panel)

	var bottom_box: HBoxContainer = HBoxContainer.new()
	bottom_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	bottom_box.offset_left = 8
	bottom_box.offset_top = 8
	bottom_box.offset_right = -8
	bottom_box.offset_bottom = -8
	bottom_box.add_theme_constant_override("separation", 10)
	bottom_panel.add_child(bottom_box)

	log_panel = LogPanelUIScript.new()
	log_panel.name = "LogPanel"
	log_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	log_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	bottom_box.add_child(log_panel)

	auto_map_ui = AutoMapUIScript.new()
	auto_map_ui.name = "AutoMapUI"
	auto_map_ui.custom_minimum_size = Vector2(260, 0)
	auto_map_ui.size_flags_vertical = Control.SIZE_EXPAND_FILL
	bottom_box.add_child(auto_map_ui)


func build_creation_ui() -> void:
	creation_ui_root = Control.new()
	creation_ui_root.name = "CreationUI"
	creation_ui_root.set_anchors_preset(Control.PRESET_FULL_RECT)
	root.add_child(creation_ui_root)

	var background: Panel = create_panel(
		Color(0.035, 0.025, 0.018, 1.0),
		Color(0.48, 0.31, 0.12, 1.0),
		4
	)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.offset_left = 20
	background.offset_top = 20
	background.offset_right = -20
	background.offset_bottom = -20
	creation_ui_root.add_child(background)


func show_creation(
	hero_number: int,
	total_heroes: int,
	current_roll,
	stored_roll,
	selected_class: String,
	class_description: String,
	created_party: Array
) -> void:
	ensure_ui_ready()

	current_screen_mode = "creation"

	main_ui_root.visible = false
	creation_ui_root.visible = true

	if dungeon_viewport != null:
		dungeon_viewport.hide_commands()
		dungeon_viewport.hide_enemy()

	clear_container(creation_ui_root)

	var background: Panel = create_panel(
		Color(0.035, 0.025, 0.018, 1.0),
		Color(0.48, 0.31, 0.12, 1.0),
		4
	)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.offset_left = 20
	background.offset_top = 20
	background.offset_right = -20
	background.offset_bottom = -20
	creation_ui_root.add_child(background)

	var main_box: VBoxContainer = VBoxContainer.new()
	main_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_box.offset_left = 24
	main_box.offset_top = 18
	main_box.offset_right = -24
	main_box.offset_bottom = -18
	main_box.add_theme_constant_override("separation", 14)
	background.add_child(main_box)

	var title: Label = create_label("CRÉATION D'ÉQUIPE", 28, Color(0.95, 0.78, 0.38))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(title)

	var content_box: HBoxContainer = HBoxContainer.new()
	content_box.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content_box.add_theme_constant_override("separation", 14)
	main_box.add_child(content_box)

	var created_panel: Panel = create_panel(
		Color(0.08, 0.05, 0.03, 1.0),
		Color(0.32, 0.20, 0.08, 1.0),
		2
	)
	created_panel.custom_minimum_size = Vector2(280, 0)
	created_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content_box.add_child(created_panel)

	var created_box: VBoxContainer = VBoxContainer.new()
	created_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	created_box.offset_left = 12
	created_box.offset_top = 12
	created_box.offset_right = -12
	created_box.offset_bottom = -12
	created_box.add_theme_constant_override("separation", 10)
	created_panel.add_child(created_box)

	created_box.add_child(create_label("HÉROS CRÉÉS", 18, Color(0.95, 0.78, 0.38)))

	for i in range(total_heroes):
		if i < created_party.size():
			var hero = created_party[i]
			created_box.add_child(create_creation_hero_line(hero, i + 1))
		else:
			created_box.add_child(create_label(str(i + 1) + ". ---", 15, Color(0.50, 0.42, 0.32)))

	var current_panel: Panel = create_panel(
		Color(0.08, 0.05, 0.03, 1.0),
		Color(0.32, 0.20, 0.08, 1.0),
		2
	)
	current_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	current_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content_box.add_child(current_panel)

	var current_box: VBoxContainer = VBoxContainer.new()
	current_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	current_box.offset_left = 16
	current_box.offset_top = 14
	current_box.offset_right = -16
	current_box.offset_bottom = -14
	current_box.add_theme_constant_override("separation", 10)
	current_panel.add_child(current_box)

	current_box.add_child(create_label("Héros " + str(hero_number) + " / " + str(total_heroes), 20, Color(0.95, 0.78, 0.38)))
	current_box.add_child(create_separator())
	current_box.add_child(create_label("Classe sélectionnée : " + selected_class, 18, Color(0.95, 0.86, 0.62)))
	current_box.add_child(create_label(class_description, 15, Color(0.82, 0.74, 0.56)))
	current_box.add_child(create_separator())

	if current_roll != null:
		current_box.add_child(create_label("Roll actuel", 18, Color(0.95, 0.78, 0.38)))
		current_box.add_child(create_label(get_stats_line(current_roll), 16, Color(0.90, 0.84, 0.68)))

	if stored_roll != null:
		current_box.add_child(create_label("Roll stocké", 18, Color(0.95, 0.78, 0.38)))
		current_box.add_child(create_label(get_stats_line(stored_roll), 16, Color(0.70, 0.88, 1.0)))
	else:
		current_box.add_child(create_label("Roll stocké : aucun", 15, Color(0.55, 0.48, 0.38)))

	current_box.add_child(create_separator())

	var help_text: String = ""
	help_text += "← / → : changer de classe\n"
	help_text += "R : relancer les stats\n"
	help_text += "S : stocker le roll\n"
	help_text += "L : reprendre le roll stocké\n"
	help_text += "Entrée : confirmer ce héros"

	current_box.add_child(create_label(help_text, 15, Color(0.90, 0.82, 0.60)))


func show_exploration(
	position: Vector2i,
	facing_name: String,
	party: Array,
	log_text: String,
	layout: Array[String] = [],
	discovered_map_cells: Dictionary = {}
) -> void:
	ensure_ui_ready()

	# Mémorise l'écran précédent avant de basculer en exploration.
	# Cela permet de revenir au canal Journal après un combat,
	# même si le dernier message reçu est détecté comme un message Combat.
	var previous_screen_mode: String = current_screen_mode
	var entering_exploration: bool = previous_screen_mode != "exploration"

	current_screen_mode = "exploration"

	creation_ui_root.visible = false
	main_ui_root.visible = true

	if dungeon_viewport != null:
		dungeon_viewport.hide_enemy()
		dungeon_viewport.show_exploration_commands()

		if dungeon_viewport.has_method("update_exploration_map_data"):
			dungeon_viewport.update_exploration_map_data(
				layout,
				discovered_map_cells,
				position,
				facing_name
			)

	if party_status_ui != null:
		party_status_ui.update_party(party, null)

	if auto_map_ui != null:
		auto_map_ui.update_map(
			layout,
			discovered_map_cells,
			position,
			facing_name
		)

	var clean_log: String = log_text.strip_edges()

	if clean_log != "":
		var channel: String = log_panel.detect_log_channel(clean_log, LOG_JOURNAL)
		log_panel.add_log_message(channel, clean_log)

		if entering_exploration:
			if previous_screen_mode == "combat":
				log_panel.set_log_channel(LOG_JOURNAL)
			else:
				log_panel.set_log_channel(channel)
	elif entering_exploration:
		log_panel.add_log_message(LOG_JOURNAL, "Le donjon est silencieux.")
		log_panel.set_log_channel(LOG_JOURNAL)


func show_combat(
	enemy,
	party: Array,
	log_text: String,
	active_hero,
	commands: Array[String],
	selected_command_index: int,
	layout: Array[String] = [],
	discovered_map_cells: Dictionary = {},
	position: Vector2i = Vector2i.ZERO,
	facing_name: String = "",
	dodge_feedback_hero = null
) -> void:
	ensure_ui_ready()

	var entering_combat: bool = current_screen_mode != "combat"
	current_screen_mode = "combat"

	creation_ui_root.visible = false
	main_ui_root.visible = true

	if party_status_ui != null:
		party_status_ui.update_party(
			party,
			active_hero,
			dodge_feedback_hero
		)

	if dungeon_viewport != null:
		if dungeon_viewport.has_method("close_exploration_map_overlay"):
			dungeon_viewport.close_exploration_map_overlay(false)

		dungeon_viewport.show_combat_commands(
			commands,
			selected_command_index
		)

	var clean_log: String = log_text.strip_edges()

	if clean_log != "":
		log_panel.add_log_message(LOG_COMBAT, clean_log)
	elif entering_combat:
		log_panel.add_log_message(LOG_COMBAT, "Le combat commence.")

	if entering_combat:
		log_panel.set_log_channel(LOG_COMBAT)

	if enemy != null:
		if dungeon_viewport != null:
			dungeon_viewport.show_enemy(enemy)
	else:
		if dungeon_viewport != null:
			dungeon_viewport.hide_enemy()

	if dungeon_viewport != null:
		dungeon_viewport.update_party_damage_feedback(party)

	if auto_map_ui != null:
		auto_map_ui.update_map(
			layout,
			discovered_map_cells,
			position,
			facing_name
		)


func create_creation_hero_line(hero, number: int) -> Control:
	var panel: Panel = create_panel(
		Color(0.11, 0.07, 0.04, 1.0),
		Color(0.25, 0.16, 0.07, 1.0),
		2
	)
	panel.custom_minimum_size = Vector2(0, 62)

	var label: Label = create_label("", 14, Color(0.88, 0.80, 0.62))
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.offset_left = 8
	label.offset_top = 6
	label.offset_right = -8
	label.offset_bottom = -6

	var short_class: String = ClassDatabaseScript.get_short_name(hero.job)

	label.text = str(number) + ". " + hero.character_name + " [" + short_class + "]"
	label.text += "\nHP " + str(hero.max_hp) + " MP " + str(hero.max_mp)
	label.text += " NIV " + str(hero.level)

	panel.add_child(label)

	return panel


func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	var panel: Panel = Panel.new()

	panel.add_theme_stylebox_override(
		"panel",
		UIFrameStyleScript.create_panel_style(
			background_color,
			border_color,
			border_width
		)
	)

	return panel


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


func create_separator() -> HSeparator:
	var separator: HSeparator = HSeparator.new()
	separator.custom_minimum_size = Vector2(0, 6)

	return separator


func clear_container(container: Node) -> void:
	if container == null:
		return

	for child in container.get_children():
		child.free()


func ensure_ui_ready() -> void:
	if root == null:
		build_ui()


func get_stats_line(stats) -> String:
	if stats == null:
		return ""

	var total: int = stats.strength
	total += stats.agility
	total += stats.endurance
	total += stats.magic_power

	var text: String = ""

	text += "FOR " + str(stats.strength)
	text += " AGI " + str(stats.agility)
	text += " END " + str(stats.endurance)
	text += " MAG " + str(stats.magic_power)
	text += " TOTAL " + str(total)

	return text


func has_pending_damage_acknowledgement() -> bool:
	if party_status_ui == null:
		return false

	if not party_status_ui.has_method("has_pending_damage_acknowledgement"):
		return false

	return party_status_ui.has_pending_damage_acknowledgement()


func acknowledge_damage_portraits() -> void:
	if party_status_ui == null:
		return

	if not party_status_ui.has_method("acknowledge_damage_portraits"):
		return

	party_status_ui.acknowledge_damage_portraits()
