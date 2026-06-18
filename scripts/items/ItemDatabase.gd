extends RefCounted
class_name ItemDatabase

# ------------------------------------------------------------
# DÉPENDANCES
# Fournit la structure de données utilisée par les objets.
# ------------------------------------------------------------

const ItemDataScript = preload("res://scripts/items/ItemData.gd")


# ------------------------------------------------------------
# CONSTANTES
# Définit les limites communes des objets de l'inventaire et de l'équipement.
# ------------------------------------------------------------

const DEFAULT_MAX_STACK: int = 9

const SLOT_NONE: String = ""
const SLOT_WEAPON: String = "weapon"
const SLOT_HELMET: String = "helmet"
const SLOT_ARMOR: String = "armor"
const SLOT_SHIELD: String = "shield"
const SLOT_JEWELRY: String = "jewelry"

const JOB_WARRIOR: String = "Guerrier"
const JOB_THIEF: String = "Voleuse"
const JOB_MAGE: String = "Mage"
const JOB_CLERIC: String = "Prêtresse"


# ------------------------------------------------------------
# ACCÈS AUX OBJETS
# Retourne les données officielles d'un objet depuis son identifiant.
# ------------------------------------------------------------

static func get_item_data(item_id: String):
	var normalized_id: String = normalize_item_id(item_id)
	var item_definitions: Dictionary = get_item_definitions()

	if not item_definitions.has(normalized_id):
		return create_unknown_item(normalized_id)

	var data: Dictionary = item_definitions[normalized_id]

	return ItemDataScript.new(
		normalized_id,
		str(data.get("display_name", normalized_id)),
		str(data.get("item_type", "misc")),
		str(data.get("description", "")),
		int(data.get("sell_value", 0)),
		int(data.get("max_stack", DEFAULT_MAX_STACK)),
		str(data.get("equipment_slot", SLOT_NONE)),
		create_string_array(data.get("allowed_classes", [])),
		create_bonus_dictionary(data.get("stat_bonuses", {}))
	)


static func has_item(item_id: String) -> bool:
	return get_item_definitions().has(normalize_item_id(item_id))


static func get_display_name(item_id: String) -> String:
	var item = get_item_data(item_id)
	return str(item.display_name)


static func get_item_type(item_id: String) -> String:
	var item = get_item_data(item_id)
	return str(item.item_type)


static func get_description(item_id: String) -> String:
	var item = get_item_data(item_id)
	return str(item.description)


static func get_sell_value(item_id: String) -> int:
	var item = get_item_data(item_id)
	return int(item.sell_value)


static func get_max_stack(item_id: String) -> int:
	var item = get_item_data(item_id)
	return max(1, int(item.max_stack))


static func get_equipment_slot(item_id: String) -> String:
	var item = get_item_data(item_id)
	return str(item.equipment_slot)


static func get_allowed_classes(item_id: String) -> Array[String]:
	var item = get_item_data(item_id)
	return item.allowed_classes.duplicate()


static func get_stat_bonuses(item_id: String) -> Dictionary:
	var item = get_item_data(item_id)
	return item.stat_bonuses.duplicate(true)


static func is_equippable(item_id: String) -> bool:
	return get_equipment_slot(item_id) != SLOT_NONE


static func can_item_be_equipped_by_class(item_id: String, job_name: String) -> bool:
	var item = get_item_data(item_id)
	return item.can_be_equipped_by_class(job_name)


static func get_all_item_ids() -> Array[String]:
	var ids: Array[String] = []

	for item_id in get_item_definitions().keys():
		ids.append(str(item_id))

	ids.sort()
	return ids


# ------------------------------------------------------------
# BASE D'OBJETS
# Centralise les objets déjà utilisés dans les loot tables des monstres.
# ------------------------------------------------------------

static func get_item_definitions() -> Dictionary:
	return {
		"rusty_sword": create_equippable_item_definition(
			"Épée rouillée",
			"weapon",
			"Une vieille lame piquée par la rouille. Peu fiable, mais encore utilisable.",
			4,
			SLOT_WEAPON,
			[JOB_WARRIOR, JOB_THIEF, JOB_CLERIC],
			{"strength": 1}
		),
		"worn_tunic": create_equippable_item_definition(
			"Tunique usée",
			"armor",
			"Une tunique élimée qui offre une protection minimale.",
			2,
			SLOT_ARMOR,
			[JOB_WARRIOR, JOB_THIEF, JOB_MAGE, JOB_CLERIC],
			{"endurance": 1}
		),
		"cracked_shield": create_equippable_item_definition(
			"Bouclier fendu",
			"shield",
			"Un petit bouclier fissuré, encore capable d'encaisser un choc.",
			3,
			SLOT_SHIELD,
			[JOB_WARRIOR, JOB_CLERIC],
			{"endurance": 1}
		),
		"torn_cloak": create_equippable_item_definition(
			"Cape déchirée",
			"armor",
			"Une cape sombre et abîmée qui facilite les mouvements discrets.",
			2,
			SLOT_ARMOR,
			[JOB_THIEF, JOB_MAGE, JOB_CLERIC],
			{"agility": 1}
		),
		"fragile_dagger": create_equippable_item_definition(
			"Dague fragile",
			"weapon",
			"Une dague légère dont la pointe menace de céder.",
			3,
			SLOT_WEAPON,
			[JOB_THIEF, JOB_MAGE],
			{"agility": 1}
		),
		"tarnished_ring": create_equippable_item_definition(
			"Anneau terni",
			"accessory",
			"Un anneau sans éclat, couvert d'une fine couche de crasse.",
			5,
			SLOT_JEWELRY,
			[JOB_WARRIOR, JOB_THIEF, JOB_MAGE, JOB_CLERIC],
			{"magic_power": 1}
		),
		"goblin_dagger": create_equippable_item_definition(
			"Dague gobeline",
			"weapon",
			"Une lame courte, sale et mal équilibrée, typique des gobelins.",
			6,
			SLOT_WEAPON,
			[JOB_THIEF],
			{"agility": 2}
		),
		"short_bow": create_equippable_item_definition(
			"Arc court",
			"weapon",
			"Un arc simple, usé mais encore souple.",
			7,
			SLOT_WEAPON,
			[JOB_THIEF],
			{"agility": 1}
		),
		"leather_vest": create_equippable_item_definition(
			"Gilet de cuir",
			"armor",
			"Un gilet de cuir léger, marqué par les coups.",
			6,
			SLOT_ARMOR,
			[JOB_WARRIOR, JOB_THIEF, JOB_CLERIC],
			{"endurance": 1}
		),
		"small_shield": create_equippable_item_definition(
			"Petit bouclier",
			"shield",
			"Un bouclier rond et basique, facile à transporter.",
			5,
			SLOT_SHIELD,
			[JOB_WARRIOR, JOB_THIEF, JOB_CLERIC],
			{"endurance": 1}
		),
		"heavy_club": create_equippable_item_definition(
			"Masse lourde",
			"weapon",
			"Une arme primitive, lourde, mais dangereuse entre de bonnes mains.",
			10,
			SLOT_WEAPON,
			[JOB_WARRIOR, JOB_CLERIC],
			{"strength": 2}
		),
		"reinforced_leather": create_equippable_item_definition(
			"Cuir renforcé",
			"armor",
			"Une protection de cuir épais renforcée par des plaques grossières.",
			9,
			SLOT_ARMOR,
			[JOB_WARRIOR, JOB_CLERIC],
			{"endurance": 2}
		),
		"chipped_axe": create_equippable_item_definition(
			"Hache ébréchée",
			"weapon",
			"Une hache brutale dont le tranchant a souffert.",
			8,
			SLOT_WEAPON,
			[JOB_WARRIOR],
			{"strength": 2}
		),
		"thick_boots": create_equippable_item_definition(
			"Bottes épaisses",
			"armor",
			"Des bottes lourdes qui protègent bien les pieds.",
			6,
			SLOT_ARMOR,
			[JOB_WARRIOR, JOB_THIEF, JOB_CLERIC],
			{"endurance": 1}
		),
		"trollhide_vest": create_equippable_item_definition(
			"Gilet de peau de troll",
			"armor",
			"Un gilet répugnant, solide et étonnamment résistant.",
			18,
			SLOT_ARMOR,
			[JOB_WARRIOR],
			{"endurance": 3}
		),
		"ancient_blade": create_equippable_item_definition(
			"Lame ancienne",
			"weapon",
			"Une lame ancienne dont le métal garde une lueur froide.",
			16,
			SLOT_WEAPON,
			[JOB_WARRIOR],
			{"strength": 3}
		),
		"guardian_mail": create_equippable_item_definition(
			"Cotte gardienne",
			"armor",
			"Une cotte lourde portée par un ancien protecteur du donjon.",
			18,
			SLOT_ARMOR,
			[JOB_WARRIOR],
			{"endurance": 3}
		),
		"stone_amulet": create_equippable_item_definition(
			"Amulette de pierre",
			"accessory",
			"Une amulette gravée de signes presque effacés.",
			14,
			SLOT_JEWELRY,
			[JOB_WARRIOR, JOB_THIEF, JOB_MAGE, JOB_CLERIC],
			{"endurance": 1, "magic_power": 1}
		),
		"ancient_shield": create_equippable_item_definition(
			"Bouclier ancien",
			"shield",
			"Un bouclier massif, usé par le temps mais encore imposant.",
			17,
			SLOT_SHIELD,
			[JOB_WARRIOR],
			{"endurance": 2}
		),
		"guardian_relic": create_item_definition(
			"Relique de gardien",
			"misc",
			"Un fragment de relique lié aux gardiens oubliés du donjon.",
			30
		)
	}


static func create_item_definition(
	display_name: String,
	item_type: String,
	description: String,
	sell_value: int,
	max_stack: int = DEFAULT_MAX_STACK
) -> Dictionary:
	return {
		"display_name": display_name,
		"item_type": item_type,
		"description": description,
		"sell_value": sell_value,
		"max_stack": max_stack,
		"equipment_slot": SLOT_NONE,
		"allowed_classes": [],
		"stat_bonuses": {}
	}


static func create_equippable_item_definition(
	display_name: String,
	item_type: String,
	description: String,
	sell_value: int,
	equipment_slot: String,
	allowed_classes: Array[String],
	stat_bonuses: Dictionary,
	max_stack: int = DEFAULT_MAX_STACK
) -> Dictionary:
	return {
		"display_name": display_name,
		"item_type": item_type,
		"description": description,
		"sell_value": sell_value,
		"max_stack": max_stack,
		"equipment_slot": equipment_slot,
		"allowed_classes": allowed_classes.duplicate(),
		"stat_bonuses": stat_bonuses.duplicate(true)
	}


# ------------------------------------------------------------
# FALLBACK
# Crée un objet générique pour éviter de bloquer si un loot inconnu apparaît.
# ------------------------------------------------------------

static func create_unknown_item(item_id: String):
	var fallback_id: String = normalize_item_id(item_id)

	if fallback_id == "":
		fallback_id = "unknown_item"

	return ItemDataScript.new(
		fallback_id,
		fallback_id,
		"misc",
		"Objet non répertorié dans la base de données.",
		0,
		DEFAULT_MAX_STACK,
		SLOT_NONE,
		[],
		{}
	)


# ------------------------------------------------------------
# HELPERS
# Normalise et protège les données venant des dictionnaires.
# ------------------------------------------------------------

static func normalize_item_id(item_id: String) -> String:
	return item_id.strip_edges().to_lower()


static func create_string_array(raw_value) -> Array[String]:
	var values: Array[String] = []

	if not (raw_value is Array):
		return values

	for value in raw_value:
		values.append(str(value))

	return values


static func create_bonus_dictionary(raw_value) -> Dictionary:
	var bonuses: Dictionary = {}

	if not (raw_value is Dictionary):
		return bonuses

	for key in raw_value.keys():
		bonuses[str(key)] = int(raw_value[key])

	return bonuses
