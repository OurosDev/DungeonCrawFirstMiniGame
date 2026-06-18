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
		"#...#.#.....................DO#",
		"###.#.#.##.##.#################",
		"#.#.#.#.....#.......#.........#",
		"#.#.#.###.#########.#.######..#",
		"#.#.#.....#.........#...#.....#",
		"#.#.#.#D###.###.#######.#.#####",
		"#.#...#...#...#.#.....#.#.....#",
		"#.###.###.###.###.#.###.#####.#",
		"#.....#.....#...#.#.........#.#",
		"#.#.#.#####.###.#.###########.#",
		"#.#.#.....#.#...#...#.....#...#",
		"#.#######.#.#...#.#.#.###.#.###",
		"#.........#.........#...#D..#.#",
		"#.#################.###.###.#.#",
		"#.#...........DB#...#...#...#.#",
		"#.#.#####.###.###.#.#.###.#.#.#",
		"#.#.#...#.........#.#.#>#.#.#.#",
		"#.#.#.###.##.####.#.#.#.#...#.#",
		"#...#...........#...D.#...#...#",
		"###############################"
	]

	var discoveries: Dictionary = {}
	discoveries[Vector2i(29, 13)] = "spell_ice_shard"

	return FloorDataScript.new(
		1,
		"Galeries de terre sombre",
		layout,
		Vector2i(1, 1),
		Vector2i(23, 17),
		discoveries,
		"dark_earth",
		Vector2i(-1, -1)
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
		"#.D.X>#.........#.....#.......#",
		"#.#####.#######.#.###.#.#####.#",
		"#...#...#.......#...#.#.#.....#",
		"###.#.#.#.#######.#.#.#.#.###.#",
		"#...#.#.#.#.DB#.....#.#.#...#.#",
		"#.###.###.#.#.#####.#.#.###.#.#",
		"#...#.......#.......#.#.#...#.#",
		"#.#.#########.#######.#.###.#.#",
		"#.#...#...#...#......#....#...#",
		"#.#.#.#.#.###.#.###.###.#.###.#",
		"#...#...#...#.#...........#.#.#",
		"###.#####.#.###.###.#######.#.#",
		"#.#...#...#...#...#.#.......#.#",
		"#.###.#.#.###.###.###.#.#.#.#.#",
		"#.#.DO#...#.....#.....#.#.#...#",
		"#.#.#####.#.###########.#.###.#",
		"#.#...#...#...........#<#.#...#",
		"#.###.#.#.#####.#.#######.#.#.#",
		"#.......#.......#.............#",
		"###############################"
	]

	var discoveries: Dictionary = {}

	return FloorDataScript.new(
		2,
		"Cryptes de pierre froide",
		layout,
		Vector2i(23, 17),
		Vector2i(5, 1),
		discoveries,
		"gray_stone",
		Vector2i(23, 17)
	)
