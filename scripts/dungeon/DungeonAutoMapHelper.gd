extends RefCounted

# ------------------------------------------------------------
# DUNGEON AUTOMAP HELPER
# ------------------------------------------------------------
# Regroupe la logique de découverte de la carte automatique.
# Le dictionnaire découvert est volontairement muté par référence.

const DungeonMapHelperScript = preload("res://scripts/dungeon/DungeonMapHelper.gd")

static func discover_around_cell(
	discovered_map_cells: Dictionary,
	layout: Array[String],
	origin: Vector2i,
	closed_door_tile: String,
	locked_door_tile: String
) -> void:
	discover_cell(discovered_map_cells, layout, origin)

	var directions: Array[Vector2i] = [
		Vector2i(0, -1),
		Vector2i(1, 0),
		Vector2i(0, 1),
		Vector2i(-1, 0)
	]

	for direction in directions:
		discover_visible_line(
			discovered_map_cells,
			layout,
			origin,
			direction,
			2,
			closed_door_tile,
			locked_door_tile
		)


static func discover_visible_line(
	discovered_map_cells: Dictionary,
	layout: Array[String],
	origin: Vector2i,
	direction: Vector2i,
	max_distance: int,
	closed_door_tile: String,
	locked_door_tile: String
) -> void:
	var current_cell: Vector2i = origin
	for step in range(max_distance):
		current_cell += direction
		if not DungeonMapHelperScript.is_inside_map(layout, current_cell):
			return

		discover_cell(discovered_map_cells, layout, current_cell)

		var tile: String = DungeonMapHelperScript.get_layout_tile(layout, current_cell)
		if tile == "#":
			return
		if tile == closed_door_tile or tile == locked_door_tile:
			return


static func discover_cell(discovered_map_cells: Dictionary, layout: Array[String], cell: Vector2i) -> void:
	if not DungeonMapHelperScript.is_inside_map(layout, cell):
		return
	discovered_map_cells[cell] = true
