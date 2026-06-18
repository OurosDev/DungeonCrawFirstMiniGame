extends RefCounted

# ------------------------------------------------------------
# HELPERS BOUTIQUE
# Centralise les règles d'achat et de vente appliquées par GameSession.
# ------------------------------------------------------------

# Crée le dictionnaire standard retourné par les actions de boutique.
static func create_shop_result() -> Dictionary:
	return {
		"success": false,
		"item_id": "",
		"quantity": 0,
		"gold_delta": 0,
		"message": ""
	}


# Vend une quantité d'un objet présent dans l'inventaire commun.
static func sell_inventory_item(
	session,
	item_database_script,
	shop_rules_script,
	item_id: String,
	quantity: int = 1
) -> Dictionary:
	session.ensure_inventory()
	var result: Dictionary = create_shop_result()
	var normalized_item_id: String = item_id.strip_edges().to_lower()
	var sell_quantity: int = max(1, quantity)

	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result
	if not shop_rules_script.can_sell_item(normalized_item_id):
		result["message"] = "Cet objet ne peut pas être vendu."
		return result
	if session.get_inventory_item_quantity(normalized_item_id) < sell_quantity:
		result["message"] = "Objet absent de l'inventaire."
		return result
	if not session.remove_inventory_item(normalized_item_id, sell_quantity):
		result["message"] = "Impossible de retirer l'objet de l'inventaire."
		return result

	var unit_price: int = shop_rules_script.get_sell_price(normalized_item_id)
	var gained_gold: int = unit_price * sell_quantity
	session.add_gold(gained_gold)

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["quantity"] = sell_quantity
	result["gold_delta"] = gained_gold
	result["message"] = item_database_script.get_display_name(normalized_item_id) + " vendu pour " + str(gained_gold) + " or."
	return result


# Achète une quantité d'un objet disponible chez le marchand.
static func buy_shop_item(
	session,
	item_database_script,
	shop_rules_script,
	item_id: String,
	quantity: int = 1
) -> Dictionary:
	session.ensure_inventory()
	var result: Dictionary = create_shop_result()
	var normalized_item_id: String = item_id.strip_edges().to_lower()
	var buy_quantity: int = max(1, quantity)

	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result
	if not shop_rules_script.can_buy_item(normalized_item_id):
		result["message"] = "Cet objet n'est pas vendu ici."
		return result

	var unit_price: int = shop_rules_script.get_buy_price(normalized_item_id)
	var total_price: int = unit_price * buy_quantity
	if session.get_gold() < total_price:
		result["message"] = "Or insuffisant."
		return result
	if not session.can_add_inventory_item(normalized_item_id, buy_quantity):
		result["message"] = "Inventaire plein."
		return result
	if not session.spend_gold(total_price):
		result["message"] = "Or insuffisant."
		return result

	var add_result: Dictionary = session.add_inventory_item(normalized_item_id, buy_quantity)
	if not bool(add_result.get("success", false)) or int(add_result.get("remaining_quantity", 0)) > 0:
		session.add_gold(total_price)
		result["message"] = "Achat annulé : inventaire plein."
		return result

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["quantity"] = buy_quantity
	result["gold_delta"] = -total_price
	result["message"] = item_database_script.get_display_name(normalized_item_id) + " acheté pour " + str(total_price) + " or."
	return result
