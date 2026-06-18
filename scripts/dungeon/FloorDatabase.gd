extends RefCounted

class_name FloorDatabase

const FloorDataScript = preload("res://scripts/dungeon/FloorData.gd")


# ------------------------------------------------------------
# ACCÈS AUX ÉTAGES
# ------------------------------------------------------------

# Retourne les données de l'étage demandé.
# Pour l'instant, seul l'étage 1 existe : tout identifiant inconnu renvoie donc l'étage 1.
static func get_floor_data(floor_id: int):
	if floor_id == 1:
		return get_floor_1()

	return get_floor_1()


# ------------------------------------------------------------
# ÉTAGE 1
# ------------------------------------------------------------

# Définit le premier étage du donjon :
# - layout ASCII du niveau ;
# - position de départ du joueur ;
# - position de l'escalier descendant ;
# - emplacements de découvertes de sorts ;
# - thème visuel utilisé par le renderer.
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
		"dark_earth"
	)
