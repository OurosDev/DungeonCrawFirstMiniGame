extends Node

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------


# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à l'inventaire, à l'équipement et aux helpers de session.
# ------------------------------------------------------------
const InventoryDataScript = preload("res://scripts/inventory/InventoryData.gd")
const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")
const ShopRulesScript = preload("res://scripts/shop/ShopRules.gd")
const FloorStateHelperScript = preload("res://scripts/core/session/GameSessionFloorStateHelper.gd")
const ShopHelperScript = preload("res://scripts/core/session/GameSessionShopHelper.gd")
const EquipmentHelperScript = preload("res://scripts/core/session/GameSessionEquipmentHelper.gd")

# ------------------------------------------------------------
# ÉTAT DE SESSION
# Conserve les données qui doivent survivre aux changements de scène.
# ------------------------------------------------------------
var party: Array = []
var current_floor_id: int = 1
var is_loading_save: bool = false
var pending_save_data: Dictionary = {}
var floor_states: Dictionary = {}
var discovered_ability_ids: Array[String] = []
var active_ability_ids_by_party_slot: Dictionary = {}
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
	floor_states.clear()
	discovered_ability_ids.clear()
	active_ability_ids_by_party_slot.clear()
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

	sanitize_active_ability_ids_for_party()


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
	floor_states.clear()
	discovered_ability_ids.clear()
	if pending_save_data.has("current_floor_id"):
		current_floor_id = int(pending_save_data["current_floor_id"])
	load_floor_states_from_save_data(pending_save_data)
	load_discovered_ability_ids_from_save_data(pending_save_data.get("discovered_ability_ids", []))
	load_active_ability_ids_from_save_data(pending_save_data.get("active_ability_ids_by_party_slot", {}))
	load_inventory_from_save_data(pending_save_data.get("inventory", []))
	set_gold(int(pending_save_data.get("gold", 0)))
	set_shop_available(false)


func clear_loaded_game_data() -> void:
	is_loading_save = false
	pending_save_data.clear()

# ------------------------------------------------------------
# ÉTATS DES ÉTAGES
# Conserve les layouts modifiés et les cellules découvertes par étage.
# ------------------------------------------------------------
# Enregistre l'état sérialisable d'un étage.
func set_floor_state(floor_id: int, floor_state: Dictionary) -> void:
	FloorStateHelperScript.set_floor_state(floor_states, floor_id, floor_state)


# Retourne une copie de l'état mémorisé d'un étage.
func get_floor_state(floor_id: int) -> Dictionary:
	return FloorStateHelperScript.get_floor_state(floor_states, floor_id)


func has_floor_state(floor_id: int) -> bool:
	return FloorStateHelperScript.has_floor_state(floor_states, floor_id)


# Prépare les états d'étages depuis une sauvegarde récente ou ancienne.
func load_floor_states_from_save_data(save_data: Dictionary) -> void:
	FloorStateHelperScript.load_floor_states_from_save_data(
		floor_states,
		save_data,
		current_floor_id
	)


# Retourne une version JSON-safe de tous les états d'étages.
func get_floor_states_save_data() -> Dictionary:
	return FloorStateHelperScript.get_floor_states_save_data(floor_states)


func normalize_floor_state_for_session(floor_state: Dictionary) -> Dictionary:
	return FloorStateHelperScript.normalize_floor_state_for_session(floor_state)


func duplicate_string_array(source_array) -> Array:
	return FloorStateHelperScript.duplicate_string_array(source_array)


func duplicate_serialized_cell_array(source_array) -> Array:
	return FloorStateHelperScript.duplicate_serialized_cell_array(source_array)

# ------------------------------------------------------------
# DÉCOUVERTES DE SORTS
# Conserve les savoirs magiques trouvés par le groupe dans le donjon.
# ------------------------------------------------------------
func discover_ability(discovery_id: String) -> bool:
	var normalized_id: String = discovery_id.strip_edges()
	if normalized_id == "":
		return false

	if discovered_ability_ids.has(normalized_id):
		return false

	discovered_ability_ids.append(normalized_id)
	return true


func has_discovered_ability(discovery_id: String) -> bool:
	var normalized_id: String = discovery_id.strip_edges()
	if normalized_id == "":
		return false

	return discovered_ability_ids.has(normalized_id)


func get_discovered_ability_ids() -> Array[String]:
	var result: Array[String] = []

	for discovery_id in discovered_ability_ids:
		result.append(discovery_id)

	return result


func load_discovered_ability_ids_from_save_data(serialized_discoveries) -> void:
	discovered_ability_ids.clear()

	if not serialized_discoveries is Array:
		return

	for raw_discovery_id in serialized_discoveries:
		var discovery_id: String = str(raw_discovery_id).strip_edges()

		if discovery_id == "":
			continue

		if discovered_ability_ids.has(discovery_id):
			continue

		discovered_ability_ids.append(discovery_id)



# ------------------------------------------------------------
# SORTS ACTIFS HORS COMBAT
# Conserve les sorts préparés par emplacement de héros.
# Le combat lit ces choix au démarrage, puis peut les modifier
# temporairement avec le grimoire de combat.
# ------------------------------------------------------------
func get_party_slot_key(hero_index: int) -> String:
	return str(max(0, hero_index))


func get_active_ability_ids_for_party_slot(hero_index: int) -> Dictionary:
	var slot_key: String = get_party_slot_key(hero_index)

	if not active_ability_ids_by_party_slot.has(slot_key):
		return {}

	var slot_data = active_ability_ids_by_party_slot.get(slot_key, {})
	if slot_data is Dictionary:
		return slot_data.duplicate(true)

	return {}


func get_active_ability_id_for_party_slot(hero_index: int, ability_kind: String) -> String:
	var normalized_kind: String = ability_kind.strip_edges().to_lower()
	if normalized_kind == "":
		return ""

	var slot_data: Dictionary = get_active_ability_ids_for_party_slot(hero_index)
	return str(slot_data.get(normalized_kind, ""))


func set_active_ability_id_for_party_slot(
	hero_index: int,
	ability_kind: String,
	ability_id: String
) -> bool:
	if hero_index < 0:
		return false
	if hero_index >= party.size():
		return false

	var normalized_kind: String = ability_kind.strip_edges().to_lower()
	var normalized_ability_id: String = ability_id.strip_edges().to_lower()

	if normalized_kind != "damage" and normalized_kind != "heal":
		return false
	if normalized_ability_id == "":
		return false

	var slot_key: String = get_party_slot_key(hero_index)
	var slot_data: Dictionary = get_active_ability_ids_for_party_slot(hero_index)

	slot_data[normalized_kind] = normalized_ability_id
	active_ability_ids_by_party_slot[slot_key] = slot_data

	return true


func clear_active_ability_id_for_party_slot(hero_index: int, ability_kind: String) -> void:
	var normalized_kind: String = ability_kind.strip_edges().to_lower()
	var slot_key: String = get_party_slot_key(hero_index)

	if not active_ability_ids_by_party_slot.has(slot_key):
		return

	var slot_data = active_ability_ids_by_party_slot.get(slot_key, {})
	if not (slot_data is Dictionary):
		active_ability_ids_by_party_slot.erase(slot_key)
		return

	slot_data.erase(normalized_kind)

	if slot_data.is_empty():
		active_ability_ids_by_party_slot.erase(slot_key)
	else:
		active_ability_ids_by_party_slot[slot_key] = slot_data


func clear_active_ability_ids() -> void:
	active_ability_ids_by_party_slot.clear()


func sanitize_active_ability_ids_for_party() -> void:
	var sanitized_data: Dictionary = {}

	for hero_index in range(party.size()):
		var slot_key: String = get_party_slot_key(hero_index)
		if not active_ability_ids_by_party_slot.has(slot_key):
			continue

		var slot_data = active_ability_ids_by_party_slot.get(slot_key, {})
		if not (slot_data is Dictionary):
			continue

		var sanitized_slot_data: Dictionary = {}

		for ability_kind in ["damage", "heal"]:
			var ability_id: String = str(slot_data.get(ability_kind, "")).strip_edges().to_lower()
			if ability_id == "":
				continue
			sanitized_slot_data[ability_kind] = ability_id

		if not sanitized_slot_data.is_empty():
			sanitized_data[slot_key] = sanitized_slot_data

	active_ability_ids_by_party_slot = sanitized_data


func get_active_ability_ids_save_data() -> Dictionary:
	sanitize_active_ability_ids_for_party()
	return active_ability_ids_by_party_slot.duplicate(true)


func load_active_ability_ids_from_save_data(serialized_active_abilities) -> void:
	active_ability_ids_by_party_slot.clear()

	if not serialized_active_abilities is Dictionary:
		return

	for raw_slot_key in serialized_active_abilities.keys():
		var slot_key: String = str(raw_slot_key).strip_edges()
		if slot_key == "":
			continue

		var raw_slot_data = serialized_active_abilities.get(raw_slot_key, {})
		if not (raw_slot_data is Dictionary):
			continue

		var slot_data: Dictionary = {}

		for ability_kind in ["damage", "heal"]:
			var ability_id: String = str(raw_slot_data.get(ability_kind, "")).strip_edges().to_lower()
			if ability_id == "":
				continue
			slot_data[ability_kind] = ability_id

		if not slot_data.is_empty():
			active_ability_ids_by_party_slot[slot_key] = slot_data

	sanitize_active_ability_ids_for_party()

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
	return ShopHelperScript.sell_inventory_item(
		self,
		ItemDatabaseScript,
		ShopRulesScript,
		item_id,
		quantity
	)


# Achète un exemplaire d'un objet disponible chez le marchand.
func buy_shop_item(item_id: String, quantity: int = 1) -> Dictionary:
	return ShopHelperScript.buy_shop_item(
		self,
		ItemDatabaseScript,
		ShopRulesScript,
		item_id,
		quantity
	)


func create_shop_result() -> Dictionary:
	return ShopHelperScript.create_shop_result()

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
	return EquipmentHelperScript.equip_item_to_hero(
		self,
		EquipmentRulesScript,
		ItemDatabaseScript,
		hero_index,
		slot_id,
		item_id
	)


func unequip_item_from_hero(hero_index: int, slot_id: String) -> Dictionary:
	return EquipmentHelperScript.unequip_item_from_hero(
		self,
		ItemDatabaseScript,
		hero_index,
		slot_id
	)


func create_equipment_result() -> Dictionary:
	return EquipmentHelperScript.create_equipment_result()
