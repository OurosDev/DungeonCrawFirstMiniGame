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
const MenuUIFactoryScript = preload("res://scripts/ui/menu/MenuUIFactory.gd")
const DevTeleportMenuViewScript = preload("res://scripts/ui/menu/DevTeleportMenuView.gd")
const InventoryMenuViewScript = preload("res://scripts/ui/menu/InventoryMenuView.gd")
const ShopMenuViewScript = preload("res://scripts/ui/menu/ShopMenuView.gd")
const StatusEquipmentMenuViewScript = preload("res://scripts/ui/menu/StatusEquipmentMenuView.gd")


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
# ------------------------------------------------------------
# OUTIL TEMPORAIRE DE TÉLÉPORTATION
# Délègue l'interface de téléportation de test à un script dédié.
# ------------------------------------------------------------

# Crée le petit bouton carré "T" affiché en haut à gauche du menu.
func create_dev_teleport_button() -> void:
	if not DEV_TELEPORT_ENABLED:
		return

	DevTeleportMenuViewScript.create_dev_teleport_button(self)


# Affiche un écran simple permettant de saisir une coordonnée X/Y.
func show_dev_teleport_screen() -> void:
	if not DEV_TELEPORT_ENABLED:
		return

	DevTeleportMenuViewScript.show_dev_teleport_screen(self)


# Crée une ligne de saisie pour X ou Y.
func create_dev_coordinate_row(label_text: String, is_x_input: bool, default_value: int) -> Control:
	return DevTeleportMenuViewScript.create_dev_coordinate_row(self, label_text, is_x_input, default_value)


# Renvoie la position actuelle du joueur si la scène courante l'expose.
func get_dev_current_player_cell() -> Vector2i:
	return DevTeleportMenuViewScript.get_dev_current_player_cell(self)


# Valide les valeurs saisies et demande au donjon de déplacer le joueur.
func on_dev_teleport_pressed() -> void:
	DevTeleportMenuViewScript.on_dev_teleport_pressed(self)


func set_dev_teleport_feedback(text: String, is_error: bool) -> void:
	DevTeleportMenuViewScript.set_dev_teleport_feedback(self, text, is_error)


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

# ------------------------------------------------------------
# INVENTAIRE
# Délègue l'écran d'inventaire à un script de vue dédié.
# ------------------------------------------------------------

func show_inventory_screen() -> void:
	InventoryMenuViewScript.show_inventory_screen(self)


func create_inventory_row(item_id: String, quantity: int) -> Control:
	return InventoryMenuViewScript.create_inventory_row(self, item_id, quantity)


# ------------------------------------------------------------
# BOUTIQUE
# Délègue les écrans d'achat/vente à un script de vue dédié.
# ------------------------------------------------------------

func show_shop_screen(feedback_text: String = "") -> void:
	ShopMenuViewScript.show_shop_screen(self, feedback_text)


func show_shop_buy_screen(feedback_text: String = "") -> void:
	ShopMenuViewScript.show_shop_buy_screen(self, feedback_text)


func show_shop_sell_screen(feedback_text: String = "") -> void:
	ShopMenuViewScript.show_shop_sell_screen(self, feedback_text)


func create_shop_wrapper(minimum_size: Vector2, separation: int) -> VBoxContainer:
	return ShopMenuViewScript.create_shop_wrapper(self, minimum_size, separation)


func create_shop_gold_panel() -> Panel:
	return ShopMenuViewScript.create_shop_gold_panel(self)


func create_shop_feedback_label(feedback_text: String) -> Label:
	return ShopMenuViewScript.create_shop_feedback_label(self, feedback_text)


func create_shop_back_panel(button_text: String, callback: Callable) -> Panel:
	return ShopMenuViewScript.create_shop_back_panel(self, button_text, callback)


func add_shop_buy_rows(shop_list: VBoxContainer) -> int:
	return ShopMenuViewScript.add_shop_buy_rows(self, shop_list)


func create_shop_buy_button(item_id: String) -> Button:
	return ShopMenuViewScript.create_shop_buy_button(self, item_id)


func on_shop_buy_pressed(item_id: String) -> void:
	ShopMenuViewScript.on_shop_buy_pressed(self, item_id)


func add_sellable_inventory_rows(shop_list: VBoxContainer) -> int:
	return ShopMenuViewScript.add_sellable_inventory_rows(self, shop_list)


func create_shop_sell_button(item_id: String, quantity: int) -> Button:
	return ShopMenuViewScript.create_shop_sell_button(self, item_id, quantity)


func on_shop_sell_pressed(item_id: String) -> void:
	ShopMenuViewScript.on_shop_sell_pressed(self, item_id)


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

# ------------------------------------------------------------
# STATUT / ÉQUIPEMENT
# Délègue les écrans héros et équipement à un script de vue dédié.
# ------------------------------------------------------------

func show_status_screen() -> void:
	StatusEquipmentMenuViewScript.show_status_screen(self)


func create_status_hero_frame(hero, index: int) -> Panel:
	return StatusEquipmentMenuViewScript.create_status_hero_frame(self, hero, index)


func create_status_equipment_button(hero_index: int) -> Button:
	return StatusEquipmentMenuViewScript.create_status_equipment_button(self, hero_index)


func show_equipment_screen(hero_index: int, feedback_text: String = "") -> void:
	StatusEquipmentMenuViewScript.show_equipment_screen(self, hero_index, feedback_text)


func fill_equipment_stats_panel(panel: Panel, hero) -> void:
	StatusEquipmentMenuViewScript.fill_equipment_stats_panel(self, panel, hero)


func create_stat_line(hero, display_name: String, stat_name: String) -> HBoxContainer:
	return StatusEquipmentMenuViewScript.create_stat_line(self, hero, display_name, stat_name)


func create_equipment_slot_button(hero, hero_index: int, slot_id: String) -> Button:
	return StatusEquipmentMenuViewScript.create_equipment_slot_button(self, hero, hero_index, slot_id)


func show_equipment_choice_screen(hero_index: int, slot_id: String) -> void:
	StatusEquipmentMenuViewScript.show_equipment_choice_screen(self, hero_index, slot_id)


func create_equipment_choice_button(text: String) -> Button:
	return StatusEquipmentMenuViewScript.create_equipment_choice_button(self, text)


func on_equip_pressed(hero_index: int, slot_id: String, item_id: String) -> void:
	StatusEquipmentMenuViewScript.on_equip_pressed(self, hero_index, slot_id, item_id)


func on_unequip_pressed(hero_index: int, slot_id: String) -> void:
	StatusEquipmentMenuViewScript.on_unequip_pressed(self, hero_index, slot_id)


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
	MenuUIFactoryScript.clear_content(content_box)


func create_menu_button(text: String) -> Button:
	return MenuUIFactoryScript.create_menu_button(text)


func create_compact_menu_button(text: String) -> Button:
	return MenuUIFactoryScript.create_compact_menu_button(text)


func create_label(
	text: String,
	font_size: int,
	font_color: Color
) -> Label:
	return MenuUIFactoryScript.create_label(text, font_size, font_color)


func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	return MenuUIFactoryScript.create_panel(background_color, border_color, border_width)


func create_scrollable_list_inside_panel(panel: Panel) -> VBoxContainer:
	return MenuUIFactoryScript.create_scrollable_list_inside_panel(panel)


func create_empty_message_label(text: String) -> Label:
	return MenuUIFactoryScript.create_empty_message_label(text)


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
