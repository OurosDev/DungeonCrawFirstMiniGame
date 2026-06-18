extends Node

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à l'inventaire et à l'équipement global.
# ------------------------------------------------------------

const InventoryDataScript = preload("res://scripts/inventory/InventoryData.gd")
const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")
const ShopRulesScript = preload("res://scripts/shop/ShopRules.gd")


# ------------------------------------------------------------
# ÉTAT DE SESSION
# Conserve les données qui doivent survivre aux changements de scène.
# ------------------------------------------------------------

var party: Array = []
var current_floor_id: int = 1

var is_loading_save: bool = false
var pending_save_data: Dictionary = {}

var inventory = null
var gold: int = 0
var shop_available: bool = false


# ------------------------------------------------------------
# NOUVELLE PARTIE
# Réinitialise les données de session pour repartir proprement.
# ------------------------------------------------------------

func prepare_new_game() -> void:
	party.clear()
	current_floor_id = 1
	is_loading_save = false
	pending_save_data.clear()
	reset_inventory()
	set_gold(0)
	set_shop_available(false)


# ------------------------------------------------------------
# GROUPE
# Stocke et expose les héros de la partie courante.
# ------------------------------------------------------------

func set_party(p_party: Array) -> void:
	party.clear()

	for hero in p_party:
		prepare_hero_equipment(hero)
		party.append(hero)


func get_party() -> Array:
	return party


func get_hero_at_index(hero_index: int):
	if hero_index < 0:
		return null

	if hero_index >= party.size():
		return null

	return party[hero_index]


func has_party() -> bool:
	return party.size() > 0


func clear_party() -> void:
	party.clear()


# ------------------------------------------------------------
# CHARGEMENT
# Prépare les données issues d'une sauvegarde avant d'entrer dans le donjon.
# ------------------------------------------------------------

func prepare_loaded_game(save_data: Dictionary) -> void:
	party.clear()
	current_floor_id = 1
	is_loading_save = true
	pending_save_data = save_data.duplicate(true)

	if pending_save_data.has("current_floor_id"):
		current_floor_id = int(pending_save_data["current_floor_id"])

	load_inventory_from_save_data(pending_save_data.get("inventory", []))
	set_gold(int(pending_save_data.get("gold", 0)))
	set_shop_available(false)


func clear_loaded_game_data() -> void:
	is_loading_save = false
	pending_save_data.clear()


# ------------------------------------------------------------
# INVENTAIRE
# Gère le sac commun du groupe entre les scènes et les combats.
# ------------------------------------------------------------

func ensure_inventory() -> void:
	if inventory == null:
		inventory = InventoryDataScript.new()


func reset_inventory() -> void:
	inventory = InventoryDataScript.new()


func get_inventory():
	ensure_inventory()
	return inventory


func get_inventory_slot_count() -> int:
	ensure_inventory()
	return int(inventory.max_slots)


# Ajoute un objet à l'inventaire en utilisant la taille de pile définie dans ItemDatabase.
func add_inventory_item(item_id: String, quantity: int = 1) -> Dictionary:
	ensure_inventory()

	var max_stack: int = ItemDatabaseScript.get_max_stack(item_id)
	return inventory.add_item(item_id, quantity, max_stack)


func can_add_inventory_item(item_id: String, quantity: int = 1) -> bool:
	ensure_inventory()

	if not inventory.has_method("can_add_item"):
		return true

	var max_stack: int = ItemDatabaseScript.get_max_stack(item_id)
	return inventory.can_add_item(item_id, quantity, max_stack)


func remove_inventory_item(item_id: String, quantity: int = 1) -> bool:
	ensure_inventory()
	return inventory.remove_item(item_id, quantity)


func get_inventory_item_quantity(item_id: String) -> int:
	ensure_inventory()
	return inventory.get_item_quantity(item_id)


func get_inventory_save_data() -> Array:
	ensure_inventory()
	return inventory.to_save_data()


func load_inventory_from_save_data(serialized_inventory) -> void:
	ensure_inventory()
	inventory.load_from_save_data(serialized_inventory)


# ------------------------------------------------------------
# OR ET BOUTIQUE
# Gère la monnaie du groupe et l'accès contextuel au marchand.
# ------------------------------------------------------------

func set_gold(amount: int) -> void:
	gold = max(0, amount)


func get_gold() -> int:
	return gold


func add_gold(amount: int) -> void:
	gold = max(0, gold + amount)


func spend_gold(amount: int) -> bool:
	var cost: int = max(0, amount)

	if gold < cost:
		return false

	gold -= cost
	return true


func set_shop_available(available: bool) -> void:
	shop_available = available


func is_shop_available() -> bool:
	return shop_available


# Vend un exemplaire d'un objet présent dans l'inventaire.
func sell_inventory_item(item_id: String, quantity: int = 1) -> Dictionary:
	ensure_inventory()

	var result: Dictionary = create_shop_result()
	var normalized_item_id: String = item_id.strip_edges().to_lower()
	var sell_quantity: int = max(1, quantity)

	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result

	if not ShopRulesScript.can_sell_item(normalized_item_id):
		result["message"] = "Cet objet ne peut pas être vendu."
		return result

	if get_inventory_item_quantity(normalized_item_id) < sell_quantity:
		result["message"] = "Objet absent de l'inventaire."
		return result

	if not remove_inventory_item(normalized_item_id, sell_quantity):
		result["message"] = "Impossible de retirer l'objet de l'inventaire."
		return result

	var unit_price: int = ShopRulesScript.get_sell_price(normalized_item_id)
	var gained_gold: int = unit_price * sell_quantity
	add_gold(gained_gold)

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["quantity"] = sell_quantity
	result["gold_delta"] = gained_gold
	result["message"] = ItemDatabaseScript.get_display_name(normalized_item_id) + " vendu pour " + str(gained_gold) + " or."

	return result


# Achète un exemplaire d'un objet disponible chez le marchand.
func buy_shop_item(item_id: String, quantity: int = 1) -> Dictionary:
	ensure_inventory()

	var result: Dictionary = create_shop_result()
	var normalized_item_id: String = item_id.strip_edges().to_lower()
	var buy_quantity: int = max(1, quantity)

	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result

	if not ShopRulesScript.can_buy_item(normalized_item_id):
		result["message"] = "Cet objet n'est pas vendu ici."
		return result

	var unit_price: int = ShopRulesScript.get_buy_price(normalized_item_id)
	var total_price: int = unit_price * buy_quantity

	if get_gold() < total_price:
		result["message"] = "Or insuffisant."
		return result

	if not can_add_inventory_item(normalized_item_id, buy_quantity):
		result["message"] = "Inventaire plein."
		return result

	if not spend_gold(total_price):
		result["message"] = "Or insuffisant."
		return result

	var add_result: Dictionary = add_inventory_item(normalized_item_id, buy_quantity)

	if not bool(add_result.get("success", false)) or int(add_result.get("remaining_quantity", 0)) > 0:
		add_gold(total_price)
		result["message"] = "Achat annulé : inventaire plein."
		return result

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["quantity"] = buy_quantity
	result["gold_delta"] = -total_price
	result["message"] = ItemDatabaseScript.get_display_name(normalized_item_id) + " acheté pour " + str(total_price) + " or."

	return result


func create_shop_result() -> Dictionary:
	return {
		"success": false,
		"item_id": "",
		"quantity": 0,
		"gold_delta": 0,
		"message": ""
	}


# ------------------------------------------------------------
# ÉQUIPEMENT
# Équipe, déséquipe et échange les objets entre héros et inventaire.
# ------------------------------------------------------------

func prepare_hero_equipment(hero) -> void:
	if hero == null:
		return

	if hero.has_method("ensure_equipment"):
		hero.ensure_equipment()

	if hero.has_method("recalculate_equipment_stats"):
		hero.recalculate_equipment_stats()

	if hero.has_method("recalculate_derived_stats"):
		hero.recalculate_derived_stats(false)


func get_equipped_item(hero_index: int, slot_id: String) -> String:
	var hero = get_hero_at_index(hero_index)

	if hero == null:
		return ""

	if hero.has_method("get_equipped_item"):
		return hero.get_equipped_item(slot_id)

	return ""


func equip_item_to_hero(hero_index: int, slot_id: String, item_id: String) -> Dictionary:
	ensure_inventory()

	var result: Dictionary = create_equipment_result()
	var hero = get_hero_at_index(hero_index)
	var normalized_item_id: String = item_id.strip_edges().to_lower()

	if hero == null:
		result["message"] = "Héros introuvable."
		return result

	if normalized_item_id == "":
		result["message"] = "Objet invalide."
		return result

	if not EquipmentRulesScript.can_hero_equip_item(hero, normalized_item_id, slot_id):
		result["message"] = "Cet objet ne peut pas être équipé ici."
		return result

	if get_inventory_item_quantity(normalized_item_id) <= 0:
		result["message"] = "Objet absent de l'inventaire."
		return result

	var previous_item_id: String = get_equipped_item(hero_index, slot_id)

	if not remove_inventory_item(normalized_item_id, 1):
		result["message"] = "Impossible de retirer l'objet de l'inventaire."
		return result

	if previous_item_id != "":
		var return_result: Dictionary = add_inventory_item(previous_item_id, 1)

		if not bool(return_result.get("success", false)) or int(return_result.get("remaining_quantity", 0)) > 0:
			add_inventory_item(normalized_item_id, 1)
			result["message"] = "Inventaire plein : remplacement impossible."
			return result

	if hero.has_method("set_equipped_item"):
		hero.set_equipped_item(slot_id, normalized_item_id)

	prepare_hero_equipment(hero)

	result["success"] = true
	result["item_id"] = normalized_item_id
	result["previous_item_id"] = previous_item_id
	result["message"] = ItemDatabaseScript.get_display_name(normalized_item_id) + " équipé."

	return result


func unequip_item_from_hero(hero_index: int, slot_id: String) -> Dictionary:
	ensure_inventory()

	var result: Dictionary = create_equipment_result()
	var hero = get_hero_at_index(hero_index)

	if hero == null:
		result["message"] = "Héros introuvable."
		return result

	var previous_item_id: String = get_equipped_item(hero_index, slot_id)

	if previous_item_id == "":
		result["message"] = "Aucun objet à retirer."
		return result

	var return_result: Dictionary = add_inventory_item(previous_item_id, 1)

	if not bool(return_result.get("success", false)) or int(return_result.get("remaining_quantity", 0)) > 0:
		result["message"] = "Inventaire plein : impossible de retirer l'équipement."
		return result

	if hero.has_method("clear_equipped_item"):
		hero.clear_equipped_item(slot_id)

	prepare_hero_equipment(hero)

	result["success"] = true
	result["item_id"] = previous_item_id
	result["message"] = ItemDatabaseScript.get_display_name(previous_item_id) + " retiré."

	return result


func create_equipment_result() -> Dictionary:
	return {
		"success": false,
		"item_id": "",
		"previous_item_id": "",
		"message": ""
	}
