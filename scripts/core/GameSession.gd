extends Node

var party: Array = []

var current_floor_id: int = 1
var is_loading_save: bool = false
var pending_save_data: Dictionary = {}


func prepare_new_game() -> void:
	party.clear()
	current_floor_id = 1
	is_loading_save = false
	pending_save_data.clear()


func set_party(p_party: Array) -> void:
	party.clear()

	for hero in p_party:
		party.append(hero)


func get_party() -> Array:
	return party


func has_party() -> bool:
	return party.size() > 0


func clear_party() -> void:
	party.clear()


func prepare_loaded_game(save_data: Dictionary) -> void:
	party.clear()
	current_floor_id = 1
	is_loading_save = true
	pending_save_data = save_data.duplicate()

	if pending_save_data.has("current_floor_id"):
		current_floor_id = int(pending_save_data["current_floor_id"])


func clear_loaded_game_data() -> void:
	is_loading_save = false
	pending_save_data.clear()
