extends RefCounted

# ------------------------------------------------------------
# DUNGEON MAP HELPER
# ------------------------------------------------------------
# Regroupe les opérations pures de lecture/modification du layout.
# Le contrôleur Dungeon.gd conserve ses fonctions publiques, mais délègue ici
# les manipulations de chaîne pour éviter d'alourdir le contrôleur principal.

static func is_inside_map(layout: Array[String], cell: Vector2i) -> bool:
	if cell.y < 0 or cell.y >= layout.size():
		return false
	if cell.x < 0 or cell.x >= layout[cell.y].length():
		return false
	return true


static func get_layout_tile(layout: Array[String], cell: Vector2i, wall_tile: String = "#") -> String:
	if not is_inside_map(layout, cell):
		return wall_tile
	return layout[cell.y].substr(cell.x, 1)


static func set_layout_tile(layout: Array[String], cell: Vector2i, new_tile: String) -> Array[String]:
	if not is_inside_map(layout, cell):
		return layout

	var updated_layout: Array[String] = layout.duplicate()
	var row: String = updated_layout[cell.y]
	var before: String = row.substr(0, cell.x)
	var after: String = row.substr(cell.x + 1)
	updated_layout[cell.y] = before + new_tile + after
	return updated_layout


static func is_walkable(layout: Array[String], cell: Vector2i, wall_tile: String = "#") -> bool:
	if not is_inside_map(layout, cell):
		return false
	return get_layout_tile(layout, cell, wall_tile) != wall_tile


static func is_tile(layout: Array[String], cell: Vector2i, tile_id: String) -> bool:
	if not is_inside_map(layout, cell):
		return false
	return get_layout_tile(layout, cell) == tile_id
