extends RefCounted
class_name FloorDatabase

const FloorDataScript = preload("res://scripts/dungeon/FloorData.gd")

# ------------------------------------------------------------
# ACCÈS AUX ÉTAGES
# ------------------------------------------------------------

# Retourne les données de l'étage demandé.
# Tout identifiant inconnu renvoie l'étage 1 par sécurité.
static func get_floor_data(floor_id: int):
	if floor_id == 1:
		return get_floor_1()
	if floor_id == 2:
		return get_floor_2()

	return get_floor_1()


# Indique si un étage existe réellement.
# Utilisé pour éviter d'activer un escalier descendant vers un étage non créé.
static func has_floor(floor_id: int) -> bool:
	return floor_id == 1 or floor_id == 2


# ------------------------------------------------------------
# ÉTAGE 1
# ------------------------------------------------------------

# Définit le premier étage du donjon.
static func get_floor_1():
	var layout: Array[String] = [
		"###############################",
		"#..M#C#.....................DO#",
		"###.#.#.##.##.#################",
		"#.#.#.#.....#.......#.........#",
		"#.#.#.###.#########.#.######..#",
		"#.#.#.....#.........#...#.....#",
		"#.#.#.#D###.###.#######.#.#####",
		"#.#...#...#...#.#.....#.#.....#",
		"#.###.###.###.###.#.###.#####.#",
		"#.....#.....#...#.#........C#.#",
		"#.#.#.#####.###.#.###########.#",
		"#.#.#.....#.#...#...#.....#...#",
		"#.#######.#.#...#.#.#.###.#.###",
		"#.........#.........#...#.D.#.#",
		"#.#################.###.###.#.#",
		"#.#...........DB#...#...#...#.#",
		"#.#.#####.###.###.#.#.###.#.#.#",
		"#.#.#...#.........#.#.#>#.#.#.#",
		"#.#.#.###.##.####.#.#.#D#M..#.#",
		"#...#..........C#...D.#...#...#",
		"###############################"
	]

	var discoveries: Dictionary = {}
	discoveries[Vector2i(29, 13)] = "spell_ice_shard"

	var chests: Dictionary = {}
	chests[Vector2i(5, 1)] = {
		"gold": 25,
		"description": "Un petit coffre caché dans les premières galeries."
	}
	chests[Vector2i(15, 19)] = {
		"item_id": "tarnished_ring",
		"description": "Un coffre ancien placé dans une impasse profonde."
	}
	chests[Vector2i(27, 9)] = {
		"item_id": "small_shield",
		"description": "Un coffre utile pour préparer la descente."
	}

	var messages: Dictionary = {}
	messages[Vector2i(3, 1)] = "Une inscription gravée indique : les vieux coffres gardent parfois plus que de l'or."
	messages[Vector2i(25, 18)] = "L'air venu d'en bas est plus froid. Préparez-vous avant de descendre."

	var locked_doors: Dictionary = {}

	return FloorDataScript.new(
		1,
		"Galeries de terre sombre",
		layout,
		Vector2i(1, 1),
		Vector2i(23, 17),
		discoveries,
		"dark_earth",
		Vector2i(-1, -1),
		chests,
		messages,
		locked_doors
	)


# ------------------------------------------------------------
# ÉTAGE 2
# ------------------------------------------------------------

# Définit le deuxième étage du donjon.
# Le point de départ est l'escalier montant, placé aux mêmes coordonnées
# que l'escalier descendant de l'étage 1.
static func get_floor_2():
	var layout: Array[String] = [
		"###############################",
		"#ML.X>#.........#.....#.......#",
		"#.#####.#######.#.###.#.#####.#",
		"#...#...#.......#...#.#.#.....#",
		"###.#.#.#.#######.#.#.#.#.###.#",
		"#...#.#.#.#.DB#.....#.#.#...#.#",
		"#.###.###.#.#######.#.#.###.#.#",
		"#...#.......#.......#.#.#C..#.#",
		"#.#.#########.#######.#.###.#.#",
		"#.#...#...#...#......#....#...#",
		"#.#.#.#.#.###.#.###.###.#.###.#",
		"#..M#...#...#.#...........#.#.#",
		"###.#####.#.###.###.#######.#.#",
		"#C#...#...#...#...#.#.......#.#",
		"#.#####.#.###.###.###.#.#.#.#.#",
		"#.#.DO#...#....C#.....#.#.#...#",
		"#.#.#####.#.###########.#.###.#",
		"#.#...#...#..........M#<#.#...#",
		"#.###.#.#.#####.#.#######.#.#.#",
		"#.......#.......#.............#",
		"###############################"
	]

	var discoveries: Dictionary = {}

	var chests: Dictionary = {}
	chests[Vector2i(1, 13)] = {
		"item_id": "boss_door_key_floor_2",
		"description": "Coffre important lié à la porte du gardien."
	}
	chests[Vector2i(15, 15)] = {
		"item_id": "reinforced_leather",
		"description": "Un coffre d'équipement au cœur des cryptes."
	}
	chests[Vector2i(25, 7)] = {
		"gold": 50,
		"description": "Une cache d'or dans une impasse secondaire."
	}

	var messages: Dictionary = {}
	messages[Vector2i(21, 17)] = "Des traces anciennes mènent vers l'ouest. Quelque chose semble garder les profondeurs."
	messages[Vector2i(3, 11)] = "Une voix lointaine murmure : la voie du gardien ne s'ouvre qu'à ceux qui fouillent les impasses."
	messages[Vector2i(1, 1)] = "Une présence puissante se tient derrière cette porte. Ce passage n'est pas encore prêt."

	var locked_doors: Dictionary = {}
	locked_doors[Vector2i(2, 1)] = {
		"required_item_id": "boss_door_key_floor_2",
		"locked_message": "La porte du gardien est verrouillée.\nIl manque une clé ancienne.",
		"unlocked_message": "La clé du gardien tourne dans la serrure.\nLa porte s'ouvre, et la clé disparaît."
	}

	return FloorDataScript.new(
		2,
		"Cryptes de pierre froide",
		layout,
		Vector2i(23, 17),
		Vector2i(5, 1),
		discoveries,
		"gray_stone",
		Vector2i(23, 17),
		chests,
		messages,
		locked_doors
	)
