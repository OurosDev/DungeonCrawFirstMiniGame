extends RefCounted
class_name StatusEquipmentMenuView


# ------------------------------------------------------------
# VUE STATUT / ÉQUIPEMENT
# Construit les écrans de personnages, slots et choix d'équipement.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")


# ------------------------------------------------------------
# CONFIGURATION — ÉCRAN ÉQUIPEMENT
# Centralise les tailles pour éviter les chevauchements avec la police globale.
# ------------------------------------------------------------

const EQUIPMENT_WRAPPER_MIN_SIZE: Vector2 = Vector2(620, 382)

const EQUIPMENT_STATS_PANEL_SIZE: Vector2 = Vector2(560, 92)
const EQUIPMENT_SLOT_AREA_SIZE: Vector2 = Vector2(560, 198)
const EQUIPMENT_SLOT_BUTTON_SIZE: Vector2 = Vector2(540, 31)
const EQUIPMENT_SLOT_BUTTON_FONT_SIZE: int = 13
const EQUIPMENT_SLOT_LIST_MARGIN: int = 6
const EQUIPMENT_SLOT_LIST_SEPARATION: int = 4

const EQUIPMENT_BACK_AREA_SIZE: Vector2 = Vector2(560, 34)
const EQUIPMENT_BACK_BUTTON_SIZE: Vector2 = Vector2(220, 31)
const EQUIPMENT_BACK_BUTTON_FONT_SIZE: int = 13


static func show_status_screen(owner) -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var grid: GridContainer = GridContainer.new()
	grid.columns = 2
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	grid.size_flags_vertical = Control.SIZE_EXPAND_FILL
	grid.add_theme_constant_override("h_separation", 10)
	grid.add_theme_constant_override("v_separation", 10)
	owner.content_box.add_child(grid)

	var display_order: Array[int] = [0, 2, 1, 3]

	for party_index in display_order:
		var hero = null

		if party_index < owner.current_party.size():
			hero = owner.current_party[party_index]

		var hero_frame: Panel = owner.create_status_hero_frame(hero, party_index)
		grid.add_child(hero_frame)

	var hint_label: Label = owner.create_label(
		"Cliquez sur EQUIPEMENT pour gérer le héros.\nÉchap : retour au jeu",
		14,
		Color(0.70, 0.62, 0.48)
	)
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	owner.content_box.add_child(hint_label)


static func create_status_hero_frame(owner, hero, index: int) -> Panel:
	var panel: Panel = owner.create_panel(
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
		name_text = owner.get_string_property(hero, "character_name", name_text)

	var name_label: Label = owner.create_label(name_text, 15, Color(1.0, 0.82, 0.35))
	name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(name_label)

	var sub_text: String = "Emplacement vide"

	if hero != null:
		sub_text = "NIV " + str(owner.get_int_property(hero, "level", 1))
		sub_text += " "
		sub_text += owner.get_string_property(hero, "job", "")

	var sub_label: Label = owner.create_label(sub_text, 12, Color(0.85, 0.78, 0.64))
	sub_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(sub_label)

	if hero == null:
		var empty_slot_panel: Panel = owner.create_panel(
			Color(0.10, 0.07, 0.05, 1.0),
			Color(0.24, 0.16, 0.08, 1.0),
			1
		)
		empty_slot_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		empty_slot_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
		empty_slot_panel.custom_minimum_size = Vector2(0, 46)
		box.add_child(empty_slot_panel)

		var empty_slot_label: Label = owner.create_label("VIDE", 12, Color(0.65, 0.58, 0.46))
		empty_slot_label.set_anchors_preset(Control.PRESET_FULL_RECT)
		empty_slot_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty_slot_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		empty_slot_panel.add_child(empty_slot_label)

		var empty_stats_label: Label = owner.create_label("Aucune donnée.", 12, Color(0.72, 0.66, 0.56))
		empty_stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		box.add_child(empty_stats_label)

		return panel

	var equipment_button: Button = owner.create_status_equipment_button(index)
	box.add_child(equipment_button)

	var hpmp_label: Label = owner.create_label(
		"HP " + str(owner.get_int_property(hero, "hp", 0))
		+ " / " + str(owner.get_int_property(hero, "max_hp", 0))
		+ " | MP " + str(owner.get_int_property(hero, "mp", 0))
		+ " / " + str(owner.get_int_property(hero, "max_mp", 0)),
		12,
		Color(0.82, 0.76, 0.62)
	)
	hpmp_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(hpmp_label)

	var stats_label: Label = owner.create_label(
		owner.format_compact_stats(hero),
		12,
		Color(0.82, 0.76, 0.62)
	)
	stats_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(stats_label)

	return panel


# Crée le bouton explicite qui ouvre l'équipement du héros.
static func create_status_equipment_button(owner, hero_index: int) -> Button:
	var button: Button = Button.new()

	button.text = "EQUIPEMENT"
	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size = Vector2(0, 46)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.size_flags_vertical = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 13)
	button.pressed.connect(Callable(owner, "show_equipment_screen").bind(hero_index))

	return button


# ------------------------------------------------------------
# ÉQUIPEMENT
# Affiche et modifie l'équipement du héros sélectionné.
# ------------------------------------------------------------

static func show_equipment_screen(owner, hero_index: int, feedback_text: String = "") -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var hero = owner.get_hero_from_index(hero_index)

	if hero == null:
		owner.content_box.add_child(owner.create_empty_message_label("Héros introuvable."))
		return

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = EQUIPMENT_WRAPPER_MIN_SIZE
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 4)
	owner.content_box.add_child(wrapper)

	var stats_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.26, 0.17, 0.08, 1.0),
		1
	)
	stats_panel.custom_minimum_size = EQUIPMENT_STATS_PANEL_SIZE
	stats_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(stats_panel)

	owner.fill_equipment_stats_panel(stats_panel, hero)

	# Zone invisible : les boutons d'emplacement ont déjà leur propre forme.
	# Le cadre autour de toute la liste était inutile et pouvait gêner la lisibilité.
	var slot_area: MarginContainer = MarginContainer.new()
	slot_area.custom_minimum_size = EQUIPMENT_SLOT_AREA_SIZE
	slot_area.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	slot_area.add_theme_constant_override("margin_left", EQUIPMENT_SLOT_LIST_MARGIN)
	slot_area.add_theme_constant_override("margin_top", EQUIPMENT_SLOT_LIST_MARGIN)
	slot_area.add_theme_constant_override("margin_right", EQUIPMENT_SLOT_LIST_MARGIN)
	slot_area.add_theme_constant_override("margin_bottom", EQUIPMENT_SLOT_LIST_MARGIN)
	wrapper.add_child(slot_area)

	var slot_list: VBoxContainer = VBoxContainer.new()
	slot_list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	slot_list.size_flags_vertical = Control.SIZE_EXPAND_FILL
	slot_list.add_theme_constant_override("separation", EQUIPMENT_SLOT_LIST_SEPARATION)
	slot_area.add_child(slot_list)

	for slot_id in EquipmentRulesScript.get_slot_order():
		var slot_button: Button = owner.create_equipment_slot_button(hero, hero_index, slot_id)
		slot_list.add_child(slot_button)

	if feedback_text != "":
		var feedback_label: Label = owner.create_label(feedback_text, 13, Color(0.86, 0.76, 0.48))
		feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		wrapper.add_child(feedback_label)

	# Zone invisible : seul le bouton Retour statut reste visible.
	var back_center: CenterContainer = CenterContainer.new()
	back_center.custom_minimum_size = EQUIPMENT_BACK_AREA_SIZE
	back_center.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(back_center)

	var back_button: Button = owner.create_compact_menu_button("Retour statut")
	back_button.custom_minimum_size = EQUIPMENT_BACK_BUTTON_SIZE
	back_button.add_theme_font_size_override("font_size", EQUIPMENT_BACK_BUTTON_FONT_SIZE)
	back_button.pressed.connect(Callable(owner, "show_status_screen"))
	back_center.add_child(back_button)



static func fill_equipment_stats_panel(owner, panel: Panel, hero) -> void:
	var stats_box: VBoxContainer = VBoxContainer.new()
	stats_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	stats_box.offset_left = 20
	stats_box.offset_top = 6
	stats_box.offset_right = -20
	stats_box.offset_bottom = -6
	stats_box.add_theme_constant_override("separation", 2)
	panel.add_child(stats_box)

	stats_box.add_child(owner.create_stat_line(hero, "Force", "strength"))
	stats_box.add_child(owner.create_stat_line(hero, "Agilité", "agility"))
	stats_box.add_child(owner.create_stat_line(hero, "Endurance", "endurance"))
	stats_box.add_child(owner.create_stat_line(hero, "Magie", "magic_power"))


static func create_stat_line(owner, hero, display_name: String, stat_name: String) -> HBoxContainer:
	var base_value: int = owner.get_hero_base_stat(hero, stat_name)
	var bonus_value: int = owner.get_hero_equipment_bonus(hero, stat_name)
	var final_value: int = owner.get_hero_effective_stat(hero, stat_name)

	var row: HBoxContainer = HBoxContainer.new()
	row.custom_minimum_size = Vector2(520, 18)
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_theme_constant_override("separation", 8)

	var name_label: Label = owner.create_label(display_name, 12, Color(0.82, 0.76, 0.62))
	name_label.custom_minimum_size = Vector2(120, 0)
	row.add_child(name_label)

	var final_label: Label = owner.create_label(str(final_value), 12, Color(1.0, 0.82, 0.35))
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

	var bonus_label: Label = owner.create_label(bonus_text, 12, bonus_color)
	bonus_label.custom_minimum_size = Vector2(64, 0)
	bonus_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	row.add_child(bonus_label)

	var spacer: Control = Control.new()
	spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_child(spacer)

	var base_label: Label = owner.create_label("Base " + str(base_value), 12, Color(0.70, 0.62, 0.48))
	base_label.custom_minimum_size = Vector2(120, 0)
	base_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	row.add_child(base_label)

	return row


static func create_equipment_slot_button(owner, hero, hero_index: int, slot_id: String) -> Button:
	var button: Button = Button.new()

	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size = EQUIPMENT_SLOT_BUTTON_SIZE
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", EQUIPMENT_SLOT_BUTTON_FONT_SIZE)

	var item_id: String = owner.get_hero_equipped_item(hero, slot_id)
	var item_name: String = "—"

	if item_id != "":
		item_name = ItemDatabaseScript.get_display_name(item_id)

	button.text = EquipmentRulesScript.get_slot_display_name(slot_id) + " | " + item_name
	button.pressed.connect(Callable(owner, "show_equipment_choice_screen").bind(hero_index, slot_id))

	return button


static func show_equipment_choice_screen(owner, hero_index: int, slot_id: String) -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var hero = owner.get_hero_from_index(hero_index)

	if hero == null:
		owner.content_box.add_child(owner.create_empty_message_label("Héros introuvable."))
		return

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = Vector2(640, 440)
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 10)
	owner.content_box.add_child(wrapper)

	var title_text: String = EquipmentRulesScript.get_slot_display_name(slot_id)
	title_text += " — " + owner.get_string_property(hero, "character_name", "Héros")

	var title: Label = owner.create_label(title_text, 20, Color(1.0, 0.82, 0.35))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wrapper.add_child(title)

	var list_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 280)
	wrapper.add_child(list_panel)

	var list: VBoxContainer = owner.create_scrollable_list_inside_panel(list_panel)

	var current_item_id: String = owner.get_hero_equipped_item(hero, slot_id)

	if current_item_id != "":
		var remove_button: Button = owner.create_equipment_choice_button(
			"Retirer : " + ItemDatabaseScript.get_display_name(current_item_id)
		)
		remove_button.pressed.connect(Callable(owner, "on_unequip_pressed").bind(hero_index, slot_id))
		list.add_child(remove_button)

	var inventory = GameSession.get_inventory()
	var equippable_ids: Array[String] = EquipmentRulesScript.get_equippable_item_ids_for_slot(
		hero,
		slot_id,
		inventory
	)

	for item_id in equippable_ids:
		var quantity: int = GameSession.get_inventory_item_quantity(item_id)
		var option_text: String = ItemDatabaseScript.get_display_name(item_id)
		option_text += " | " + str(quantity)

		var bonus_text: String = EquipmentRulesScript.get_item_bonus_text(item_id)

		if bonus_text != "":
			option_text += " " + bonus_text

		var item_button: Button = owner.create_equipment_choice_button(option_text)
		item_button.pressed.connect(Callable(owner, "on_equip_pressed").bind(hero_index, slot_id, item_id))
		list.add_child(item_button)

	if current_item_id == "" and equippable_ids.is_empty():
		list.add_child(owner.create_empty_message_label("Aucun objet compatible dans l'inventaire."))
	elif current_item_id != "" and equippable_ids.is_empty():
		list.add_child(owner.create_empty_message_label("Aucun remplacement compatible."))

	var back_button: Button = owner.create_menu_button("Retour équipement")
	back_button.pressed.connect(Callable(owner, "show_equipment_screen").bind(hero_index))
	wrapper.add_child(back_button)

	var hint_label: Label = owner.create_label("Échap : retour au jeu", 14, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	wrapper.add_child(hint_label)


static func create_equipment_choice_button(owner, text: String) -> Button:
	var button: Button = Button.new()

	button.text = text
	button.custom_minimum_size = Vector2(520, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT

	return button


static func on_equip_pressed(owner, hero_index: int, slot_id: String, item_id: String) -> void:
	var result: Dictionary = GameSession.equip_item_to_hero(hero_index, slot_id, item_id)
	var feedback_text: String = str(result.get("message", ""))
	owner.show_equipment_screen(hero_index, feedback_text)


static func on_unequip_pressed(owner, hero_index: int, slot_id: String) -> void:
	var result: Dictionary = GameSession.unequip_item_from_hero(hero_index, slot_id)
	var feedback_text: String = str(result.get("message", ""))
	owner.show_equipment_screen(hero_index, feedback_text)


# ------------------------------------------------------------
# MENU SYSTÈME
# Gère sauvegarde, options et sortie.
# ------------------------------------------------------------
