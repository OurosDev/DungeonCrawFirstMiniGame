extends RefCounted
class_name ItemDatabase

# ------------------------------------------------------------
# DÉPENDANCES
# Fournit la structure de données utilisée par les objets.
# ------------------------------------------------------------

const ItemDataScript = preload("res://scripts/items/ItemData.gd")


# ------------------------------------------------------------
# CONSTANTES
# Définit les limites communes des objets de l'inventaire v0.3.
# ------------------------------------------------------------

const DEFAULT_MAX_STACK: int = 9


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
		int(data.get("max_stack", DEFAULT_MAX_STACK))
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
		"rusty_sword": create_item_definition(
			"Épée rouillée",
			"weapon",
			"Une vieille lame piquée par la rouille. Peu fiable, mais revendable.",
			4
		),
		"worn_tunic": create_item_definition(
			"Tunique usée",
			"armor",
			"Une tunique élimée qui a déjà beaucoup servi.",
			2
		),
		"cracked_shield": create_item_definition(
			"Bouclier fendu",
			"shield",
			"Un petit bouclier fissuré, encore bon pour quelques pièces.",
			3
		),
		"torn_cloak": create_item_definition(
			"Cape déchirée",
			"armor",
			"Une cape sombre et abîmée par les griffes et l'humidité.",
			2
		),
		"fragile_dagger": create_item_definition(
			"Dague fragile",
			"weapon",
			"Une dague légère dont la pointe menace de céder.",
			3
		),
		"tarnished_ring": create_item_definition(
			"Anneau terni",
			"accessory",
			"Un anneau sans éclat, couvert d'une fine couche de crasse.",
			5
		),
		"goblin_dagger": create_item_definition(
			"Dague gobeline",
			"weapon",
			"Une lame courte, sale et mal équilibrée, typique des gobelins.",
			6
		),
		"short_bow": create_item_definition(
			"Arc court",
			"weapon",
			"Un arc simple, usé mais encore souple.",
			7
		),
		"leather_vest": create_item_definition(
			"Gilet de cuir",
			"armor",
			"Un gilet de cuir léger, marqué par les coups.",
			6
		),
		"small_shield": create_item_definition(
			"Petit bouclier",
			"shield",
			"Un bouclier rond et basique, facile à transporter.",
			5
		),
		"heavy_club": create_item_definition(
			"Masse lourde",
			"weapon",
			"Une arme primitive, lourde, mais dangereuse entre de bonnes mains.",
			10
		),
		"reinforced_leather": create_item_definition(
			"Cuir renforcé",
			"armor",
			"Une protection de cuir épais renforcée par des plaques grossières.",
			9
		),
		"chipped_axe": create_item_definition(
			"Hache ébréchée",
			"weapon",
			"Une hache brutale dont le tranchant a souffert.",
			8
		),
		"thick_boots": create_item_definition(
			"Bottes épaisses",
			"armor",
			"Des bottes lourdes qui protègent bien les pieds.",
			6
		),
		"trollhide_vest": create_item_definition(
			"Gilet de peau de troll",
			"armor",
			"Un gilet répugnant, solide et étonnamment résistant.",
			18
		),
		"ancient_blade": create_item_definition(
			"Lame ancienne",
			"weapon",
			"Une lame ancienne dont le métal garde une lueur froide.",
			16
		),
		"guardian_mail": create_item_definition(
			"Cotte gardienne",
			"armor",
			"Une cotte lourde portée par un ancien protecteur du donjon.",
			18
		),
		"stone_amulet": create_item_definition(
			"Amulette de pierre",
			"accessory",
			"Une amulette gravée de signes presque effacés.",
			14
		),
		"ancient_shield": create_item_definition(
			"Bouclier ancien",
			"shield",
			"Un bouclier massif, usé par le temps mais encore imposant.",
			17
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
		"max_stack": max_stack
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
		DEFAULT_MAX_STACK
	)


static func normalize_item_id(item_id: String) -> String:
	return item_id.strip_edges().to_lower()
