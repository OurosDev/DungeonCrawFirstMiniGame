extends Control
class_name PartyCreationUI

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à la création des héros.
# ------------------------------------------------------------

const CharacterDataScript = preload("res://scripts/characters/CharacterData.gd")
const StatRollerScript = preload("res://scripts/characters/StatRoller.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")


# ------------------------------------------------------------
# SCÈNES
# Définit les chemins utilisés après la création ou le retour menu.
# ------------------------------------------------------------

const DUNGEON_SCENE_PATH: String = "res://scenes/Dungeon.tscn"
const MAIN_MENU_SCENE_PATH: String = "res://scenes/MainMenu.tscn"


# ------------------------------------------------------------
# CONFIGURATION — COULEURS DES ROLLS
# Définit les seuils visuels des caractéristiques à la création.
# ------------------------------------------------------------

const ROLL_STAT_MAX_VALUE: int = 10
const ROLL_STAT_WEAK_VALUE: int = 4
const ROLL_STAT_AVERAGE_VALUE: int = 5

const ROLL_STAT_DEFAULT_COLOR_HEX: String = "#DBBE99"
const ROLL_STAT_MAX_COLOR_HEX: String = "#64E070"
const ROLL_STAT_AVERAGE_COLOR_HEX: String = "#F2D14E"
const ROLL_STAT_WEAK_COLOR_HEX: String = "#E05A4F"


# ------------------------------------------------------------
# ÉTAT DE CRÉATION
# Stocke l’avancement de la création de l’équipe.
# ------------------------------------------------------------

var stat_roller = null
var available_classes: Array[String] = []
var created_party: Array = []

var current_hero_index: int = 0
var current_stats = null
var stored_stats = null
var selected_class_name: String = ""


# ------------------------------------------------------------
# NŒUDS UI
# Contient les références vers les éléments de l’interface.
# ------------------------------------------------------------

var root_panel: Panel = null
var main_box: VBoxContainer = null

var title_label: Label = null
var hero_label: Label = null
var roll_label: RichTextLabel = null
var stored_roll_label: RichTextLabel = null
var class_description_label: Label = null
var party_summary_label: Label = null

var class_buttons_box: HBoxContainer = null

var reroll_button: Button = null
var store_button: Button = null
var restore_button: Button = null
var validate_button: Button = null
var back_to_menu_button: Button = null

var help_tooltip_panel: Panel = null
var help_tooltip_label: Label = null


func _ready() -> void:
	randomize()

	stat_roller = StatRollerScript.new()
	available_classes = ClassDatabaseScript.get_available_class_names()

	build_ui()
	start_current_hero()


# ------------------------------------------------------------
# CONSTRUCTION UI
# Crée l’interface de création d’équipe.
# ------------------------------------------------------------

func build_ui() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_STOP

	root_panel = create_panel(
		Color(0.045, 0.030, 0.022, 1.0),
		Color(0.42, 0.27, 0.12, 1.0),
		4
	)
	root_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_panel.offset_left = 24
	root_panel.offset_top = 24
	root_panel.offset_right = -24
	root_panel.offset_bottom = -24
	add_child(root_panel)

	main_box = VBoxContainer.new()
	main_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_box.offset_left = 24
	main_box.offset_top = 20
	main_box.offset_right = -24
	main_box.offset_bottom = -20
	main_box.add_theme_constant_override("separation", 14)
	root_panel.add_child(main_box)

	title_label = create_label(
		"CRÉATION DE L'ÉQUIPE",
		28,
		Color(1.0, 0.82, 0.35)
	)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(title_label)

	back_to_menu_button = create_button("Retour au menu")
	back_to_menu_button.custom_minimum_size = Vector2(180, 34)
	back_to_menu_button.pressed.connect(on_back_to_menu_pressed)
	main_box.add_child(back_to_menu_button)

	hero_label = create_label(
		"",
		20,
		Color(0.92, 0.82, 0.58)
	)
	hero_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(hero_label)

	roll_label = create_rich_label(
		"",
		18,
		Color(0.86, 0.78, 0.62),
		28
	)
	main_box.add_child(roll_label)

	var roll_buttons_box: HBoxContainer = HBoxContainer.new()
	roll_buttons_box.alignment = BoxContainer.ALIGNMENT_CENTER
	roll_buttons_box.add_theme_constant_override("separation", 12)
	main_box.add_child(roll_buttons_box)

	reroll_button = create_button("Relancer")
	reroll_button.pressed.connect(reroll_current_stats)
	attach_help_tooltip(
		reroll_button,
		"Relance les stats affichées.\nLe roll actuel est remplacé."
	)
	roll_buttons_box.add_child(reroll_button)

	store_button = create_button("Stocker")
	store_button.pressed.connect(store_current_roll)
	attach_help_tooltip(
		store_button,
		"Garde le roll actuel en réserve.\nUtile pour comparer avant de choisir."
	)
	roll_buttons_box.add_child(store_button)

	restore_button = create_button("Reprendre")
	restore_button.pressed.connect(restore_stored_roll)
	attach_help_tooltip(
		restore_button,
		"Remplace les stats actuelles\npar le roll stocké."
	)
	roll_buttons_box.add_child(restore_button)

	stored_roll_label = create_rich_label(
		"",
		15,
		Color(0.65, 0.58, 0.46),
		24
	)
	main_box.add_child(stored_roll_label)

	var separator_1: HSeparator = HSeparator.new()
	main_box.add_child(separator_1)

	var class_title: Label = create_label(
		"CLASSE",
		18,
		Color(0.95, 0.76, 0.34)
	)
	class_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(class_title)

	class_buttons_box = HBoxContainer.new()
	class_buttons_box.alignment = BoxContainer.ALIGNMENT_CENTER
	class_buttons_box.add_theme_constant_override("separation", 10)
	main_box.add_child(class_buttons_box)

	for job_name in available_classes:
		var current_job_name: String = job_name
		var class_button: Button = create_button(current_job_name)
		class_button.pressed.connect(func(): select_class(current_job_name))
		class_buttons_box.add_child(class_button)

	class_description_label = create_label(
		"",
		15,
		Color(0.76, 0.70, 0.58)
	)
	class_description_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	class_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	class_description_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	main_box.add_child(class_description_label)

	var separator_2: HSeparator = HSeparator.new()
	main_box.add_child(separator_2)

	party_summary_label = create_label(
		"",
		15,
		Color(0.80, 0.74, 0.62)
	)
	party_summary_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(party_summary_label)

	validate_button = create_button("Valider ce héros")
	validate_button.custom_minimum_size = Vector2(240, 44)
	validate_button.pressed.connect(validate_current_hero)
	main_box.add_child(validate_button)

	build_help_tooltip()


# ------------------------------------------------------------
# NAVIGATION
# Gère le retour au menu principal.
# ------------------------------------------------------------

func on_back_to_menu_pressed() -> void:
	GameSession.prepare_new_game()
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		on_back_to_menu_pressed()


func _process(_delta: float) -> void:
	if help_tooltip_panel == null:
		return

	if not help_tooltip_panel.visible:
		return

	update_help_tooltip_position()


# ------------------------------------------------------------
# CYCLE DE CRÉATION
# Lance un nouveau héros, relance les stats et valide la sélection.
# ------------------------------------------------------------

func start_current_hero() -> void:
	current_stats = stat_roller.roll_stats()
	stored_stats = null

	if available_classes.is_empty():
		selected_class_name = ""
	else:
		selected_class_name = available_classes[0]

	update_ui()


func reroll_current_stats() -> void:
	current_stats = stat_roller.roll_stats()
	update_ui()


func store_current_roll() -> void:
	if current_stats == null:
		return

	if current_stats.has_method("create_copy"):
		stored_stats = current_stats.create_copy()
	else:
		stored_stats = current_stats

	update_ui()


func restore_stored_roll() -> void:
	if stored_stats == null:
		return

	if stored_stats.has_method("create_copy"):
		current_stats = stored_stats.create_copy()
	else:
		current_stats = stored_stats

	update_ui()


func select_class(job_name: String) -> void:
	selected_class_name = ClassDatabaseScript.normalize_class_name(job_name)
	update_ui()


func validate_current_hero() -> void:
	if current_stats == null:
		return

	if selected_class_name == "":
		return

	var hero = create_hero_from_current_selection()

	created_party.append(hero)
	current_hero_index += 1

	if current_hero_index >= 4:
		finish_party_creation()
		return

	start_current_hero()


# ------------------------------------------------------------
# CRÉATION DES HÉROS
# Crée CharacterData et attribue un nom par défaut selon la classe.
# ------------------------------------------------------------

func create_hero_from_current_selection():
	var hero = CharacterDataScript.new()

	hero.character_name = get_default_hero_name_for_class(selected_class_name)
	hero.job = ClassDatabaseScript.normalize_class_name(selected_class_name)
	hero.level = 1

	if object_has_property(hero, "exp"):
		hero.exp = 0

	if current_stats != null:
		if current_stats.has_method("create_copy"):
			hero.stats = current_stats.create_copy()
		else:
			hero.stats = current_stats

	if hero.has_method("recalculate_derived_stats"):
		hero.recalculate_derived_stats()

	if object_has_property(hero, "max_hp"):
		hero.hp = hero.max_hp

	if object_has_property(hero, "max_mp"):
		hero.mp = hero.max_mp

	return hero


func get_default_hero_name_for_class(job_name: String) -> String:
	var normalized_job_name: String = ClassDatabaseScript.normalize_class_name(job_name)

	if normalized_job_name == ClassDatabaseScript.JOB_WARRIOR:
		return "Ardan"

	if normalized_job_name == ClassDatabaseScript.JOB_THIEF:
		return "Nyra"

	if normalized_job_name == ClassDatabaseScript.JOB_MAGE:
		return "Mira"

	if normalized_job_name == ClassDatabaseScript.JOB_CLERIC:
		return "Eldric"

	return "Héros " + str(current_hero_index + 1)


func finish_party_creation() -> void:
	GameSession.set_party(created_party)
	get_tree().change_scene_to_file(DUNGEON_SCENE_PATH)


# ------------------------------------------------------------
# MISE À JOUR UI
# Rafraîchit les textes, boutons et résumé de l’équipe.
# ------------------------------------------------------------

func update_ui() -> void:
	hero_label.text = "HÉROS " + str(current_hero_index + 1) + " / 4"

	if current_stats != null:
		roll_label.text = build_colored_roll_text(current_stats)
	else:
		roll_label.text = ""

	if stored_stats != null:
		stored_roll_label.text = "Roll stocké : " + build_colored_roll_text(stored_stats)
	else:
		stored_roll_label.text = "Aucun roll stocké."

	if selected_class_name != "":
		class_description_label.text = ClassDatabaseScript.get_class_description(selected_class_name)
	else:
		class_description_label.text = ""

	update_class_buttons()
	update_party_summary()


func update_class_buttons() -> void:
	if class_buttons_box == null:
		return

	for child in class_buttons_box.get_children():
		if not child is Button:
			continue

		var button: Button = child

		if button.text == selected_class_name:
			button.disabled = true
		else:
			button.disabled = false


func update_party_summary() -> void:
	var text: String = "Équipe : "

	if created_party.is_empty():
		text += "aucun héros validé"
	else:
		for i in range(created_party.size()):
			if i > 0:
				text += " | "

			var hero = created_party[i]
			text += hero.character_name + " - " + ClassDatabaseScript.normalize_class_name(hero.job)

	party_summary_label.text = text


# ------------------------------------------------------------
# TEXTE COLORÉ DES ROLLS
# Colore uniquement les valeurs des caractéristiques selon leur qualité.
# ------------------------------------------------------------

func build_colored_roll_text(stats) -> String:
	if stats == null:
		return ""

	var text: String = ""
	text += "FOR " + colorize_roll_stat_value(stats.strength)
	text += " AGI " + colorize_roll_stat_value(stats.agility)
	text += " END " + colorize_roll_stat_value(stats.endurance)
	text += " MAG " + colorize_roll_stat_value(stats.magic_power)
	text += " TOTAL " + str(stat_roller.get_total(stats))

	return text


func colorize_roll_stat_value(value: int) -> String:
	var color_hex: String = ROLL_STAT_DEFAULT_COLOR_HEX

	if value >= ROLL_STAT_MAX_VALUE:
		color_hex = ROLL_STAT_MAX_COLOR_HEX
	elif value == ROLL_STAT_AVERAGE_VALUE:
		color_hex = ROLL_STAT_AVERAGE_COLOR_HEX
	elif value <= ROLL_STAT_WEAK_VALUE:
		color_hex = ROLL_STAT_WEAK_COLOR_HEX

	return "[color=" + color_hex + "]" + str(value) + "[/color]"


# ------------------------------------------------------------
# AIDE CONTEXTUELLE
# Affiche une petite fenêtre près du curseur pour les boutons de roll.
# ------------------------------------------------------------

func build_help_tooltip() -> void:
	help_tooltip_panel = create_panel(
		Color(0.035, 0.024, 0.016, 0.96),
		Color(0.58, 0.36, 0.14, 1.0),
		2
	)
	help_tooltip_panel.visible = false
	help_tooltip_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	help_tooltip_panel.z_index = 100
	help_tooltip_panel.custom_minimum_size = Vector2(260, 54)
	add_child(help_tooltip_panel)

	help_tooltip_label = create_label(
		"",
		13,
		Color(0.92, 0.82, 0.62)
	)
	help_tooltip_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	help_tooltip_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	help_tooltip_label.offset_left = 10
	help_tooltip_label.offset_top = 7
	help_tooltip_label.offset_right = -10
	help_tooltip_label.offset_bottom = -7
	help_tooltip_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	help_tooltip_panel.add_child(help_tooltip_label)


func attach_help_tooltip(button: Button, tooltip_text: String) -> void:
	button.mouse_entered.connect(func(): show_help_tooltip(tooltip_text))
	button.mouse_exited.connect(hide_help_tooltip)


func show_help_tooltip(tooltip_text: String) -> void:
	if help_tooltip_panel == null or help_tooltip_label == null:
		return

	help_tooltip_label.text = tooltip_text
	help_tooltip_panel.visible = true
	update_help_tooltip_position()


func hide_help_tooltip() -> void:
	if help_tooltip_panel == null:
		return

	help_tooltip_panel.visible = false


func update_help_tooltip_position() -> void:
	if help_tooltip_panel == null:
		return

	var target_position: Vector2 = get_local_mouse_position() + Vector2(16, 16)
	var tooltip_size: Vector2 = help_tooltip_panel.custom_minimum_size

	var max_x: float = max(0.0, size.x - tooltip_size.x - 8.0)
	var max_y: float = max(0.0, size.y - tooltip_size.y - 8.0)

	help_tooltip_panel.position = Vector2(
		clamp(target_position.x, 8.0, max_x),
		clamp(target_position.y, 8.0, max_y)
	)


# ------------------------------------------------------------
# COMPOSANTS UI
# Crée les boutons, labels et panneaux utilisés dans l’écran.
# ------------------------------------------------------------

func create_button(text: String) -> Button:
	var button: Button = Button.new()

	button.text = text
	button.custom_minimum_size = Vector2(150, 38)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 14)

	apply_textured_button_style(button)

	return button


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


func create_rich_label(
	text: String,
	font_size: int,
	font_color: Color,
	minimum_height: int
) -> RichTextLabel:
	var label: RichTextLabel = RichTextLabel.new()

	label.bbcode_enabled = true
	label.text = text
	label.fit_content = true
	label.scroll_active = false
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.custom_minimum_size = Vector2(0, minimum_height)
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.add_theme_font_size_override("normal_font_size", font_size)
	label.add_theme_color_override("default_color", font_color)
	label.autowrap_mode = TextServer.AUTOWRAP_OFF

	return label


func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	var panel: Panel = Panel.new()

	panel.theme = UIFrameStyleScript.create_menu_theme()
	panel.add_theme_stylebox_override(
		"panel",
		UIFrameStyleScript.create_panel_style(
			background_color,
			border_color,
			border_width
		)
	)

	return panel


func apply_textured_button_style(button: Button) -> void:
	button.add_theme_color_override("font_color", Color(0.90, 0.80, 0.58))
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.92, 0.48))
	button.add_theme_color_override("font_focus_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_disabled_color", Color(0.42, 0.36, 0.28))

	button.add_theme_stylebox_override(
		"normal",
		UIFrameStyleScript.create_button_style(
			Color(0.11, 0.07, 0.04, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			1
		)
	)
	button.add_theme_stylebox_override(
		"hover",
		UIFrameStyleScript.create_button_style(
			Color(0.18, 0.10, 0.05, 1.0),
			Color(0.55, 0.34, 0.13, 1.0),
			1
		)
	)
	button.add_theme_stylebox_override(
		"pressed",
		UIFrameStyleScript.create_button_style(
			Color(0.28, 0.16, 0.06, 1.0),
			Color(0.95, 0.72, 0.28, 1.0),
			2
		)
	)
	button.add_theme_stylebox_override(
		"focus",
		UIFrameStyleScript.create_button_style(
			Color(0.20, 0.12, 0.05, 1.0),
			Color(0.86, 0.62, 0.20, 1.0),
			2
		)
	)
	button.add_theme_stylebox_override(
		"disabled",
		UIFrameStyleScript.create_button_style(
			Color(0.06, 0.04, 0.03, 0.80),
			Color(0.18, 0.12, 0.06, 1.0),
			1
		)
	)


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Vérifie qu’une propriété existe avant de l’utiliser.
# ------------------------------------------------------------

func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
