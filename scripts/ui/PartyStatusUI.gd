extends Control

class_name PartyStatusUI

# ------------------------------------------------------------
# DÉPENDANCES
# Charge le composant de portrait utilisé dans chaque panneau héros.
# ------------------------------------------------------------

const HeroPortraitUIScript = preload("res://scripts/ui/HeroPortraitUI.gd")


# ------------------------------------------------------------
# PARAMÈTRES DE LAYOUT
# Les colonnes héros occupent toute la hauteur latérale de l’écran.
# ------------------------------------------------------------

const OUTER_MARGIN: float = 10.0
const SIDE_WIDTH: float = 210.0
const HERO_PANEL_GAP: float = 10.0

const PORTRAIT_FRAME_SIZE: Vector2 = Vector2(190.0, 190.0)
const PORTRAIT_FRAME_PADDING: float = -12.0
const PORTRAIT_FRAME_BORDER_WIDTH: int = 2
const PORTRAIT_FRAME_BACKGROUND_COLOR: Color = Color(0.025, 0.018, 0.014, 1.0)
const PORTRAIT_FRAME_BORDER_COLOR: Color = Color(0.46, 0.29, 0.12, 1.0)

const BAR_HEIGHT: float = 15.0


# ------------------------------------------------------------
# COULEURS PRINCIPALES
# Définit l’apparence des panneaux selon leur état.
# ------------------------------------------------------------

const PANEL_BACKGROUND_COLOR: Color = Color(0.075, 0.048, 0.030, 0.96)
const PANEL_DEAD_BACKGROUND_COLOR: Color = Color(0.035, 0.028, 0.026, 0.96)

const BORDER_NORMAL_COLOR: Color = Color(0.38, 0.24, 0.10, 1.0)
const BORDER_ACTIVE_COLOR: Color = Color(1.00, 0.78, 0.25, 1.0)
const BORDER_DAMAGE_COLOR: Color = Color(0.95, 0.16, 0.10, 1.0)
const BORDER_DEAD_COLOR: Color = Color(0.34, 0.08, 0.07, 1.0)

const NAME_NORMAL_COLOR: Color = Color(0.94, 0.82, 0.58, 1.0)
const NAME_ACTIVE_COLOR: Color = Color(1.00, 0.88, 0.45, 1.0)
const NAME_DAMAGE_COLOR: Color = Color(1.00, 0.35, 0.28, 1.0)
const NAME_DEAD_COLOR: Color = Color(0.60, 0.23, 0.20, 1.0)

const TEXT_NORMAL_COLOR: Color = Color(0.78, 0.68, 0.50, 1.0)
const TEXT_MUTED_COLOR: Color = Color(0.48, 0.42, 0.35, 1.0)

const DAMAGE_FLASH_COLOR: Color = Color(1.0, 0.08, 0.04, 0.72)
const DAMAGE_FLASH_CLEAR_COLOR: Color = Color(1.0, 0.08, 0.04, 0.0)

const DODGE_FLASH_COLOR: Color = Color(1.0, 1.0, 1.0, 0.95)
const DODGE_FLASH_CLEAR_COLOR: Color = Color(1.0, 1.0, 1.0, 0.0)


# ------------------------------------------------------------
# NŒUDS UI
# Contient les deux colonnes latérales des héros.
# ------------------------------------------------------------

var left_hero_column: VBoxContainer = null
var right_hero_column: VBoxContainer = null

var ui_built: bool = false


# ------------------------------------------------------------
# ÉTAT DES FEEDBACKS
# Mémorise les HP précédents et les portraits damage en attente.
# ------------------------------------------------------------

var last_hero_hp_by_key: Dictionary = {}
var pending_damage_keys: Dictionary = {}


# ------------------------------------------------------------
# INITIALISATION
# ------------------------------------------------------------

func _ready() -> void:
	build_ui()


# ------------------------------------------------------------
# CONSTRUCTION UI
# Crée deux colonnes qui descendent jusqu’en bas de l’écran.
# ------------------------------------------------------------

func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	mouse_filter = Control.MOUSE_FILTER_IGNORE
	set_anchors_preset(Control.PRESET_FULL_RECT)

	build_left_column()
	build_right_column()


func build_left_column() -> void:
	left_hero_column = VBoxContainer.new()
	left_hero_column.name = "LeftHeroColumn"
	left_hero_column.anchor_left = 0.0
	left_hero_column.anchor_top = 0.0
	left_hero_column.anchor_right = 0.0
	left_hero_column.anchor_bottom = 1.0
	left_hero_column.offset_left = OUTER_MARGIN
	left_hero_column.offset_top = OUTER_MARGIN
	left_hero_column.offset_right = OUTER_MARGIN + SIDE_WIDTH
	left_hero_column.offset_bottom = -OUTER_MARGIN
	left_hero_column.add_theme_constant_override("separation", int(HERO_PANEL_GAP))
	left_hero_column.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(left_hero_column)


func build_right_column() -> void:
	right_hero_column = VBoxContainer.new()
	right_hero_column.name = "RightHeroColumn"
	right_hero_column.anchor_left = 1.0
	right_hero_column.anchor_top = 0.0
	right_hero_column.anchor_right = 1.0
	right_hero_column.anchor_bottom = 1.0
	right_hero_column.offset_left = -OUTER_MARGIN - SIDE_WIDTH
	right_hero_column.offset_top = OUTER_MARGIN
	right_hero_column.offset_right = -OUTER_MARGIN
	right_hero_column.offset_bottom = -OUTER_MARGIN
	right_hero_column.add_theme_constant_override("separation", int(HERO_PANEL_GAP))
	right_hero_column.mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_child(right_hero_column)


# ------------------------------------------------------------
# MISE À JOUR DU GROUPE
# Reconstruit les panneaux héros et déclenche les feedbacks visuels.
# ------------------------------------------------------------

# Reconstruit les panneaux héros.
# Les états visuels sont suivis par slot d'équipe, et non par nom de héros,
# afin d'éviter les collisions quand plusieurs héros ont le même nom.
func update_party(
	party: Array,
	active_hero,
	dodge_feedback_hero = null
) -> void:
	ensure_ui_ready()

	if left_hero_column == null:
		return

	if right_hero_column == null:
		return

	var newly_damaged_keys: Dictionary = detect_new_damage(party)
	var active_hero_key: String = get_hero_key_from_party_slot(active_hero, party)
	var dodge_feedback_key: String = get_hero_key_from_party_slot(dodge_feedback_hero, party)

	clear_container(left_hero_column)
	clear_container(right_hero_column)

	for i in range(4):
		var hero = null
		var hero_key: String = get_party_slot_key(i)
		var should_flash_damage: bool = false
		var should_show_damage_portrait: bool = false
		var should_flash_dodge: bool = false

		if i < party.size():
			hero = party[i]

			should_flash_damage = newly_damaged_keys.has(hero_key)
			should_show_damage_portrait = pending_damage_keys.has(hero_key)

			if dodge_feedback_key != "":
				should_flash_dodge = hero_key == dodge_feedback_key

		var hero_panel: Panel = create_hero_panel(
			hero,
			i,
			active_hero_key,
			should_flash_damage,
			should_show_damage_portrait,
			should_flash_dodge
		)

		if i == 0 or i == 1:
			left_hero_column.add_child(hero_panel)
		else:
			right_hero_column.add_child(hero_panel)


# Détecte les pertes de PV depuis la dernière mise à jour UI.
# Le suivi utilise le slot d'équipe pour que deux héros portant le même nom
# ne partagent pas le même état de dégâts.
func detect_new_damage(party: Array) -> Dictionary:
	var newly_damaged_keys: Dictionary = {}
	var current_keys: Dictionary = {}

	for i in range(party.size()):
		var hero = party[i]

		if hero == null:
			continue

		var hero_key: String = get_party_slot_key(i)

		current_keys[hero_key] = true

		var current_hp: int = get_int_property(hero, "hp", 0)

		if last_hero_hp_by_key.has(hero_key):
			var previous_hp: int = int(last_hero_hp_by_key[hero_key])

			if current_hp < previous_hp:
				newly_damaged_keys[hero_key] = true
				pending_damage_keys[hero_key] = true

		last_hero_hp_by_key[hero_key] = current_hp

	remove_missing_hero_keys(current_keys)

	return newly_damaged_keys


func remove_missing_hero_keys(current_keys: Dictionary) -> void:
	var hp_keys_to_remove: Array = []

	for key in last_hero_hp_by_key.keys():
		if not current_keys.has(key):
			hp_keys_to_remove.append(key)

	for key in hp_keys_to_remove:
		last_hero_hp_by_key.erase(key)

	var damage_keys_to_remove: Array = []

	for key in pending_damage_keys.keys():
		if not current_keys.has(key):
			damage_keys_to_remove.append(key)

	for key in damage_keys_to_remove:
		pending_damage_keys.erase(key)


# ------------------------------------------------------------
# PANNEAU HÉROS
# Crée un panneau vertical : nom, classe/niveau, portrait, barres HP/MP.
# ------------------------------------------------------------

func create_hero_panel(
	hero,
	index: int,
	active_hero_key: String,
	should_flash_damage: bool,
	should_show_damage_portrait: bool,
	should_flash_dodge: bool
) -> Panel:
	var is_empty: bool = hero == null
	var hero_key: String = get_party_slot_key(index)

	var is_dead: bool = false

	if not is_empty:
		is_dead = not is_hero_alive(hero)

	var is_damage_focus: bool = false

	if hero_key != "":
		is_damage_focus = pending_damage_keys.has(hero_key)

	var is_active_turn: bool = false

	if hero_key != "":
		is_active_turn = hero_key == active_hero_key

	if is_damage_focus:
		is_active_turn = false

	var background_color: Color = PANEL_BACKGROUND_COLOR
	var border_color: Color = BORDER_NORMAL_COLOR
	var border_width: int = 2

	if is_dead:
		background_color = PANEL_DEAD_BACKGROUND_COLOR
		border_color = BORDER_DEAD_COLOR
		border_width = 2

	if is_active_turn:
		border_color = BORDER_ACTIVE_COLOR
		border_width = 4

	if is_damage_focus:
		border_color = BORDER_DAMAGE_COLOR
		border_width = 4

	var panel: Panel = create_panel(
		background_color,
		border_color,
		border_width
	)

	panel.name = "HeroPanel" + str(index + 1)
	panel.custom_minimum_size = Vector2(SIDE_WIDTH, 0)
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var content: VBoxContainer = VBoxContainer.new()
	content.set_anchors_preset(Control.PRESET_FULL_RECT)
	content.offset_left = 10
	content.offset_top = 10
	content.offset_right = -10
	content.offset_bottom = -10
	content.add_theme_constant_override("separation", 6)
	content.alignment = BoxContainer.ALIGNMENT_BEGIN
	content.mouse_filter = Control.MOUSE_FILTER_IGNORE

	panel.add_child(content)

	if is_empty:
		fill_empty_panel(content, index)
	else:
		fill_hero_info(
			content,
			hero,
			is_active_turn,
			is_damage_focus,
			is_dead,
			should_show_damage_portrait
		)

	if should_flash_damage:
		add_damage_flash(panel)

	if should_flash_dodge:
		add_dodge_flash(panel)

	return panel


func fill_empty_panel(
	content: VBoxContainer,
	index: int
) -> void:
	add_centered_spacer(content)

	var name_label: Label = create_label(
		"Héros " + str(index + 1),
		15,
		TEXT_MUTED_COLOR
	)

	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	content.add_child(name_label)

	var empty_label: Label = create_label(
		"---",
		14,
		TEXT_MUTED_COLOR
	)

	empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	content.add_child(empty_label)

	add_centered_spacer(content)


func fill_hero_info(
	content: VBoxContainer,
	hero,
	is_active_turn: bool,
	is_damage_focus: bool,
	is_dead: bool,
	should_show_damage_portrait: bool
) -> void:
	var name_color: Color = NAME_NORMAL_COLOR

	if is_active_turn:
		name_color = NAME_ACTIVE_COLOR

	if is_damage_focus:
		name_color = NAME_DAMAGE_COLOR

	if is_dead and not is_damage_focus:
		name_color = NAME_DEAD_COLOR

	var hero_name: String = get_string_property(hero, "character_name", "Héros")
	var hero_class: String = get_hero_class_name(hero)
	var level: int = get_int_property(hero, "level", 1)

	var top_box: VBoxContainer = VBoxContainer.new()
	top_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	top_box.size_flags_vertical = Control.SIZE_SHRINK_BEGIN
	top_box.custom_minimum_size = Vector2(0, 54)
	top_box.add_theme_constant_override("separation", 2)
	top_box.mouse_filter = Control.MOUSE_FILTER_IGNORE

	content.add_child(top_box)

	var name_label: Label = create_label(
		hero_name,
		20,
		name_color
	)

	name_label.custom_minimum_size = Vector2(0, 32)
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	name_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	name_label.clip_text = false

	top_box.add_child(name_label)

	var class_level_text: String = hero_class + " Niv. " + str(level)

	if is_dead:
		class_level_text += " K.O."

	var class_level_label: Label = create_label(
		class_level_text,
		12,
		TEXT_NORMAL_COLOR
	)

	class_level_label.custom_minimum_size = Vector2(0, 18)
	class_level_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	class_level_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	class_level_label.text_overrun_behavior = TextServer.OVERRUN_TRIM_ELLIPSIS
	class_level_label.clip_text = true

	if is_dead:
		class_level_label.add_theme_color_override("font_color", NAME_DEAD_COLOR)

	top_box.add_child(class_level_label)

	var portrait_area: Control = Control.new()
	portrait_area.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	portrait_area.size_flags_vertical = Control.SIZE_EXPAND_FILL
	portrait_area.mouse_filter = Control.MOUSE_FILTER_IGNORE

	content.add_child(portrait_area)

	var portrait_holder: Control = create_portrait_holder(
		hero,
		should_show_damage_portrait
	)

	portrait_holder.anchor_left = 0.5
	portrait_holder.anchor_top = 0.5
	portrait_holder.anchor_right = 0.5
	portrait_holder.anchor_bottom = 0.5
	portrait_holder.offset_left = -PORTRAIT_FRAME_SIZE.x * 0.5
	portrait_holder.offset_top = -PORTRAIT_FRAME_SIZE.y * 0.5
	portrait_holder.offset_right = PORTRAIT_FRAME_SIZE.x * 0.5
	portrait_holder.offset_bottom = PORTRAIT_FRAME_SIZE.y * 0.5

	portrait_area.add_child(portrait_holder)

	var bars_box: VBoxContainer = VBoxContainer.new()
	bars_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bars_box.size_flags_vertical = Control.SIZE_SHRINK_END
	bars_box.add_theme_constant_override("separation", 5)
	bars_box.mouse_filter = Control.MOUSE_FILTER_IGNORE

	content.add_child(bars_box)

	var hp_bar: ProgressBar = create_bar(
		Color(0.68, 0.12, 0.08, 1.0),
		Color(0.10, 0.035, 0.025, 1.0)
	)

	hp_bar.max_value = max(1, get_int_property(hero, "max_hp", 1))
	hp_bar.value = clamp(
		get_int_property(hero, "hp", 0),
		0,
		int(hp_bar.max_value)
	)

	bars_box.add_child(hp_bar)

	var mp_bar: ProgressBar = create_bar(
		Color(0.18, 0.28, 0.82, 1.0),
		Color(0.03, 0.04, 0.10, 1.0)
	)

	mp_bar.max_value = max(1, get_int_property(hero, "max_mp", 1))
	mp_bar.value = clamp(
		get_int_property(hero, "mp", 0),
		0,
		int(mp_bar.max_value)
	)

	bars_box.add_child(mp_bar)


func create_portrait_holder(
	hero,
	should_show_damage_portrait: bool
) -> Control:
	var holder: Panel = Panel.new()
	holder.custom_minimum_size = PORTRAIT_FRAME_SIZE
	holder.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var frame_style: StyleBoxFlat = StyleBoxFlat.new()
	frame_style.bg_color = PORTRAIT_FRAME_BACKGROUND_COLOR
	frame_style.border_color = PORTRAIT_FRAME_BORDER_COLOR
	frame_style.set_border_width_all(PORTRAIT_FRAME_BORDER_WIDTH)
	frame_style.corner_radius_top_left = 2
	frame_style.corner_radius_top_right = 2
	frame_style.corner_radius_bottom_left = 2
	frame_style.corner_radius_bottom_right = 2

	holder.add_theme_stylebox_override("panel", frame_style)

	if hero == null:
		return holder

	var portrait = HeroPortraitUIScript.new()
	portrait.name = "HeroPortrait"
	portrait.anchor_left = 0.0
	portrait.anchor_top = 0.0
	portrait.anchor_right = 1.0
	portrait.anchor_bottom = 1.0
	portrait.offset_left = PORTRAIT_FRAME_PADDING
	portrait.offset_top = PORTRAIT_FRAME_PADDING
	portrait.offset_right = -PORTRAIT_FRAME_PADDING
	portrait.offset_bottom = -PORTRAIT_FRAME_PADDING
	portrait.mouse_filter = Control.MOUSE_FILTER_IGNORE

	holder.add_child(portrait)

	if portrait.has_method("setup_for_hero"):
		portrait.setup_for_hero(hero, should_show_damage_portrait)

	return holder


# ------------------------------------------------------------
# FEEDBACKS VISUELS
# Affiche les flashs de dégâts et d’esquive.
# ------------------------------------------------------------

func add_damage_flash(panel: Panel) -> void:
	var flash_overlay: ColorRect = ColorRect.new()
	flash_overlay.name = "DamageFlashOverlay"
	flash_overlay.color = DAMAGE_FLASH_COLOR
	flash_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	flash_overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE

	panel.add_child(flash_overlay)

	var tween: Tween = panel.create_tween()

	tween.tween_property(
		flash_overlay,
		"color",
		DAMAGE_FLASH_CLEAR_COLOR,
		0.12
	)

	tween.tween_property(
		flash_overlay,
		"color",
		DAMAGE_FLASH_COLOR,
		0.08
	)

	tween.tween_property(
		flash_overlay,
		"color",
		DAMAGE_FLASH_CLEAR_COLOR,
		0.18
	)

	tween.tween_callback(flash_overlay.queue_free)


func add_dodge_flash(panel: Panel) -> void:
	var flash_frame: Panel = Panel.new()
	flash_frame.name = "DodgeFlashFrame"
	flash_frame.set_anchors_preset(Control.PRESET_FULL_RECT)
	flash_frame.mouse_filter = Control.MOUSE_FILTER_IGNORE
	flash_frame.modulate = DODGE_FLASH_COLOR

	panel.add_child(flash_frame)

	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color(1.0, 1.0, 1.0, 0.0)
	style.border_color = Color(1.0, 1.0, 1.0, 1.0)
	style.set_border_width_all(5)
	style.corner_radius_top_left = 2
	style.corner_radius_top_right = 2
	style.corner_radius_bottom_left = 2
	style.corner_radius_bottom_right = 2

	flash_frame.add_theme_stylebox_override("panel", style)

	var tween: Tween = panel.create_tween()

	tween.tween_property(
		flash_frame,
		"modulate",
		DODGE_FLASH_CLEAR_COLOR,
		0.32
	)

	tween.tween_callback(flash_frame.queue_free)


# ------------------------------------------------------------
# VALIDATION DES DÉGÂTS
# Permet au contrôleur d’input de savoir si un portrait damage est bloqué.
# ------------------------------------------------------------

func has_pending_damage_acknowledgement() -> bool:
	return not pending_damage_keys.is_empty()


func acknowledge_damage_portraits() -> void:
	pending_damage_keys.clear()


# ------------------------------------------------------------
# COMPOSANTS UI
# Crée les panneaux, labels, portraits et barres utilisés par les héros.
# ------------------------------------------------------------

func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	var panel: Panel = Panel.new()
	var style: StyleBoxFlat = StyleBoxFlat.new()

	style.bg_color = background_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.corner_radius_top_left = 2
	style.corner_radius_top_right = 2
	style.corner_radius_bottom_left = 2
	style.corner_radius_bottom_right = 2

	panel.add_theme_stylebox_override("panel", style)

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
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE

	return label


func create_bar(
	fill_color: Color,
	background_color: Color
) -> ProgressBar:
	var bar: ProgressBar = ProgressBar.new()
	bar.custom_minimum_size = Vector2(0, BAR_HEIGHT)
	bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	bar.show_percentage = false
	bar.min_value = 0
	bar.max_value = 1
	bar.value = 1
	bar.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var background_style: StyleBoxFlat = StyleBoxFlat.new()
	background_style.bg_color = background_color
	background_style.corner_radius_top_left = 1
	background_style.corner_radius_top_right = 1
	background_style.corner_radius_bottom_left = 1
	background_style.corner_radius_bottom_right = 1

	var fill_style: StyleBoxFlat = StyleBoxFlat.new()
	fill_style.bg_color = fill_color
	fill_style.corner_radius_top_left = 1
	fill_style.corner_radius_top_right = 1
	fill_style.corner_radius_bottom_left = 1
	fill_style.corner_radius_bottom_right = 1

	bar.add_theme_stylebox_override("background", background_style)
	bar.add_theme_stylebox_override("fill", fill_style)

	return bar


func add_centered_spacer(content: VBoxContainer) -> void:
	var spacer: Control = Control.new()
	spacer.size_flags_vertical = Control.SIZE_EXPAND_FILL

	content.add_child(spacer)


# ------------------------------------------------------------
# ÉTAT DES HÉROS
# Lit les informations nécessaires aux panneaux de statut.
# ------------------------------------------------------------

# Retourne une clé stable basée sur la position du héros dans l'équipe.
# Cela évite les collisions entre plusieurs héros ayant le même nom.
func get_party_slot_key(index: int) -> String:
	return "party_slot_" + str(index)


# Retrouve la clé de slot correspondant à un héros donné.
# Utilisé pour savoir quel panneau doit être marqué comme actif ou en esquive.
func get_hero_key_from_party_slot(hero, party: Array) -> String:
	if hero == null:
		return ""

	for i in range(party.size()):
		if party[i] == hero:
			return get_party_slot_key(i)

	return get_hero_key(hero)


func get_hero_display_name(hero) -> String:
	if hero == null:
		return "Héros"

	var possible_property_names: Array[String] = [
		"character_name",
		"hero_name",
		"display_name",
		"name"
	]

	for property_name in possible_property_names:
		var value: String = get_string_property(hero, property_name, "")

		if value.strip_edges() != "":
			return value

	return "Héros"


func is_hero_alive(hero) -> bool:
	if hero == null:
		return false

	if hero.has_method("is_alive"):
		return hero.is_alive()

	return get_int_property(hero, "hp", 0) > 0


# Conserve une clé de secours basée sur le nom ou l'instance.
# La logique principale de l'UI utilise désormais les slots d'équipe.
func get_hero_key(hero) -> String:
	if hero == null:
		return ""

	var character_name: String = get_string_property(hero, "character_name", "")

	if character_name != "":
		return character_name

	if hero is Object:
		return str(hero.get_instance_id())

	return str(hero)


func get_hero_class_name(hero) -> String:
	if hero == null:
		return "Classe"

	var job_name: String = get_string_property(hero, "job", "")

	if job_name != "":
		return job_name

	var hero_class_name: String = get_string_property(hero, "class_name", "")

	if hero_class_name != "":
		return hero_class_name

	return "Classe"


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les champs sans dépendre trop strictement de CharacterData.
# ------------------------------------------------------------

func get_int_property(
	target,
	property_name: String,
	default_value: int = 0
) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


func get_string_property(
	target,
	property_name: String,
	default_value: String = ""
) -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func object_has_property(
	target,
	property_name: String
) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false


# ------------------------------------------------------------
# HELPERS GÉNÉRIQUES
# Garde la reconstruction UI sûre et répétable.
# ------------------------------------------------------------

func clear_container(container: Node) -> void:
	if container == null:
		return

	for child in container.get_children():
		child.free()


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
