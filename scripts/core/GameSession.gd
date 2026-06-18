extends Node

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à l'inventaire et à l'équipement global.
# ------------------------------------------------------------

const InventoryDataScript = preload("res://scripts/inventory/InventoryData.gd")
const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")


# ------------------------------------------------------------
# ÉTAT DE SESSION
# Conserve les données qui doivent survivre aux changements de scène.
# ------------------------------------------------------------

var party: Array = []
var current_floor_id: int = 1

var is_loading_save: bool = false
var pending_save_data: Dictionary = {}

var inventory = null


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
