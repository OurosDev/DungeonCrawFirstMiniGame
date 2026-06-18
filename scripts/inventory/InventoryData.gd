extends RefCounted
class_name InventoryData

# ------------------------------------------------------------
# CONSTANTES
# Définit les limites de l'inventaire commun du groupe.
# ------------------------------------------------------------

const DEFAULT_MAX_SLOTS: int = 24
const DEFAULT_MAX_STACK: int = 9


# ------------------------------------------------------------
# ÉTAT
# Stocke les piles d'objets dans l'ordre d'affichage.
# ------------------------------------------------------------

var max_slots: int = DEFAULT_MAX_SLOTS
var slots: Array = []


# ------------------------------------------------------------
# INITIALISATION
# Prépare un inventaire avec une capacité donnée.
# ------------------------------------------------------------

func _init(p_max_slots: int = DEFAULT_MAX_SLOTS) -> void:
	max_slots = max(1, p_max_slots)
	clear()


func clear() -> void:
	slots.clear()


# ------------------------------------------------------------
# AJOUT D'OBJETS
# Ajoute une quantité en remplissant d'abord les piles existantes.
# ------------------------------------------------------------

func add_item(
	item_id: String,
	quantity: int = 1,
	max_stack: int = DEFAULT_MAX_STACK
) -> Dictionary:
	var result: Dictionary = create_add_result(item_id, quantity)

	var normalized_id: String = normalize_item_id(item_id)
	var remaining_quantity: int = max(0, quantity)
	var stack_limit: int = max(1, max_stack)

	if normalized_id == "" or remaining_quantity <= 0:
		result["remaining_quantity"] = remaining_quantity
		return result

	remaining_quantity = fill_existing_stacks(
		normalized_id,
		remaining_quantity,
		stack_limit,
		result
	)

	remaining_quantity = create_new_stacks(
		normalized_id,
		remaining_quantity,
		stack_limit,
		result
	)

	result["added_quantity"] = int(result["requested_quantity"]) - remaining_quantity
	result["remaining_quantity"] = remaining_quantity
	result["success"] = int(result["added_quantity"]) > 0
	result["inventory_full"] = remaining_quantity > 0

	return result


# Remplit les piles existantes du même objet avant de consommer des emplacements libres.
func fill_existing_stacks(
	item_id: String,
	quantity: int,
	max_stack: int,
	result: Dictionary
) -> int:
	var remaining_quantity: int = quantity

	for slot in slots:
		if remaining_quantity <= 0:
			break

		if not (slot is Dictionary):
			continue

		if str(slot.get("item_id", "")) != item_id:
			continue

		var current_quantity: int = int(slot.get("quantity", 0))
		if current_quantity >= max_stack:
			continue

		var free_amount: int = max_stack - current_quantity
		var amount_to_add: int = min(free_amount, remaining_quantity)

		slot["quantity"] = current_quantity + amount_to_add
		remaining_quantity -= amount_to_add
		result["updated_slots"] = int(result["updated_slots"]) + 1

	return remaining_quantity


# Crée de nouvelles piles tant qu'il reste de la place dans l'inventaire.
func create_new_stacks(
	item_id: String,
	quantity: int,
	max_stack: int,
	result: Dictionary
) -> int:
	var remaining_quantity: int = quantity

	while remaining_quantity > 0 and slots.size() < max_slots:
		var amount_to_add: int = min(max_stack, remaining_quantity)

		slots.append({
			"item_id": item_id,
			"quantity": amount_to_add
		})

		remaining_quantity -= amount_to_add
		result["created_slots"] = int(result["created_slots"]) + 1

	return remaining_quantity


func create_add_result(item_id: String, quantity: int) -> Dictionary:
	return {
		"success": false,
		"item_id": normalize_item_id(item_id),
		"requested_quantity": max(0, quantity),
		"added_quantity": 0,
		"remaining_quantity": max(0, quantity),
		"created_slots": 0,
		"updated_slots": 0,
		"inventory_full": false
	}


# ------------------------------------------------------------
# RETRAIT D'OBJETS
# Retire une quantité en parcourant les piles depuis la fin.
# ------------------------------------------------------------

func remove_item(item_id: String, quantity: int = 1) -> bool:
	var normalized_id: String = normalize_item_id(item_id)
	var remaining_quantity: int = max(0, quantity)

	if normalized_id == "" or remaining_quantity <= 0:
		return false

	if get_item_quantity(normalized_id) < remaining_quantity:
		return false

	for i in range(slots.size() - 1, -1, -1):
		if remaining_quantity <= 0:
			break

		var slot = slots[i]

		if not (slot is Dictionary):
			slots.remove_at(i)
			continue

		if str(slot.get("item_id", "")) != normalized_id:
			continue

		var current_quantity: int = int(slot.get("quantity", 0))
		var amount_to_remove: int = min(current_quantity, remaining_quantity)

		current_quantity -= amount_to_remove
		remaining_quantity -= amount_to_remove

		if current_quantity <= 0:
			slots.remove_at(i)
		else:
			slot["quantity"] = current_quantity

	return true


# ------------------------------------------------------------
# LECTURE
# Fournit les informations utiles à l'UI et aux sauvegardes.
# ------------------------------------------------------------

func get_item_quantity(item_id: String) -> int:
	var normalized_id: String = normalize_item_id(item_id)
	var total_quantity: int = 0

	for slot in slots:
		if not (slot is Dictionary):
			continue

		if str(slot.get("item_id", "")) == normalized_id:
			total_quantity += int(slot.get("quantity", 0))

	return total_quantity


func get_slots() -> Array:
	return slots.duplicate(true)


func get_used_slots_count() -> int:
	return slots.size()


func get_free_slots_count() -> int:
	return max(0, max_slots - slots.size())


func is_full() -> bool:
	return slots.size() >= max_slots


func is_empty() -> bool:
	return slots.is_empty()


# ------------------------------------------------------------
# SAUVEGARDE
# Sérialise et restaure les piles d'objets.
# ------------------------------------------------------------

func to_save_data() -> Array:
	var serialized_slots: Array = []

	for slot in slots:
		if not (slot is Dictionary):
			continue

		var item_id: String = normalize_item_id(str(slot.get("item_id", "")))
		var quantity: int = int(slot.get("quantity", 0))

		if item_id == "" or quantity <= 0:
			continue

		serialized_slots.append({
			"item_id": item_id,
			"quantity": quantity
		})

	return serialized_slots


func load_from_save_data(serialized_slots) -> void:
	clear()

	if not (serialized_slots is Array):
		return

	for slot_data in serialized_slots:
		if not (slot_data is Dictionary):
			continue

		if slots.size() >= max_slots:
			return

		var item_id: String = normalize_item_id(str(slot_data.get("item_id", "")))
		var quantity: int = int(slot_data.get("quantity", 0))

		if item_id == "" or quantity <= 0:
			continue

		slots.append({
			"item_id": item_id,
			"quantity": quantity
		})


# ------------------------------------------------------------
# HELPERS
# Nettoie les identifiants d'objets.
# ------------------------------------------------------------

func normalize_item_id(item_id: String) -> String:
	return item_id.strip_edges().to_lower()
