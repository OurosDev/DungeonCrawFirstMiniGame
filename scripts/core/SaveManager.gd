extends Node

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------


# ------------------------------------------------------------
# DÉPENDANCES
# Charge les données nécessaires à la sauvegarde des héros.
# ------------------------------------------------------------

const CharacterDataScript = preload("res://scripts/characters/CharacterData.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const StatBlockScript = preload("res://scripts/core/StatBlock.gd")


# ------------------------------------------------------------
# CONSTANTES ET ÉTAT
# Définit le chemin de sauvegarde et le dernier message d'erreur.
# ------------------------------------------------------------

const SAVE_FILE_PATH: String = "user://savegame.json"

var last_error: String = ""


# ------------------------------------------------------------
# ACCÈS FICHIER
# Vérifie l'existence d'une sauvegarde.
# ------------------------------------------------------------

func has_save_file() -> bool:
	return FileAccess.file_exists(SAVE_FILE_PATH)


# ------------------------------------------------------------
# SAUVEGARDE
# Sérialise l'état utile du donjon et de la session.
# ------------------------------------------------------------

func save_game_from_dungeon(dungeon) -> bool:
	last_error = ""

	if dungeon == null:
		last_error = "Impossible de sauvegarder : donjon introuvable."
		return false

	if dungeon.combat_manager != null:
		if dungeon.combat_manager.in_combat:
			last_error = "Impossible de sauvegarder pendant un combat."
			return false

	if dungeon.has_method("store_current_floor_state"):
		dungeon.store_current_floor_state()

	var save_data: Dictionary = {}
	save_data["version"] = 7
	save_data["current_floor_id"] = dungeon.current_floor_id
	save_data["party"] = serialize_party(dungeon.party)
	save_data["layout"] = dungeon.layout.duplicate()
	save_data["discovered_map_cells"] = serialize_discovered_map_cells(dungeon.discovered_map_cells)
	save_data["floor_states"] = GameSession.get_floor_states_save_data()
	save_data["discovered_ability_ids"] = GameSession.get_discovered_ability_ids()
	save_data["active_ability_ids_by_party_slot"] = GameSession.get_active_ability_ids_save_data()
	save_data["inventory"] = GameSession.get_inventory_save_data()
	save_data["gold"] = GameSession.get_gold()

	if dungeon.player != null:
		save_data["player_cell"] = vector2i_to_dictionary(dungeon.player.grid_cell)

	var json_text: String = JSON.stringify(save_data, "\t")
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)

	if file == null:
		last_error = "Impossible d'écrire le fichier de sauvegarde."
		return false

	file.store_string(json_text)
	file.close()

	return true


# ------------------------------------------------------------
# CHARGEMENT
# Lit une sauvegarde et prépare GameSession pour la scène Dungeon.
# ------------------------------------------------------------

func load_game_to_session() -> bool:
	last_error = ""

	if not has_save_file():
		last_error = "Aucune sauvegarde disponible."
		return false

	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.READ)

	if file == null:
		last_error = "Impossible de lire la sauvegarde."
		return false

	var json_text: String = file.get_as_text()
	file.close()

	var parsed = JSON.parse_string(json_text)

	if not parsed is Dictionary:
		last_error = "Sauvegarde invalide."
		return false

	var save_data: Dictionary = parsed
	var loaded_party: Array = []

	if save_data.has("party"):
		loaded_party = deserialize_party(save_data["party"])

	GameSession.prepare_loaded_game(save_data)
	GameSession.set_party(loaded_party)

	return true


# ------------------------------------------------------------
# SÉRIALISATION DU GROUPE
# Convertit les héros en données JSON simples.
# ------------------------------------------------------------

func serialize_party(party: Array) -> Array:
	var serialized_party: Array = []

	for hero in party:
		if hero == null:
			continue

		serialized_party.append(serialize_hero(hero))

	return serialized_party


func serialize_hero(hero) -> Dictionary:
	var data: Dictionary = {}

	data["character_name"] = get_string_property(hero, "character_name", "Héros")
	data["job"] = ClassDatabaseScript.normalize_class_name(
		get_string_property(hero, "job", "")
	)
	data["level"] = get_int_property(hero, "level", 1)
	data["exp"] = get_int_property(hero, "exp", 0)
	data["exp_to_next"] = get_int_property(hero, "exp_to_next", 100)
	data["hp"] = get_int_property(hero, "hp", 1)
	data["max_hp"] = get_int_property(hero, "max_hp", 1)
	data["mp"] = get_int_property(hero, "mp", 0)
	data["max_mp"] = get_int_property(hero, "max_mp", 0)
	data["equipment"] = serialize_hero_equipment(hero)

	var base_stats = get_property_value(hero, "base_stats", null)

	if base_stats == null:
		base_stats = get_property_value(hero, "stats", null)

	if base_stats != null:
		data["stats"] = {
			"strength": get_int_property(base_stats, "strength", 1),
			"agility": get_int_property(base_stats, "agility", 1),
			"endurance": get_int_property(base_stats, "endurance", 1),
			"magic_power": get_int_property(base_stats, "magic_power", 1)
		}

	return data


func serialize_hero_equipment(hero) -> Dictionary:
	if hero == null:
		return {}

	if hero.has_method("get_equipment_save_data"):
		return hero.get_equipment_save_data()

	var equipment = get_property_value(hero, "equipped_items", {})

	if equipment is Dictionary:
		return equipment.duplicate(true)

	return {}


# ------------------------------------------------------------
# DÉSÉRIALISATION DU GROUPE
# Reconstruit les héros depuis les données JSON.
# ------------------------------------------------------------

func deserialize_party(serialized_party) -> Array:
	var loaded_party: Array = []

	if not serialized_party is Array:
		return loaded_party

	for hero_data in serialized_party:
		if not hero_data is Dictionary:
			continue

		var hero = deserialize_hero(hero_data)
		loaded_party.append(hero)

	return loaded_party


func deserialize_hero(data: Dictionary):
	var hero = CharacterDataScript.new()

	hero.character_name = str(data.get("character_name", "Héros"))
	hero.job = ClassDatabaseScript.normalize_class_name(
		str(data.get("job", ClassDatabaseScript.JOB_WARRIOR))
	)
	hero.level = int(data.get("level", 1))

	if object_has_property(hero, "exp"):
		hero.exp = int(data.get("exp", 0))

	if object_has_property(hero, "exp_to_next"):
		hero.exp_to_next = int(data.get("exp_to_next", 100))

	var stats_data = data.get("stats", {})

	if stats_data is Dictionary:
		var loaded_base_stats = StatBlockScript.new(
			int(stats_data.get("strength", 1)),
			int(stats_data.get("agility", 1)),
			int(stats_data.get("endurance", 1)),
			int(stats_data.get("magic_power", 1))
		)

		if object_has_property(hero, "base_stats"):
			hero.base_stats = loaded_base_stats

		hero.stats = loaded_base_stats.create_copy()

	if hero.has_method("load_equipment_save_data"):
		hero.load_equipment_save_data(data.get("equipment", {}))

	if hero.has_method("recalculate_derived_stats"):
		hero.recalculate_derived_stats()

	if object_has_property(hero, "max_hp"):
		hero.max_hp = int(data.get("max_hp", hero.max_hp))

	if object_has_property(hero, "hp"):
		hero.hp = int(data.get("hp", hero.max_hp))

	if object_has_property(hero, "max_mp"):
		hero.max_mp = int(data.get("max_mp", hero.max_mp))

	if object_has_property(hero, "mp"):
		hero.mp = int(data.get("mp", hero.max_mp))

	if hero.has_method("recalculate_derived_stats"):
		hero.recalculate_derived_stats(false)

	return hero


# ------------------------------------------------------------
# SÉRIALISATION DU DONJON
# Convertit les cellules découvertes et positions en données JSON simples.
# ------------------------------------------------------------

func serialize_discovered_map_cells(discovered_map_cells: Dictionary) -> Array:
	var serialized_cells: Array = []

	for cell in discovered_map_cells.keys():
		if cell is Vector2i:
			serialized_cells.append(vector2i_to_dictionary(cell))

	return serialized_cells


func vector2i_to_dictionary(cell: Vector2i) -> Dictionary:
	return {
		"x": cell.x,
		"y": cell.y
	}


func dictionary_to_vector2i(data: Dictionary) -> Vector2i:
	return Vector2i(
		int(data.get("x", 0)),
		int(data.get("y", 0))
	)


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les propriétés sans dépendre trop fortement des classes concrètes.
# ------------------------------------------------------------

func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func get_property_value(target, property_name: String, default_value = null):
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return target.get(property_name)


func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
