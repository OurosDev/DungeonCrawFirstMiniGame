extends RefCounted
class_name InventoryMenuView

# ------------------------------------------------------------
# VUE INVENTAIRE
# Construit l'écran du sac commun du groupe.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")

static func show_inventory_screen(owner) -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var inventory_wrapper: VBoxContainer = VBoxContainer.new()
	inventory_wrapper.custom_minimum_size = Vector2(580, 350)
	inventory_wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	inventory_wrapper.add_theme_constant_override("separation", 6)
	owner.content_box.add_child(inventory_wrapper)

	var gold_panel: Panel = owner.create_panel(
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

	var gold_label: Label = owner.create_label("Or : " + str(gold_amount), 15, Color(1.0, 0.82, 0.35))
	gold_label.custom_minimum_size = Vector2(120, 22)
	gold_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gold_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	gold_center.add_child(gold_label)

	var list_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 210)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	list_panel.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	inventory_wrapper.add_child(list_panel)

	var inventory_list: VBoxContainer = owner.create_scrollable_list_inside_panel(list_panel)

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

		inventory_list.add_child(owner.create_inventory_row(item_id, quantity))
		visible_slot_count += 1

	if visible_slot_count <= 0:
		inventory_list.add_child(owner.create_empty_message_label("Inventaire vide."))

	var back_panel: Panel = owner.create_panel(
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

	var back_button: Button = owner.create_compact_menu_button("Retour menu")
	back_button.pressed.connect(Callable(owner, "show_main_screen"))
	back_center.add_child(back_button)

	var hint_label: Label = owner.create_label("Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	inventory_wrapper.add_child(hint_label)


static func create_inventory_row(owner, item_id: String, quantity: int) -> Control:
	var panel: Panel = owner.create_panel(
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

	var name_label: Label = owner.create_label(display_name, 12, Color(0.82, 0.76, 0.62))
	name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	name_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(name_label)

	var separator_label: Label = owner.create_label("|", 13, Color(0.56, 0.45, 0.30))
	separator_label.custom_minimum_size = Vector2(28, 20)
	separator_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	separator_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(separator_label)

	var quantity_label: Label = owner.create_label(str(quantity), 13, Color(0.92, 0.84, 0.58))
	quantity_label.custom_minimum_size = Vector2(40, 20)
	quantity_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	quantity_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(quantity_label)

	return panel


# ------------------------------------------------------------
# BOUTIQUE
# Permet d'acheter des objets basiques ou de vendre le contenu du sac sur une case B.
# ------------------------------------------------------------

