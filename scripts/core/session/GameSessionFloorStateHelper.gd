extends RefCounted

# ------------------------------------------------------------
# HELPERS D'ÉTAT D'ÉTAGE
# Centralise les copies défensives et la compatibilité des anciennes sauvegardes.
# ------------------------------------------------------------

# Enregistre une copie sérialisable de l'état d'un étage.
static func set_floor_state(target_floor_states: Dictionary, floor_id: int, floor_state: Dictionary) -> void:
	var normalized_floor_id: int = max(1, floor_id)
	target_floor_states[normalized_floor_id] = floor_state.duplicate(true)


# Retourne une copie de l'état mémorisé d'un étage.
static func get_floor_state(target_floor_states: Dictionary, floor_id: int) -> Dictionary:
	var normalized_floor_id: int = max(1, floor_id)
	if not target_floor_states.has(normalized_floor_id):
		return {}
	var floor_state = target_floor_states[normalized_floor_id]
	if floor_state is Dictionary:
		return floor_state.duplicate(true)
	return {}


# Vérifie si un étage possède déjà un état mémorisé.
static func has_floor_state(target_floor_states: Dictionary, floor_id: int) -> bool:
	var normalized_floor_id: int = max(1, floor_id)
	return target_floor_states.has(normalized_floor_id)


# Prépare les états d'étages depuis une sauvegarde récente ou ancienne.
static func load_floor_states_from_save_data(
	target_floor_states: Dictionary,
	save_data: Dictionary,
	current_floor_id: int
) -> void:
	target_floor_states.clear()
	var serialized_floor_states = save_data.get("floor_states", {})
	if serialized_floor_states is Dictionary:
		for floor_key in serialized_floor_states.keys():
			var floor_id: int = int(str(floor_key))
			var floor_state = serialized_floor_states[floor_key]
			if floor_id <= 0:
				continue
			if floor_state is Dictionary:
				set_floor_state(
					target_floor_states,
					floor_id,
					normalize_floor_state_for_session(floor_state)
				)

	# Compatibilité avec les sauvegardes qui ne contiennent que l'étage courant.
	if target_floor_states.is_empty():
		var legacy_floor_state: Dictionary = {}
		if save_data.has("layout"):
			legacy_floor_state["layout"] = duplicate_string_array(save_data.get("layout", []))
		if save_data.has("discovered_map_cells"):
			legacy_floor_state["discovered_map_cells"] = duplicate_serialized_cell_array(
				save_data.get("discovered_map_cells", [])
			)
		if not legacy_floor_state.is_empty():
			set_floor_state(target_floor_states, current_floor_id, legacy_floor_state)


# Retourne une version JSON-safe de tous les états d'étages.
static func get_floor_states_save_data(target_floor_states: Dictionary) -> Dictionary:
	var save_data: Dictionary = {}
	for floor_id in target_floor_states.keys():
		var floor_state = target_floor_states[floor_id]
		if not (floor_state is Dictionary):
			continue
		save_data[str(int(floor_id))] = normalize_floor_state_for_session(floor_state)
	return save_data


# Normalise un état d'étage pour éviter de conserver des références mutables ou non JSON-safe.
static func normalize_floor_state_for_session(floor_state: Dictionary) -> Dictionary:
	var normalized_state: Dictionary = {}
	if floor_state.has("layout"):
		normalized_state["layout"] = duplicate_string_array(floor_state.get("layout", []))
	if floor_state.has("discovered_map_cells"):
		normalized_state["discovered_map_cells"] = duplicate_serialized_cell_array(
			floor_state.get("discovered_map_cells", [])
		)
	return normalized_state


# Duplique un tableau de lignes de layout en forçant des chaînes simples.
static func duplicate_string_array(source_array) -> Array:
	var duplicated: Array = []
	if not (source_array is Array):
		return duplicated
	for value in source_array:
		duplicated.append(str(value))
	return duplicated


# Duplique les cellules découvertes dans un format JSON-safe.
static func duplicate_serialized_cell_array(source_array) -> Array:
	var duplicated: Array = []
	if not (source_array is Array):
		return duplicated
	for cell_data in source_array:
		if not (cell_data is Dictionary):
			continue
		duplicated.append({
			"x": int(cell_data.get("x", 0)),
			"y": int(cell_data.get("y", 0))
		})
	return duplicated
