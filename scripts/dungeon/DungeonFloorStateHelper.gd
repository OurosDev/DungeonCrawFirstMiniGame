extends RefCounted

# ------------------------------------------------------------
# DUNGEON FLOOR STATE HELPER
# ------------------------------------------------------------
# Centralise la sérialisation/restauration de l'état d'un étage.
# Cela garde Dungeon.gd concentré sur l'orchestration des transitions.

static func create_floor_state(layout: Array[String], discovered_map_cells: Dictionary) -> Dictionary:
	return {
		"layout": layout.duplicate(),
		"discovered_map_cells": serialize_discovered_map_cells(discovered_map_cells)
	}


static func apply_floor_state_to_layout(current_layout: Array[String], floor_state: Dictionary) -> Array[String]:
	var restored_layout: Array[String] = current_layout.duplicate()
	if not floor_state.has("layout"):
		return restored_layout

	var saved_layout = floor_state["layout"]
	if not saved_layout is Array:
		return restored_layout

	restored_layout.clear()
	for row in saved_layout:
		restored_layout.append(str(row))
	return restored_layout


static func restore_discovered_map_cells_from_state(floor_state: Dictionary) -> Dictionary:
	if not floor_state.has("discovered_map_cells"):
		return {}
	return restore_discovered_map_cells(floor_state["discovered_map_cells"])


static func serialize_discovered_map_cells(cells: Dictionary) -> Array:
	var serialized_cells: Array = []
	for cell in cells.keys():
		if cell is Vector2i:
			serialized_cells.append({
				"x": cell.x,
				"y": cell.y
			})
	return serialized_cells


static func restore_discovered_map_cells(serialized_cells) -> Dictionary:
	var restored_cells: Dictionary = {}
	if not serialized_cells is Array:
		return restored_cells

	for cell_data in serialized_cells:
		if not cell_data is Dictionary:
			continue

		var cell: Vector2i = Vector2i(
			int(cell_data.get("x", 0)),
			int(cell_data.get("y", 0))
		)
		restored_cells[cell] = true

	return restored_cells
