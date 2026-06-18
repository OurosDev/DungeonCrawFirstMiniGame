extends RefCounted
class_name ShopMenuView

# ------------------------------------------------------------
# VUE BOUTIQUE
# Construit les écrans d'achat et de vente disponibles sur une case B.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const ShopRulesScript = preload("res://scripts/shop/ShopRules.gd")

static func show_shop_screen(owner, feedback_text: String = "") -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var shop_wrapper: VBoxContainer = owner.create_shop_wrapper(Vector2(420, 280), 8)
	owner.content_box.add_child(shop_wrapper)

	shop_wrapper.add_child(owner.create_shop_gold_panel())

	if feedback_text != "":
		shop_wrapper.add_child(owner.create_shop_feedback_label(feedback_text))

	var buy_button: Button = owner.create_menu_button("Acheter")
	buy_button.pressed.connect(Callable(owner, "show_shop_buy_screen"))
	shop_wrapper.add_child(buy_button)

	var sell_button: Button = owner.create_menu_button("Vendre")
	sell_button.pressed.connect(Callable(owner, "show_shop_sell_screen"))
	shop_wrapper.add_child(sell_button)

	var back_button: Button = owner.create_menu_button("Retour menu")
	back_button.pressed.connect(Callable(owner, "show_main_screen"))
	shop_wrapper.add_child(back_button)

	var hint_label: Label = owner.create_label("Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_wrapper.add_child(hint_label)


static func show_shop_buy_screen(owner, feedback_text: String = "") -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var shop_wrapper: VBoxContainer = owner.create_shop_wrapper(Vector2(600, 380), 6)
	owner.content_box.add_child(shop_wrapper)

	shop_wrapper.add_child(owner.create_shop_gold_panel())

	if feedback_text != "":
		shop_wrapper.add_child(owner.create_shop_feedback_label(feedback_text))

	var list_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 205)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	shop_wrapper.add_child(list_panel)

	var shop_list: VBoxContainer = owner.create_scrollable_list_inside_panel(list_panel)
	var buyable_count: int = owner.add_shop_buy_rows(shop_list)

	if buyable_count <= 0:
		shop_list.add_child(owner.create_empty_message_label("Aucun objet à acheter."))

	shop_wrapper.add_child(owner.create_shop_back_panel("Retour boutique", Callable(owner, "show_shop_screen")))

	var hint_label: Label = owner.create_label("Cliquez sur un objet pour en acheter 1. Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_wrapper.add_child(hint_label)


static func show_shop_sell_screen(owner, feedback_text: String = "") -> void:
	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var shop_wrapper: VBoxContainer = owner.create_shop_wrapper(Vector2(600, 380), 6)
	owner.content_box.add_child(shop_wrapper)

	shop_wrapper.add_child(owner.create_shop_gold_panel())

	if feedback_text != "":
		shop_wrapper.add_child(owner.create_shop_feedback_label(feedback_text))

	var list_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		2
	)
	list_panel.custom_minimum_size = Vector2(560, 205)
	list_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	shop_wrapper.add_child(list_panel)

	var shop_list: VBoxContainer = owner.create_scrollable_list_inside_panel(list_panel)
	var sellable_count: int = owner.add_sellable_inventory_rows(shop_list)

	if sellable_count <= 0:
		shop_list.add_child(owner.create_empty_message_label("Aucun objet à vendre."))

	shop_wrapper.add_child(owner.create_shop_back_panel("Retour boutique", Callable(owner, "show_shop_screen")))

	var hint_label: Label = owner.create_label("Cliquez sur un objet pour en vendre 1. Échap : retour au jeu", 12, Color(0.70, 0.62, 0.48))
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	shop_wrapper.add_child(hint_label)


static func create_shop_wrapper(owner, minimum_size: Vector2, separation: int) -> VBoxContainer:
	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = minimum_size
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", separation)
	return wrapper


static func create_shop_gold_panel(owner) -> Panel:
	var gold_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	gold_panel.custom_minimum_size = Vector2(150, 34)
	gold_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

	var gold_center: CenterContainer = CenterContainer.new()
	gold_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	gold_center.offset_left = 8
	gold_center.offset_top = 3
	gold_center.offset_right = -8
	gold_center.offset_bottom = -3
	gold_panel.add_child(gold_center)

	var gold_label: Label = owner.create_label("Or : " + str(GameSession.get_gold()), 15, Color(1.0, 0.82, 0.35))
	gold_label.custom_minimum_size = Vector2(120, 22)
	gold_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	gold_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	gold_center.add_child(gold_label)

	return gold_panel


static func create_shop_feedback_label(owner, feedback_text: String) -> Label:
	var feedback_label: Label = owner.create_label(feedback_text, 13, Color(0.86, 0.76, 0.48))
	feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	return feedback_label


static func create_shop_back_panel(owner, button_text: String, callback: Callable) -> Panel:
	var back_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	back_panel.custom_minimum_size = Vector2(560, 38)
	back_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

	var back_center: CenterContainer = CenterContainer.new()
	back_center.set_anchors_preset(Control.PRESET_FULL_RECT)
	back_center.offset_left = 8
	back_center.offset_top = 4
	back_center.offset_right = -8
	back_center.offset_bottom = -4
	back_panel.add_child(back_center)

	var back_button: Button = owner.create_compact_menu_button(button_text)
	back_button.pressed.connect(callback)
	back_center.add_child(back_button)

	return back_panel


static func add_shop_buy_rows(owner, shop_list: VBoxContainer) -> int:
	var buyable_count: int = 0
	var item_ids: Array[String] = ShopRulesScript.get_shop_buy_item_ids()

	for item_id in item_ids:
		if not ShopRulesScript.can_buy_item(item_id):
			continue

		shop_list.add_child(owner.create_shop_buy_button(item_id))
		buyable_count += 1

	return buyable_count


static func create_shop_buy_button(owner, item_id: String) -> Button:
	var button: Button = Button.new()
	var display_name: String = ItemDatabaseScript.get_display_name(item_id)
	var buy_price: int = ShopRulesScript.get_buy_price(item_id)

	button.text = display_name + "     |     " + str(buy_price) + " or"
	button.custom_minimum_size = Vector2(520, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.pressed.connect(Callable(owner, "on_shop_buy_pressed").bind(item_id))

	return button


static func on_shop_buy_pressed(owner, item_id: String) -> void:
	var result: Dictionary = GameSession.buy_shop_item(item_id, 1)
	var feedback_text: String = str(result.get("message", ""))
	owner.show_shop_buy_screen(feedback_text)


static func add_sellable_inventory_rows(owner, shop_list: VBoxContainer) -> int:
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

		shop_list.add_child(owner.create_shop_sell_button(item_id, quantity))
		sellable_count += 1

	return sellable_count


static func create_shop_sell_button(owner, item_id: String, quantity: int) -> Button:
	var button: Button = Button.new()
	var display_name: String = ItemDatabaseScript.get_display_name(item_id)
	var sell_price: int = ShopRulesScript.get_sell_price(item_id)

	button.text = display_name + "     |     " + str(quantity) + "     |     " + str(sell_price) + " or"
	button.custom_minimum_size = Vector2(520, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)
	button.alignment = HORIZONTAL_ALIGNMENT_LEFT
	button.pressed.connect(Callable(owner, "on_shop_sell_pressed").bind(item_id))

	return button


static func on_shop_sell_pressed(owner, item_id: String) -> void:
	var result: Dictionary = GameSession.sell_inventory_item(item_id, 1)
	var feedback_text: String = str(result.get("message", ""))
	owner.show_shop_sell_screen(feedback_text)


# ------------------------------------------------------------
# GRIMOIRE
# Placeholder conservé pour une future version.
# ------------------------------------------------------------

