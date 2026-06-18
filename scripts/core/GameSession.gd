extends Node

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à l'inventaire global de session.
# ------------------------------------------------------------

const InventoryDataScript = preload("res://scripts/inventory/InventoryData.gd")
const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")


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
		party.append(hero)


func get_party() -> Array:
	return party


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


func remove_inventory_item(item_id: String, quantity: int = 1) -> bool:
	ensure_inventory()
	return inventory.remove_item(item_id, quantity)


func get_inventory_save_data() -> Array:
	ensure_inventory()
	return inventory.to_save_data()


func load_inventory_from_save_data(serialized_inventory) -> void:
	ensure_inventory()
	inventory.load_from_save_data(serialized_inventory)
