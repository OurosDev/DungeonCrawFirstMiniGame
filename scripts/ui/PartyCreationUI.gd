extends Control
class_name PartyCreationUI

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données et helpers nécessaires à la création des héros.
# ------------------------------------------------------------
const StatRollerScript = preload("res://scripts/characters/StatRoller.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const UIFactory = preload("res://scripts/ui/party_creation/PartyCreationUIFactory.gd")
const HeroBuilder = preload("res://scripts/ui/party_creation/PartyCreationHeroBuilder.gd")
const SummaryHelper = preload("res://scripts/ui/party_creation/PartyCreationSummaryHelper.gd")

# ------------------------------------------------------------
# SCÈNES
# Définit les chemins utilisés après la création ou le retour menu.
# ------------------------------------------------------------
const DUNGEON_SCENE_PATH: String = "res://scenes/Dungeon.tscn"
const MAIN_MENU_SCENE_PATH: String = "res://scenes/MainMenu.tscn"

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
var roll_label: Label = null
var stored_roll_label: Label = null
var class_description_label: Label = null
var party_summary_label: Label = null
var class_buttons_box: HBoxContainer = null
var reroll_button: Button = null
var store_button: Button = null
var restore_button: Button = null
var validate_button: Button = null
var back_to_menu_button: Button = null


# ------------------------------------------------------------
# INITIALISATION
# Prépare les données de classes et l'écran de création.
# ------------------------------------------------------------
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

	root_panel = UIFactory.create_panel(
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

	_create_title_section()
	_create_roll_section()
	_create_class_section()
	_create_summary_section()


func _create_title_section() -> void:
	title_label = UIFactory.create_label(
		"CRÉATION DE L'ÉQUIPE",
		28,
		Color(1.0, 0.82, 0.35)
	)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(title_label)

	back_to_menu_button = UIFactory.create_button("Retour au menu")
	back_to_menu_button.custom_minimum_size = Vector2(180, 34)
	back_to_menu_button.pressed.connect(on_back_to_menu_pressed)
	main_box.add_child(back_to_menu_button)

	hero_label = UIFactory.create_label("", 20, Color(0.92, 0.82, 0.58))
	hero_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(hero_label)


func _create_roll_section() -> void:
	roll_label = UIFactory.create_label("", 18, Color(0.86, 0.78, 0.62))
	roll_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(roll_label)

	var roll_buttons_box: HBoxContainer = HBoxContainer.new()
	roll_buttons_box.alignment = BoxContainer.ALIGNMENT_CENTER
	roll_buttons_box.add_theme_constant_override("separation", 12)
	main_box.add_child(roll_buttons_box)

	reroll_button = UIFactory.create_button("Relancer")
	reroll_button.pressed.connect(reroll_current_stats)
	roll_buttons_box.add_child(reroll_button)

	store_button = UIFactory.create_button("Stocker")
	store_button.pressed.connect(store_current_roll)
	roll_buttons_box.add_child(store_button)

	restore_button = UIFactory.create_button("Reprendre")
	restore_button.pressed.connect(restore_stored_roll)
	roll_buttons_box.add_child(restore_button)

	stored_roll_label = UIFactory.create_label("", 15, Color(0.65, 0.58, 0.46))
	stored_roll_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(stored_roll_label)

	var separator_1: HSeparator = HSeparator.new()
	main_box.add_child(separator_1)


func _create_class_section() -> void:
	var class_title: Label = UIFactory.create_label("CLASSE", 18, Color(0.95, 0.76, 0.34))
	class_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(class_title)

	class_buttons_box = HBoxContainer.new()
	class_buttons_box.alignment = BoxContainer.ALIGNMENT_CENTER
	class_buttons_box.add_theme_constant_override("separation", 10)
	main_box.add_child(class_buttons_box)

	for job_name in available_classes:
		var current_job_name: String = job_name
		var class_button: Button = UIFactory.create_button(current_job_name)
		class_button.pressed.connect(func(): select_class(current_job_name))
		class_buttons_box.add_child(class_button)

	class_description_label = UIFactory.create_label("", 15, Color(0.76, 0.70, 0.58))
	class_description_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	class_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	class_description_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	main_box.add_child(class_description_label)

	var separator_2: HSeparator = HSeparator.new()
	main_box.add_child(separator_2)


func _create_summary_section() -> void:
	party_summary_label = UIFactory.create_label("", 15, Color(0.80, 0.74, 0.62))
	party_summary_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(party_summary_label)

	validate_button = UIFactory.create_button("Valider ce héros")
	validate_button.custom_minimum_size = Vector2(240, 44)
	validate_button.pressed.connect(validate_current_hero)
	main_box.add_child(validate_button)


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
	selected_class_name = job_name
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
# Crée CharacterData depuis la sélection courante.
# ------------------------------------------------------------
func create_hero_from_current_selection():
	return HeroBuilder.create_hero(selected_class_name, current_stats, current_hero_index)


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
		roll_label.text = stat_roller.get_roll_text(current_stats)
	else:
		roll_label.text = ""

	if stored_stats != null:
		stored_roll_label.text = "Roll stocké : " + stat_roller.get_roll_text(stored_stats)
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
		button.disabled = button.text == selected_class_name


func update_party_summary() -> void:
	party_summary_label.text = SummaryHelper.build_party_summary(created_party)
