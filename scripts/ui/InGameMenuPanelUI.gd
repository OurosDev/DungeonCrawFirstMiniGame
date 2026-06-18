extends Control
class_name InGameMenuPanelUI

# ------------------------------------------------------------
# SIGNAUX
# Informe Dungeon.gd des actions système demandées depuis le menu.
# ------------------------------------------------------------

signal save_requested
signal quit_requested


# ------------------------------------------------------------
# DÉPENDANCES
# Utilise les bases d'objets et règles d'équipement pour les menus.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")
const ShopRulesScript = preload("res://scripts/shop/ShopRules.gd")


# ------------------------------------------------------------
# OUTILS TEMPORAIRES DE DÉVELOPPEMENT
# Active un bouton de téléportation pour accélérer les tests de layout.
# À désactiver ou supprimer avant une version finale.
# ------------------------------------------------------------

const DEV_TELEPORT_ENABLED: bool = true


# ------------------------------------------------------------
# NŒUDS UI PRINCIPAUX
# Stocke les éléments communs à tous les écrans du menu.
# ------------------------------------------------------------

var root_panel: Panel = null
var main_box: VBoxContainer = null
var title_label: Label = null
var content_box: VBoxContainer = null
var message_label: Label = null

var music_volume_label: Label = null
var music_volume_slider: HSlider = null
var sfx_volume_label: Label = null
var sfx_volume_slider: HSlider = null

var top_separator: HSeparator = null
var bottom_separator: HSeparator = null

var dev_teleport_button: Button = null
var dev_teleport_x_input: LineEdit = null
var dev_teleport_y_input: LineEdit = null
var dev_teleport_feedback_label: Label = null


# ------------------------------------------------------------
# ÉTAT
# Garde le groupe affiché et évite de reconstruire l'UI plusieurs fois.
# ------------------------------------------------------------

var current_party: Array = []
var ui_built: bool = false


# ------------------------------------------------------------
# INITIALISATION
# Construit l'interface au chargement du nœud.
# ------------------------------------------------------------

func _ready() -> void:
	build_ui()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_STOP
	visible = false

	root_panel = create_panel(
		Color(0.045, 0.030, 0.022, 1.0),
		Color(0.48, 0.31, 0.14, 1.0),
		4
	)
	root_panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	root_panel.offset_left = 10
	root_panel.offset_top = 10
	root_panel.offset_right = -10
	root_panel.offset_bottom = -10
	add_child(root_panel)

	main_box = VBoxContainer.new()
	main_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_box.offset_left = 24
	main_box.offset_top = 20
	main_box.offset_right = -24
	main_box.offset_bottom = -20
	main_box.add_theme_constant_override("separation", 14)
	root_panel.add_child(main_box)

	title_label = create_label("", 26, Color(1.0, 0.82, 0.35))
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(title_label)

	top_separator = HSeparator.new()
	main_box.add_child(top_separator)

	content_box = VBoxContainer.new()
	content_box.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content_box.alignment = BoxContainer.ALIGNMENT_CENTER
	content_box.add_theme_constant_override("separation", 12)
	main_box.add_child(content_box)

	bottom_separator = HSeparator.new()
	main_box.add_child(bottom_separator)

	message_label = create_label("Échap : fermer le menu", 14, Color(0.70, 0.62, 0.48))
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(message_label)

	create_dev_teleport_button()


# ------------------------------------------------------------
# OUTIL TEMPORAIRE DE TÉLÉPORTATION
# Petit menu de développement pour atteindre rapidement une coordonnée.
# ------------------------------------------------------------

# Crée le petit bouton carré "T" affiché en haut à gauche du menu.
func create_dev_teleport_button() -> void:
	if not DEV_TELEPORT_ENABLED:
		return

	if dev_teleport_button != null:
		return

	dev_teleport_button = Button.new()
	dev_teleport_button.name = "DevTeleportButton"
	dev_teleport_button.text = "T"
	dev_teleport_button.focus_mode = Control.FOCUS_NONE
	dev_teleport_button.custom_minimum_size = Vector2(34, 34)
	dev_teleport_button.add_theme_font_size_override("font_size", 14)
	dev_teleport_button.tooltip_text = "Téléportation de test"
	dev_teleport_button.anchor_left = 0.0
	dev_teleport_button.anchor_top = 0.0
	dev_teleport_button.anchor_right = 0.0
	dev_teleport_button.anchor_bottom = 0.0
	dev_teleport_button.offset_left = 8
	dev_teleport_button.offset_top = 8
	dev_teleport_button.offset_right = 42
	dev_teleport_button.offset_bottom = 42
	dev_teleport_button.pressed.connect(show_dev_teleport_screen)
	root_panel.add_child(dev_teleport_button)


# Affiche un écran simple permettant de saisir une coordonnée X/Y.
func show_dev_teleport_screen() -> void:
	if not DEV_TELEPORT_ENABLED:
		return

	set_menu_chrome_visible(false)
	clear_content()

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = Vector2(360, 280)
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 10)
	content_box.add_child(wrapper)

	var title: Label = create_label("TÉLÉPORTATION TEST", 18, Color(1.0, 0.82, 0.35))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(title)

	var current_position: Vector2i = get_dev_current_player_cell()
	var current_label: Label = create_label(
		"Position actuelle : X " + str(current_position.x) + " / Y " + str(current_position.y),
		13,
		Color(0.82, 0.74, 0.56)
	)
	current_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	current_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(current_label)

	var input_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	input_panel.custom_minimum_size = Vector2(320, 92)
	input_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(input_panel)

	var input_box: VBoxContainer = VBoxContainer.new()
	input_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	input_box.offset_left = 14
	input_box.offset_top = 12
	input_box.offset_right = -14
	input_box.offset_bottom = -12
	input_box.add_theme_constant_override("separation", 8)
	input_panel.add_child(input_box)

	input_box.add_child(create_dev_coordinate_row("X", true, current_position.x))
	input_box.add_child(create_dev_coordinate_row("Y", false, current_position.y))

	dev_teleport_feedback_label = create_label("Coordonnées de grille Vector2i(x, y).", 12, Color(0.70, 0.62, 0.48))
	dev_teleport_feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	dev_teleport_feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(dev_teleport_feedback_label)

	var teleport_button: Button = create_menu_button("Téléporter")
	teleport_button.custom_minimum_size = Vector2(220, 36)
	teleport_button.add_theme_font_size_override("font_size", 15)
	teleport_button.pressed.connect(on_dev_teleport_pressed)
	wrapper.add_child(teleport_button)

	var back_button: Button = create_compact_menu_button("Retour menu")
	back_button.pressed.connect(show_main_screen)
	wrapper.add_child(back_button)

	var hint_label: Label = create_label("Outil temporaire de développement", 11, Color(0.56, 0.50, 0.42))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(hint_label)


# Crée une ligne de saisie pour X ou Y.
func create_dev_coordinate_row(label_text: String, is_x_input: bool, default_value: int) -> Control:
	var row: HBoxContainer = HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_theme_constant_override("separation", 8)

	var label: Label = create_label(label_text, 15, Color(0.95, 0.86, 0.62))
	label.custom_minimum_size = Vector2(28, 0)
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(label)

	var input: LineEdit = LineEdit.new()
	input.text = str(default_value)
	input.custom_minimum_size = Vector2(90, 26)
	input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input.placeholder_text = "0"
	input.alignment = HORIZONTAL_ALIGNMENT_CENTER
	input.max_length = 4
	input.focus_mode = Control.FOCUS_ALL
	row.add_child(input)

	if is_x_input:
		dev_teleport_x_input = input
	else:
		dev_teleport_y_input = input

	return row


# Renvoie la position actuelle du joueur si la scène courante l'expose.
func get_dev_current_player_cell() -> Vector2i:
	var scene = get_tree().current_scene

	if scene == null:
		return Vector2i.ZERO

	if not scene.has_method("get_debug_player_cell"):
		return Vector2i.ZERO

	return scene.get_debug_player_cell()


# Valide les valeurs saisies et demande au donjon de déplacer le joueur.
func on_dev_teleport_pressed() -> void:
	if dev_teleport_x_input == null or dev_teleport_y_input == null:
		set_dev_teleport_feedback("Champs de coordonnées introuvables.", true)
		return

	var x_text: String = dev_teleport_x_input.text.strip_edges()
	var y_text: String = dev_teleport_y_input.text.strip_edges()

	if not x_text.is_valid_int() or not y_text.is_valid_int():
		set_dev_teleport_feedback("Coordonnées invalides.", true)
		return

	var target_cell: Vector2i = Vector2i(int(x_text), int(y_text))
	var scene = get_tree().current_scene

	if scene == null or not scene.has_method("debug_teleport_to_cell"):
		set_dev_teleport_feedback("La scène courante ne permet pas la téléportation.", true)
		return

	var result: Dictionary = scene.debug_teleport_to_cell(target_cell)
	var success: bool = bool(result.get("success", false))
	var message: String = str(result.get("message", ""))

	if not success:
		set_dev_teleport_feedback(message, true)
		return

	set_dev_teleport_feedback(message, false)


func set_dev_teleport_feedback(text: String, is_error: bool) -> void:
	if dev_teleport_feedback_label == null:
		return

	dev_teleport_feedback_label.text = text

	if is_error:
		dev_teleport_feedback_label.add_theme_color_override("font_color", Color(1.0, 0.48, 0.35))
	else:
		dev_teleport_feedback_label.add_theme_color_override("font_color", Color(0.70, 0.90, 0.60))


# ------------------------------------------------------------
# OUVERTURE / FERMETURE
# Contrôle l'état visible du menu d'aventure.
# ------------------------------------------------------------

func open_menu(party: Array) -> void:
	ensure_ui_ready()
	current_party = party
	visible = true
	show_main_screen()


func close_menu() -> void:
	visible = false


func is_menu_open() -> bool:
	return visible


func show_message(text: String) -> void:
	ensure_ui_ready()

	if message_label != null:
		message_label.text = text


func set_menu_chrome_visible(should_show: bool) -> void:
	if title_label != null:
		title_label.visible = should_show

	if top_separator != null:
		top_separator.visible = should_show

	if bottom_separator != null:
		bottom_separator.visible = should_show

	if message_label != null:
		message_label.visible = should_show


# ------------------------------------------------------------
# ÉCRAN PRINCIPAL
# Affiche les entrées principales du menu d'aventure.
# ------------------------------------------------------------

func show_main_screen() -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var menu_wrapper: VBoxContainer = VBoxContainer.new()
	menu_wrapper.custom_minimum_size = Vector2(300, 300)
	menu_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	menu_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	menu_wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	menu_wrapper.add_theme_constant_override("separation", 12)
	content_box.add_child(menu_wrapper)

	var inventory_button: Button = create_menu_button("Inventaire")
	inventory_button.pressed.connect(show_inventory_screen)
	menu_wrapper.add_child(inventory_button)

	var grimoire_button: Button = create_menu_button("Grimoire")
	grimoire_button.pressed.connect(show_grimoire_screen)
	menu_wrapper.add_child(grimoire_button)

	var status_button: Button = create_menu_button("Statut")
	status_button.pressed.connect(show_status_screen)
	menu_wrapper.add_child(status_button)

	if GameSession.has_method("is_shop_available") and GameSession.is_shop_available():
		var shop_button: Button = create_menu_button("Boutique")
		shop_button.pressed.connect(show_shop_screen)
		menu_wrapper.add_child(shop_button)

	var system_button: Button = create_menu_button("Menu")
	system_button.pressed.connect(show_system_screen)
	menu_wrapper.add_child(system_button)

	var hint_label: Label = create_label("Échap : fermer le menu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	menu_wrapper.add_child(hint_label)


# ------------------------------------------------------------
# INVENTAIRE
# Affiche uniquement les objets possédés dans le sac commun du groupe.
# ------------------------------------------------------------

func show_inventory_screen() -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var inventory_wrapper: VBoxContainer = VBoxContainer.new()
	inventory_wrapper.custom_minimum_size = Vector2(580, 350)
	inventory_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	inventory_wrapper.add_theme_constant_override("separation", 6)
	content_box.add_child(inventory_wrapper)

	var gold_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	# Cadre compact : assez large pour afficher "Or : 9999" sans occuper toute la largeur.
	gold_panel.custom_minimum_size = Vector2(150, 34)
	gold_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.add_child(gold_panel)

	var gold_center: CenterContainer = CenterContainer.new()
	gold_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	gold_center.offset_left = 8
	gold_center.offset_top = 3
	gold_center.offset_right = -8
	gold_center.offset_bottom = -3
	gold_panel.add_child(gold_center)

	var gold_amount: int = 0

	if GameSession.has_method("get_gold"):
		gold_amount = GameSession.get_gold()

	var gold_label: Label = create_label("Or : " + str(gold_amount), 15, Color(1.0, 0.82, 0.35))
	gold_label.custom_minimum_size = Vector2(120, 22)
	gold_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gold_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	gold_center.add_child(gold_label)

	var list_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 210)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	list_panel.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.add_child(list_panel)

	var inventory_list: VBoxContainer = create_scrollable_list_inside_panel(list_panel)

	var inventory = null
	var slots: Array = []

	if GameSession.has_method("get_inventory"):
		inventory = GameSession.get_inventory()

	if inventory != null and inventory.has_method("get_slots"):
		slots = inventory.get_slots()

	var visible_slot_count: int = 0

	for slot in slots:
		if not (slot is Dictionary):
			continue

		var item_id: String = str(slot.get("item_id", ""))
		var quantity: int = int(slot.get("quantity", 0))

		if item_id == "" or quantity <= 0:
			continue

		inventory_list.add_child(create_inventory_row(item_id, quantity))
		visible_slot_count += 1

	if visible_slot_count <= 0:
		inventory_list.add_child(create_empty_message_label("Inventaire vide."))

	var back_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	back_panel.custom_minimum_size = Vector2(560, 38)
	back_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.add_child(back_panel)

	var back_center: CenterContainer = CenterContainer.new()
	back_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	back_center.offset_left = 8
	back_center.offset_top = 4
	back_center.offset_right = -8
	back_center.offset_bottom = -4
	back_panel.add_child(back_center)

	var back_button: Button = create_compact_menu_button("Retour menu")
	back_button.pressed.connect(show_main_screen)
	back_center.add_child(back_button)

	var hint_label: Label = create_label("Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inventory_wrapper.add_child(hint_label)


func create_inventory_row(item_id: String, quantity: int) -> Control:
	var panel: Panel = create_panel(
		Color(0.070, 0.047, 0.034, 1.0),
		Color(0.22, 0.14, 0.07, 1.0),
		1
	)
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.custom_minimum_size = Vector2(0, 24)

	var row: HBoxContainer = HBoxContainer.new()
	row.set_anchors_preset(Control.PRESET_FULL_RECT)
	row.offset_left = 10
	row.offset_right = -10
	row.add_theme_constant_override("separation", 8)
	panel.add_child(row)

	var display_name: String = ItemDatabaseScript.get_display_name(item_id)

	var name_label: Label = create_label(display_name, 12, Color(0.82, 0.76, 0.62))
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(name_label)

	var separator_label: Label = create_label("|", 13, Color(0.56, 0.45, 0.30))
	separator_label.custom_minimum_size = Vector2(28, 20)
	separator_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	separator_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(separator_label)

	var quantity_label: Label = create_label(str(quantity), 13, Color(0.92, 0.84, 0.58))
	quantity_label.custom_minimum_size = Vector2(40, 20)
	quantity_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	quantity_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(quantity_label)

	return panel


# ------------------------------------------------------------
# BOUTIQUE
# Permet de vendre les objets de l'inventaire quand le groupe est sur une case B.
# ------------------------------------------------------------

func show_shop_screen(feedback_text: String = "") -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var shop_wrapper: VBoxContainer = VBoxContainer.new()
	shop_wrapper.custom_minimum_size = Vector2(600, 380)
	shop_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	shop_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	shop_wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	shop_wrapper.add_theme_constant_override("separation", 6)
	content_box.add_child(shop_wrapper)

	var gold_label: Label = create_label("Or : " + str(GameSession.get_gold()), 18, Color(1.0, 0.82, 0.35))
	gold_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	shop_wrapper.add_child(gold_label)

	if feedback_text != "":
		var feedback_label: Label = create_label(feedback_text, 13, Color(0.86, 0.76, 0.48))
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		shop_wrapper.add_child(feedback_label)

	var list_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 240)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	shop_wrapper.add_child(list_panel)

	var shop_list: VBoxContainer = create_scrollable_list_inside_panel(list_panel)
	var sellable_count: int = add_sellable_inventory_rows(shop_list)

	if sellable_count <= 0:
		shop_list.add_child(create_empty_message_label("Aucun objet à vendre."))

	var back_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	back_panel.custom_minimum_size = Vector2(560, 38)
	back_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	shop_wrapper.add_child(back_panel)

	var back_center: CenterContainer = CenterContainer.new()
	back_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	back_center.offset_left = 8
	back_center.offset_top = 4
	back_center.offset_right = -8
	back_center.offset_bottom = -4
	back_panel.add_child(back_center)

	var back_button: Button = create_compact_menu_button("Retour menu")
	back_button.pressed.connect(show_main_screen)
	back_center.add_child(back_button)

	var hint_label: Label = create_label("Cliquez sur un objet pour en vendre 1. Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_wrapper.add_child(hint_label)


func add_sellable_inventory_rows(shop_list: VBoxContainer) -> int:
	var inventory = GameSession.get_inventory()
	var slots: Array = []
	var sellable_count: int = 0

	if inventory != null and inventory.has_method("get_slots"):
		slots = inventory.get_slots()

	for slot in slots:
		if not (slot is Dictionary):
			continue

		var item_id: String = str(slot.get("item_id", ""))
		var quantity: int = int(slot.get("quantity", 0))

		if item_id == "" or quantity <= 0:
			continue

		if not ShopRulesScript.can_sell_item(item_id):
			continue

		shop_list.add_child(create_shop_sell_button(item_id, quantity))
		sellable_count += 1

	return sellable_count


func create_shop_sell_button(item_id: String, quantity: int) -> Button:
	var button: Button = Button.new()
	var display_name: String = ItemDatabaseScript.get_display_name(item_id)
	var sell_price: int = ShopRulesScript.get_sell_price(item_id)

	button.text = display_name + "     |     " + str(quantity) + "     |     " + str(sell_price) + " or"
	button.custom_minimum_size = Vector2(520, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.pressed.connect(on_shop_sell_pressed.bind(item_id))

	return button


func on_shop_sell_pressed(item_id: String) -> void:
	var result: Dictionary = GameSession.sell_inventory_item(item_id, 1)
	var feedback_text: String = str(result.get("message", ""))
	show_shop_screen(feedback_text)


# ------------------------------------------------------------
# GRIMOIRE
# Placeholder conservé pour une future version.
# ------------------------------------------------------------

func show_grimoire_screen() -> void:
	set_menu_chrome_visible(true)
	clear_content()

	title_label.text = "GRIMOIRE"
	message_label.text = ""

	var text_label: Label = create_label(
		"Le grimoire sera ajouté plus tard.\n\nCe panneau servira à consulter les sorts connus et, plus tard, à lancer certains soins hors combat.",
		16,
		Color(0.78, 0.72, 0.58)
	)
	text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_label.size_flags_vertical = Control.SIZE_EXPAND_FILL
	content_box.add_child(text_label)

	var back_button: Button = create_menu_button("Retour")
	back_button.pressed.connect(show_main_screen)
	content_box.add_child(back_button)


# ------------------------------------------------------------
# STATUT
# Affiche les données détaillées des héros du groupe.
# Le bouton EQUIPEMENT de chaque héros ouvre son panneau dédié.
# ------------------------------------------------------------

func show_status_screen() -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var grid: GridContainer = GridContainer.new()
	grid.columns = 2
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 10)
	grid.add_theme_constant_override("v_separation", 10)
	content_box.add_child(grid)

	var display_order: Array[int] = [0, 2, 1, 3]

	for party_index in display_order:
		var hero = null

		if party_index < current_party.size():
			hero = current_party[party_index]

		var hero_frame: Panel = create_status_hero_frame(hero, party_index)
		grid.add_child(hero_frame)

	var hint_label: Label = create_label("Cliquez sur EQUIPEMENT pour gérer le héros. Échap : retour au jeu", 14, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content_box.add_child(hint_label)


func create_status_hero_frame(hero, index: int) -> Panel:
	var panel: Panel = create_panel(
		Color(0.075, 0.050, 0.035, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	panel.custom_minimum_size = Vector2(0, 0)

	var box: VBoxContainer = VBoxContainer.new()
	box.set_anchors_preset(Control.PRESET_FULL_RECT)
	box.offset_left = 10
	box.offset_top = 8
	box.offset_right = -10
	box.offset_bottom = -8
	box.add_theme_constant_override("separation", 4)
	panel.add_child(box)

	var name_text: String = "Héros " + str(index + 1)

	if hero != null:
		name_text = get_string_property(hero, "character_name", name_text)

	var name_label: Label = create_label(name_text, 15, Color(1.0, 0.82, 0.35))
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(name_label)

	var sub_text: String = "Emplacement vide"

	if hero != null:
		sub_text = "NIV " + str(get_int_property(hero, "level", 1))
		sub_text += " "
		sub_text += get_string_property(hero, "job", "")

	var sub_label: Label = create_label(sub_text, 12, Color(0.85, 0.78, 0.64))
	sub_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(sub_label)

	if hero == null:
		var empty_slot_panel: Panel = create_panel(
			Color(0.10, 0.07, 0.05, 1.0),
			Color(0.24, 0.16, 0.08, 1.0),
			1
		)
		empty_slot_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		empty_slot_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		empty_slot_panel.custom_minimum_size = Vector2(0, 46)
		box.add_child(empty_slot_panel)

		var empty_slot_label: Label = create_label("VIDE", 12, Color(0.65, 0.58, 0.46))
		empty_slot_label.set_anchors_preset(Control.PRESET_FULL_RECT)
		empty_slot_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_slot_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		empty_slot_panel.add_child(empty_slot_label)

		var empty_stats_label: Label = create_label("Aucune donnée.", 12, Color(0.72, 0.66, 0.56))
		empty_stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		box.add_child(empty_stats_label)
		return panel

	var equipment_button: Button = create_status_equipment_button(index)
	box.add_child(equipment_button)

	var hpmp_label: Label = create_label(
		"HP " + str(get_int_property(hero, "hp", 0)) + " / " + str(get_int_property(hero, "max_hp", 0)) + " | MP " + str(get_int_property(hero, "mp", 0)) + " / " + str(get_int_property(hero, "max_mp", 0)),
		12,
		Color(0.82, 0.76, 0.62)
	)
	hpmp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(hpmp_label)

	var stats_label: Label = create_label(format_compact_stats(hero), 12, Color(0.82, 0.76, 0.62))
	stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(stats_label)

	return panel


# Crée le bouton explicite qui ouvre l'équipement du héros.
func create_status_equipment_button(hero_index: int) -> Button:
	var button: Button = Button.new()
	button.text = "EQUIPEMENT"
	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size = Vector2(0, 46)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 13)
	button.pressed.connect(show_equipment_screen.bind(hero_index))
	return button


# ------------------------------------------------------------
# ÉQUIPEMENT
# Affiche et modifie l'équipement du héros sélectionné.
# ------------------------------------------------------------

func show_equipment_screen(hero_index: int, feedback_text: String = "") -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var hero = get_hero_from_index(hero_index)

	if hero == null:
		content_box.add_child(create_empty_message_label("Héros introuvable."))
		return

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = Vector2(620, 360)
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 6)
	content_box.add_child(wrapper)

	var stats_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.26, 0.17, 0.08, 1.0),
		1
	)
	stats_panel.custom_minimum_size = Vector2(560, 102)
	stats_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(stats_panel)
	fill_equipment_stats_panel(stats_panel, hero)

	var slots_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	slots_panel.custom_minimum_size = Vector2(560, 165)
	slots_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(slots_panel)

	var slot_list: VBoxContainer = VBoxContainer.new()
	slot_list.set_anchors_preset(Control.PRESET_FULL_RECT)
	slot_list.offset_left = 14
	slot_list.offset_top = 8
	slot_list.offset_right = -14
	slot_list.offset_bottom = -8
	slot_list.add_theme_constant_override("separation", 4)
	slots_panel.add_child(slot_list)

	for slot_id in EquipmentRulesScript.get_slot_order():
		var slot_button: Button = create_equipment_slot_button(hero, hero_index, slot_id)
		slot_list.add_child(slot_button)

	if feedback_text != "":
		var feedback_label: Label = create_label(feedback_text, 13, Color(0.86, 0.76, 0.48))
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		wrapper.add_child(feedback_label)

	var back_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	back_panel.custom_minimum_size = Vector2(560, 38)
	back_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(back_panel)

	var back_center: CenterContainer = CenterContainer.new()
	back_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	back_center.offset_left = 8
	back_center.offset_top = 4
	back_center.offset_right = -8
	back_center.offset_bottom = -4
	back_panel.add_child(back_center)

	var back_button: Button = create_compact_menu_button("Retour statut")
	back_button.pressed.connect(show_status_screen)
	back_center.add_child(back_button)

	var hint_label: Label = create_label("Cliquez sur un emplacement pour modifier l'équipement. Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wrapper.add_child(hint_label)


func fill_equipment_stats_panel(panel: Panel, hero) -> void:
	var stats_box: VBoxContainer = VBoxContainer.new()
	stats_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	stats_box.offset_left = 20
	stats_box.offset_top = 8
	stats_box.offset_right = -20
	stats_box.offset_bottom = -8
	stats_box.add_theme_constant_override("separation", 3)
	panel.add_child(stats_box)

	stats_box.add_child(create_stat_line(hero, "Force", "strength"))
	stats_box.add_child(create_stat_line(hero, "Agilité", "agility"))
	stats_box.add_child(create_stat_line(hero, "Endurance", "endurance"))
	stats_box.add_child(create_stat_line(hero, "Magie", "magic_power"))


func create_stat_line(hero, display_name: String, stat_name: String) -> HBoxContainer:
	var base_value: int = get_hero_base_stat(hero, stat_name)
	var bonus_value: int = get_hero_equipment_bonus(hero, stat_name)
	var final_value: int = get_hero_effective_stat(hero, stat_name)

	var row: HBoxContainer = HBoxContainer.new()
	row.custom_minimum_size = Vector2(520, 18)
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_theme_constant_override("separation", 8)

	var name_label: Label = create_label(display_name, 12, Color(0.82, 0.76, 0.62))
	name_label.custom_minimum_size = Vector2(120, 0)
	row.add_child(name_label)

	var final_label: Label = create_label(str(final_value), 12, Color(1.0, 0.82, 0.35))
	final_label.custom_minimum_size = Vector2(48, 0)
	final_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	row.add_child(final_label)

	var bonus_text: String = ""
	var bonus_color: Color = Color(0.70, 0.62, 0.48)

	if bonus_value > 0:
		bonus_text = "+" + str(bonus_value)
		bonus_color = Color(0.55, 0.86, 0.48)
	elif bonus_value < 0:
		bonus_text = str(bonus_value)
		bonus_color = Color(0.86, 0.40, 0.34)

	var bonus_label: Label = create_label(bonus_text, 12, bonus_color)
	bonus_label.custom_minimum_size = Vector2(64, 0)
	bonus_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	row.add_child(bonus_label)

	var spacer: Control = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(spacer)

	var base_label: Label = create_label("Base " + str(base_value), 12, Color(0.70, 0.62, 0.48))
	base_label.custom_minimum_size = Vector2(120, 0)
	base_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	row.add_child(base_label)

	return row


func create_equipment_slot_button(hero, hero_index: int, slot_id: String) -> Button:
	var button: Button = Button.new()
	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size = Vector2(520, 28)
	button.add_theme_font_size_override("font_size", 13)

	var item_id: String = get_hero_equipped_item(hero, slot_id)
	var item_name: String = "—"

	if item_id != "":
		item_name = ItemDatabaseScript.get_display_name(item_id)

	button.text = EquipmentRulesScript.get_slot_display_name(slot_id) + "     |     " + item_name
	button.pressed.connect(show_equipment_choice_screen.bind(hero_index, slot_id))

	return button


func show_equipment_choice_screen(hero_index: int, slot_id: String) -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var hero = get_hero_from_index(hero_index)

	if hero == null:
		content_box.add_child(create_empty_message_label("Héros introuvable."))
		return

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = Vector2(640, 440)
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 10)
	content_box.add_child(wrapper)

	var title_text: String = EquipmentRulesScript.get_slot_display_name(slot_id)
	title_text += " — " + get_string_property(hero, "character_name", "Héros")

	var title: Label = create_label(title_text, 20, Color(1.0, 0.82, 0.35))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wrapper.add_child(title)

	var list_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 280)
	wrapper.add_child(list_panel)

	var list: VBoxContainer = create_scrollable_list_inside_panel(list_panel)
	var current_item_id: String = get_hero_equipped_item(hero, slot_id)

	if current_item_id != "":
		var remove_button: Button = create_equipment_choice_button("Retirer : " + ItemDatabaseScript.get_display_name(current_item_id))
		remove_button.pressed.connect(on_unequip_pressed.bind(hero_index, slot_id))
		list.add_child(remove_button)

	var inventory = GameSession.get_inventory()
	var equippable_ids: Array[String] = EquipmentRulesScript.get_equippable_item_ids_for_slot(hero, slot_id, inventory)

	for item_id in equippable_ids:
		var quantity: int = GameSession.get_inventory_item_quantity(item_id)
		var option_text: String = ItemDatabaseScript.get_display_name(item_id)
		option_text += "     |     " + str(quantity)

		var bonus_text: String = EquipmentRulesScript.get_item_bonus_text(item_id)
		if bonus_text != "":
			option_text += "     " + bonus_text

		var item_button: Button = create_equipment_choice_button(option_text)
		item_button.pressed.connect(on_equip_pressed.bind(hero_index, slot_id, item_id))
		list.add_child(item_button)

	if current_item_id == "" and equippable_ids.is_empty():
		list.add_child(create_empty_message_label("Aucun objet compatible dans l'inventaire."))
	elif current_item_id != "" and equippable_ids.is_empty():
		list.add_child(create_empty_message_label("Aucun remplacement compatible."))

	var back_button: Button = create_menu_button("Retour équipement")
	back_button.pressed.connect(show_equipment_screen.bind(hero_index))
	wrapper.add_child(back_button)

	var hint_label: Label = create_label("Échap : retour au jeu", 14, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wrapper.add_child(hint_label)


func create_equipment_choice_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(520, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	return button


func on_equip_pressed(hero_index: int, slot_id: String, item_id: String) -> void:
	var result: Dictionary = GameSession.equip_item_to_hero(hero_index, slot_id, item_id)
	var feedback_text: String = str(result.get("message", ""))
	show_equipment_screen(hero_index, feedback_text)


func on_unequip_pressed(hero_index: int, slot_id: String) -> void:
	var result: Dictionary = GameSession.unequip_item_from_hero(hero_index, slot_id)
	var feedback_text: String = str(result.get("message", ""))
	show_equipment_screen(hero_index, feedback_text)


# ------------------------------------------------------------
# MENU SYSTÈME
# Gère sauvegarde, options et sortie.
# ------------------------------------------------------------

func show_system_screen() -> void:
	set_menu_chrome_visible(true)
	clear_content()

	title_label.text = "MENU"
	message_label.text = ""

	var save_button: Button = create_menu_button("Sauvegarder")
	save_button.pressed.connect(on_save_pressed)
	content_box.add_child(save_button)

	var options_button: Button = create_menu_button("Options")
	options_button.pressed.connect(show_options_screen)
	content_box.add_child(options_button)

	var quit_button: Button = create_menu_button("Quitter")
	quit_button.pressed.connect(on_quit_pressed)
	content_box.add_child(quit_button)

	var back_button: Button = create_menu_button("Retour")
	back_button.pressed.connect(show_main_screen)
	content_box.add_child(back_button)


func show_options_screen() -> void:
	set_menu_chrome_visible(true)
	clear_content()

	title_label.text = "OPTIONS"
	message_label.text = ""

	music_volume_label = create_label("", 16, Color(0.82, 0.76, 0.62))
	music_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content_box.add_child(music_volume_label)

	music_volume_slider = HSlider.new()
	music_volume_slider.min_value = 0
	music_volume_slider.max_value = 100
	music_volume_slider.step = 1
	music_volume_slider.value = AudioManager.get_music_volume_percent()
	music_volume_slider.custom_minimum_size = Vector2(340, 32)
	music_volume_slider.value_changed.connect(on_music_volume_changed)
	content_box.add_child(music_volume_slider)

	sfx_volume_label = create_label("", 16, Color(0.82, 0.76, 0.62))
	sfx_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content_box.add_child(sfx_volume_label)

	sfx_volume_slider = HSlider.new()
	sfx_volume_slider.min_value = 0
	sfx_volume_slider.max_value = 100
	sfx_volume_slider.step = 1
	sfx_volume_slider.value = AudioManager.get_sfx_volume_percent()
	sfx_volume_slider.custom_minimum_size = Vector2(340, 32)
	sfx_volume_slider.value_changed.connect(on_sfx_volume_changed)
	content_box.add_child(sfx_volume_slider)

	update_music_volume_label()
	update_sfx_volume_label()

	var test_button: Button = create_menu_button("Tester effet sonore")
	test_button.pressed.connect(on_test_sfx_pressed)
	content_box.add_child(test_button)

	var back_button: Button = create_menu_button("Retour")
	back_button.pressed.connect(show_system_screen)
	content_box.add_child(back_button)


# ------------------------------------------------------------
# ACTIONS SYSTÈME ET AUDIO
# Transmet les actions au donjon ou à AudioManager.
# ------------------------------------------------------------

func on_save_pressed() -> void:
	save_requested.emit()


func on_quit_pressed() -> void:
	quit_requested.emit()


func on_music_volume_changed(value: float) -> void:
	var percent: int = int(round(value))
	AudioManager.set_music_volume_percent(percent)
	update_music_volume_label()


func on_sfx_volume_changed(value: float) -> void:
	var percent: int = int(round(value))
	AudioManager.set_sfx_volume_percent(percent)
	update_sfx_volume_label()


func on_test_sfx_pressed() -> void:
	AudioManager.play_sfx("save")


func update_music_volume_label() -> void:
	if music_volume_label == null:
		return

	music_volume_label.text = "Volume musique : " + str(AudioManager.get_music_volume_percent()) + " %"


func update_sfx_volume_label() -> void:
	if sfx_volume_label == null:
		return

	sfx_volume_label.text = "Volume effets : " + str(AudioManager.get_sfx_volume_percent()) + " %"


# ------------------------------------------------------------
# HELPERS UI
# Crée les composants visuels réutilisables.
# ------------------------------------------------------------

func clear_content() -> void:
	if content_box == null:
		return

	for child in content_box.get_children():
		child.queue_free()


func create_menu_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(260, 42)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 17)
	return button


func create_compact_menu_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(200, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
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
	style.corner_radius_top_left = 3
	style.corner_radius_top_right = 3
	style.corner_radius_bottom_left = 3
	style.corner_radius_bottom_right = 3

	panel.add_theme_stylebox_override("panel", style)

	return panel


func create_scrollable_list_inside_panel(panel: Panel) -> VBoxContainer:
	var list_margin: MarginContainer = MarginContainer.new()
	list_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	list_margin.add_theme_constant_override("margin_left", 14)
	list_margin.add_theme_constant_override("margin_top", 12)
	list_margin.add_theme_constant_override("margin_right", 14)
	list_margin.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(list_margin)

	var scroll: ScrollContainer = ScrollContainer.new()
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	list_margin.add_child(scroll)

	var list: VBoxContainer = VBoxContainer.new()
	list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	list.add_theme_constant_override("separation", 4)
	scroll.add_child(list)

	return list


func create_empty_message_label(text: String) -> Label:
	var empty_label: Label = create_label(text, 14, Color(0.62, 0.56, 0.46))
	empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	empty_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	empty_label.custom_minimum_size = Vector2(0, 44)
	return empty_label


# ------------------------------------------------------------
# HELPERS HÉROS / STATS
# Lit les héros et prépare les textes de stats avec bonus.
# ------------------------------------------------------------

func get_hero_from_index(hero_index: int):
	if hero_index < 0:
		return null

	if hero_index >= current_party.size():
		return null

	return current_party[hero_index]


func get_hero_equipped_item(hero, slot_id: String) -> String:
	if hero == null:
		return ""

	if hero.has_method("get_equipped_item"):
		return hero.get_equipped_item(slot_id)

	return ""


func format_compact_stats(hero) -> String:
	var text: String = "FOR " + format_compact_stat_value(hero, "strength")
	text += " AGI " + format_compact_stat_value(hero, "agility")
	text += " END " + format_compact_stat_value(hero, "endurance")
	text += " MAG " + format_compact_stat_value(hero, "magic_power")
	return text


func format_compact_stat_value(hero, stat_name: String) -> String:
	var final_value: int = get_hero_effective_stat(hero, stat_name)
	var bonus_value: int = get_hero_equipment_bonus(hero, stat_name)

	if bonus_value > 0:
		return str(final_value) + "(+" + str(bonus_value) + ")"

	if bonus_value < 0:
		return str(final_value) + "(" + str(bonus_value) + ")"

	return str(final_value)


func get_hero_base_stat(hero, stat_name: String) -> int:
	if hero == null:
		return 0

	if hero.has_method("get_base_stat_value"):
		return int(hero.get_base_stat_value(stat_name))

	var stats = get_property_value(hero, "stats", null)

	if stats == null:
		return 0

	return get_int_property(stats, stat_name, 0)


func get_hero_equipment_bonus(hero, stat_name: String) -> int:
	if hero == null:
		return 0

	if hero.has_method("get_equipment_bonus_value"):
		return int(hero.get_equipment_bonus_value(stat_name))

	return 0


func get_hero_effective_stat(hero, stat_name: String) -> int:
	if hero == null:
		return 0

	if hero.has_method("get_effective_stat_value"):
		return int(hero.get_effective_stat_value(stat_name))

	var stats = get_property_value(hero, "stats", null)

	if stats == null:
		return 0

	return get_int_property(stats, stat_name, 0)


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les propriétés sans dépendre fortement des classes concrètes.
# ------------------------------------------------------------

func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func get_property_value(target, property_name: String, default_value = null):
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return target.get(property_name)


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


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
