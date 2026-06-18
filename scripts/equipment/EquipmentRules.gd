extends RefCounted
class_name EquipmentRules

# ------------------------------------------------------------
# DÉPENDANCES
# Utilise la base d'objets pour connaître slots, classes et bonus.
# ------------------------------------------------------------

const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")


# ------------------------------------------------------------
# CONSTANTES
# Définit les emplacements d'équipement internes et leurs noms affichés.
# ------------------------------------------------------------

const SLOT_WEAPON: String = "weapon"
const SLOT_HELMET: String = "helmet"
const SLOT_ARMOR: String = "armor"
const SLOT_SHIELD: String = "shield"
const SLOT_JEWELRY: String = "jewelry"

const SLOT_ORDER: Array[String] = [
	SLOT_WEAPON,
	SLOT_HELMET,
	SLOT_ARMOR,
	SLOT_SHIELD,
	SLOT_JEWELRY
]

const SLOT_DISPLAY_NAMES: Dictionary = {
	SLOT_WEAPON: "Arme",
	SLOT_HELMET: "Casque",
	SLOT_ARMOR: "Armure",
	SLOT_SHIELD: "Bouclier",
	SLOT_JEWELRY: "Bijou"
}


# ------------------------------------------------------------
# LECTURE DES SLOTS
# Fournit la liste et les noms des emplacements d'équipement.
# ------------------------------------------------------------

static func get_slot_order() -> Array[String]:
	return SLOT_ORDER.duplicate()


static func get_slot_display_name(slot_id: String) -> String:
	if SLOT_DISPLAY_NAMES.has(slot_id):
		return str(SLOT_DISPLAY_NAMES[slot_id])

	return slot_id


static func is_valid_slot(slot_id: String) -> bool:
	return SLOT_ORDER.has(slot_id)


static func create_empty_equipment() -> Dictionary:
	var equipment: Dictionary = {}

	for slot_id in SLOT_ORDER:
		equipment[slot_id] = ""

	return equipment


# ------------------------------------------------------------
# COMPATIBILITÉ
# Vérifie si un objet peut être équipé par un héros dans un slot donné.
# ------------------------------------------------------------

static func can_item_go_in_slot(item_id: String, slot_id: String) -> bool:
	if item_id == "":
		return false

	if not is_valid_slot(slot_id):
		return false

	return ItemDatabaseScript.get_equipment_slot(item_id) == slot_id


static func can_hero_equip_item(hero, item_id: String, slot_id: String) -> bool:
	if hero == null:
		return false

	if not can_item_go_in_slot(item_id, slot_id):
		return false

	var job_name: String = get_string_property(hero, "job", "")
	return ItemDatabaseScript.can_item_be_equipped_by_class(item_id, job_name)


static func get_equippable_item_ids_for_slot(hero, slot_id: String, inventory) -> Array[String]:
	var item_ids: Array[String] = []

	if hero == null:
		return item_ids

	if inventory == null:
		return item_ids

	if not inventory.has_method("get_slots"):
		return item_ids

	var seen_ids: Dictionary = {}
	var slots: Array = inventory.get_slots()

	for slot in slots:
		if not (slot is Dictionary):
			continue

		var item_id: String = str(slot.get("item_id", ""))
		var quantity: int = int(slot.get("quantity", 0))

		if item_id == "" or quantity <= 0:
			continue

		if seen_ids.has(item_id):
			continue

		if not can_hero_equip_item(hero, item_id, slot_id):
			continue

		seen_ids[item_id] = true
		item_ids.append(item_id)

	item_ids.sort_custom(func(a, b): return ItemDatabaseScript.get_display_name(a) < ItemDatabaseScript.get_display_name(b))

	return item_ids


# ------------------------------------------------------------
# BONUS
# Additionne les bonus des objets équipés.
# ------------------------------------------------------------

static func get_total_stat_bonuses(equipment: Dictionary) -> Dictionary:
	var total_bonuses: Dictionary = {
		"strength": 0,
		"agility": 0,
		"endurance": 0,
		"magic_power": 0
	}

	for slot_id in SLOT_ORDER:
		var item_id: String = str(equipment.get(slot_id, ""))

		if item_id == "":
			continue

		var item_bonuses: Dictionary = ItemDatabaseScript.get_stat_bonuses(item_id)

		for stat_name in item_bonuses.keys():
			var normalized_stat_name: String = normalize_stat_name(str(stat_name))

			if not total_bonuses.has(normalized_stat_name):
				continue

			total_bonuses[normalized_stat_name] = int(total_bonuses[normalized_stat_name]) + int(item_bonuses[stat_name])

	return total_bonuses


static func get_item_bonus_text(item_id: String) -> String:
	var bonuses: Dictionary = ItemDatabaseScript.get_stat_bonuses(item_id)
	var parts: Array[String] = []

	for stat_name in ["strength", "agility", "endurance", "magic_power"]:
		var amount: int = int(bonuses.get(stat_name, 0))

		if amount == 0:
			continue

		var sign: String = "+"
		if amount < 0:
			sign = ""

		parts.append(sign + str(amount) + " " + get_stat_display_name(stat_name))

	if parts.is_empty():
		return ""

	return ", ".join(parts)


static func get_stat_display_name(stat_name: String) -> String:
	if stat_name == "strength":
		return "FOR"

	if stat_name == "agility":
		return "AGI"

	if stat_name == "endurance":
		return "END"

	if stat_name == "magic_power":
		return "MAG"

	return stat_name


static func normalize_stat_name(stat_name: String) -> String:
	if stat_name == "magic":
		return "magic_power"

	return stat_name


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les valeurs sans dépendre fortement de la classe concrète.
# ------------------------------------------------------------

static func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


static func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
