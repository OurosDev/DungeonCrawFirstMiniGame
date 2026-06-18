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
# Utilise la base d'objets pour afficher l'inventaire du groupe.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")


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
	set_menu_chrome_visible(true)
	clear_content()

	title_label.text = "MENU D'AVENTURE"
	message_label.text = "Échap : fermer le menu"

	var inventory_button: Button = create_menu_button("Inventaire")
	inventory_button.pressed.connect(show_inventory_screen)
	content_box.add_child(inventory_button)

	var grimoire_button: Button = create_menu_button("Grimoire")
	grimoire_button.pressed.connect(show_grimoire_screen)
	content_box.add_child(grimoire_button)

	var status_button: Button = create_menu_button("Statut")
	status_button.pressed.connect(show_status_screen)
	content_box.add_child(status_button)

	var system_button: Button = create_menu_button("Menu")
	system_button.pressed.connect(show_system_screen)
	content_box.add_child(system_button)


# ------------------------------------------------------------
# INVENTAIRE
# Affiche les 24 emplacements du sac commun du groupe.
# ------------------------------------------------------------

func show_inventory_screen() -> void:
	set_menu_chrome_visible(false)
	clear_content()

	var inventory_wrapper: VBoxContainer = VBoxContainer.new()
	inventory_wrapper.custom_minimum_size = Vector2(580, 370)
	inventory_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	inventory_wrapper.add_theme_constant_override("separation", 12)
	content_box.add_child(inventory_wrapper)

	var list_panel: Panel = create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 320)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	list_panel.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.add_child(list_panel)

	var list_margin: MarginContainer = MarginContainer.new()
	list_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	list_margin.add_theme_constant_override("margin_left", 14)
	list_margin.add_theme_constant_override("margin_top", 12)
	list_margin.add_theme_constant_override("margin_right", 14)
	list_margin.add_theme_constant_override("margin_bottom", 12)
	list_panel.add_child(list_margin)

	var inventory_scroll: ScrollContainer = ScrollContainer.new()
	inventory_scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inventory_scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	inventory_scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	inventory_scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	list_margin.add_child(inventory_scroll)

	var inventory_list: VBoxContainer = VBoxContainer.new()
	inventory_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inventory_list.add_theme_constant_override("separation", 4)
	inventory_scroll.add_child(inventory_list)

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
		var empty_label: Label = create_label("Inventaire vide.", 14, Color(0.62, 0.56, 0.46))
		empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		empty_label.custom_minimum_size = Vector2(0, 44)
		inventory_list.add_child(empty_label)

	var hint_label: Label = create_label("Échap : retour au jeu", 14, Color(0.70, 0.62, 0.48))
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

	var display_name: String = "—"
	var quantity_text: String = ""
	var name_color: Color = Color(0.46, 0.41, 0.34)
	var separator_color: Color = Color(0.30, 0.24, 0.18)
	var quantity_color: Color = Color(0.46, 0.41, 0.34)

	if item_id != "" and quantity > 0:
		display_name = ItemDatabaseScript.get_display_name(item_id)
		quantity_text = str(quantity)
		name_color = Color(0.82, 0.76, 0.62)
		separator_color = Color(0.56, 0.45, 0.30)
		quantity_color = Color(0.92, 0.84, 0.58)

	var name_label: Label = create_label(display_name, 13, name_color)
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(name_label)

	var separator_label: Label = create_label("|", 13, separator_color)
	separator_label.custom_minimum_size = Vector2(28, 20)
	separator_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	separator_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(separator_label)

	var quantity_label: Label = create_label(quantity_text, 13, quantity_color)
	quantity_label.custom_minimum_size = Vector2(40, 20)
	quantity_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	quantity_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(quantity_label)

	return panel

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

	var portrait_panel: Panel = create_panel(
		Color(0.10, 0.07, 0.05, 1.0),
		Color(0.24, 0.16, 0.08, 1.0),
		1
	)
	portrait_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	portrait_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	portrait_panel.custom_minimum_size = Vector2(0, 46)
	box.add_child(portrait_panel)

	var portrait_label: Label = create_label("", 12, Color(0.65, 0.58, 0.46))
	portrait_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	portrait_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	portrait_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER

	if hero == null:
		portrait_label.text = "VIDE"
	else:
		portrait_label.text = get_string_property(hero, "job", "").to_upper()

	portrait_panel.add_child(portrait_label)

	if hero == null:
		var empty_stats_label: Label = create_label("Aucune donnée.", 12, Color(0.72, 0.66, 0.56))
		empty_stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		box.add_child(empty_stats_label)
		return panel

	var hpmp_label: Label = create_label(
		"HP " + str(get_int_property(hero, "hp", 0)) + " / " + str(get_int_property(hero, "max_hp", 0)) + " | MP " + str(get_int_property(hero, "mp", 0)) + " / " + str(get_int_property(hero, "max_mp", 0)),
		12,
		Color(0.82, 0.76, 0.62)
	)
	hpmp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(hpmp_label)

	var stats = get_property_value(hero, "stats", null)
	var stats_text: String = "FOR 0 AGI 0 END 0 MAG 0"

	if stats != null:
		stats_text = "FOR " + str(get_int_property(stats, "strength", 0))
		stats_text += " AGI " + str(get_int_property(stats, "agility", 0))
		stats_text += " END " + str(get_int_property(stats, "endurance", 0))
		stats_text += " MAG " + str(get_int_property(stats, "magic_power", 0))

	var stats_label: Label = create_label(stats_text, 12, Color(0.82, 0.76, 0.62))
	stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(stats_label)

	return panel


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
# Crée les composants visuels communs du menu.
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


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les propriétés des héros sans dépendre trop fortement des classes concrètes.
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


# ------------------------------------------------------------
# SÉCURITÉ UI
# Construit l'interface si elle est appelée trop tôt.
# ------------------------------------------------------------

func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
