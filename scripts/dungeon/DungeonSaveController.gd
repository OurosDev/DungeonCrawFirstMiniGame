extends RefCounted
class_name DungeonSaveController


func request_save(dungeon) -> Dictionary:
	var result: Dictionary = {}
	result["success"] = false
	result["blocked"] = false
	result["message"] = ""

	if dungeon == null:
		result["message"] = "Impossible de sauvegarder : donjon introuvable."
		return result

	if dungeon.combat_manager != null:
		if dungeon.combat_manager.in_combat:
			result["blocked"] = true
			result["message"] = "Impossible de sauvegarder pendant un combat."
			return result

	if SaveManager.save_game_from_dungeon(dungeon):
		AudioManager.play_sfx("save")
		result["success"] = true
		result["message"] = "Partie sauvegardée."
		return result

	var error_message: String = SaveManager.last_error

	if error_message == "":
		error_message = "La sauvegarde a échoué."

	result["message"] = error_message
	return result


func apply_loaded_game_data(dungeon) -> void:
	if dungeon == null:
		return

	if not GameSession.is_loading_save:
		return

	var save_data: Dictionary = GameSession.pending_save_data

	apply_saved_layout(dungeon, save_data)
	apply_saved_player_cell(dungeon, save_data)
	restore_discovered_map_cells(dungeon, save_data.get("discovered_map_cells", []))

	dungeon.build_current_floor()

	if dungeon.game_ui != null:
		dungeon.game_ui.set_dungeon_theme(dungeon.current_floor_theme)

	GameSession.clear_loaded_game_data()


func apply_saved_layout(dungeon, save_data: Dictionary) -> void:
	if not save_data.has("layout"):
		return

	dungeon.layout.clear()

	var saved_layout = save_data["layout"]

	if not (saved_layout is Array):
		return

	for row in saved_layout:
		dungeon.layout.append(str(row))


func apply_saved_player_cell(dungeon, save_data: Dictionary) -> void:
	if not save_data.has("player_cell"):
		return

	var player_cell_data = save_data["player_cell"]

	if not (player_cell_data is Dictionary):
		return

	if dungeon.player == null:
		return

	dungeon.player.move_to_cell(dictionary_to_vector2i(player_cell_data))


func restore_discovered_map_cells(dungeon, serialized_cells) -> void:
	dungeon.discovered_map_cells.clear()

	if not (serialized_cells is Array):
		return

	for cell_data in serialized_cells:
		if not (cell_data is Dictionary):
			continue

		var cell: Vector2i = dictionary_to_vector2i(cell_data)
		dungeon.discovered_map_cells[cell] = true


func dictionary_to_vector2i(data: Dictionary) -> Vector2i:
	return Vector2i(
		int(data.get("x", 0)),
		int(data.get("y", 0))
	)
