extends Node3D

# ------------------------------------------------------------
# CONSTANTES
# ------------------------------------------------------------

const CELL_SIZE: float = 2.0

const HEALING_TEMPLE_TILE: String = "O"
const SHOP_TILE: String = "B"
const BOSS_TILE: String = "X"
const STAIRS_UP_TILE: String = "<"
const CHEST_TILE: String = "C"
const MESSAGE_TILE: String = "M"
const CLOSED_DOOR_TILE: String = "D"
const OPEN_DOOR_TILE: String = "d"
const LOCKED_DOOR_TILE: String = "L"

const BOSS_KEY_ITEM_ID: String = "boss_door_key_floor_2"

const SHOP_DISCOVERY_MESSAGE: String = "Un marchand s'est installé dans une alcôve.\nAppuyez sur Échap pour accéder à la boutique dans le menu."
const INACTIVE_STAIRS_MESSAGE: String = "Un escalier descend plus profondément, mais le passage n'est pas encore accessible."
const STAIRS_UP_MESSAGE: String = "Le groupe remonte vers l'étage supérieur."
const GUARDIAN_BOSS_MONSTER_ID: String = "gardien_boss_etage_2"
const BOSS_DEFEATED_MESSAGE: String = "Le Gardien des profondeurs s'effondre.\nLe passage vers les profondeurs est libre."
const BOSS_RETREAT_MESSAGE: String = "Le groupe recule devant le Gardien des profondeurs."

const PARTY_CREATION_SCENE_PATH: String = "res://scenes/PartyCreation.tscn"
const MAIN_MENU_SCENE_PATH: String = "res://scenes/MainMenu.tscn"


# ------------------------------------------------------------
# DÉPENDANCES
# ------------------------------------------------------------

const DungeonThemeDataScript = preload("res://scripts/dungeon/DungeonThemeData.gd")
const FloorDatabaseScript = preload("res://scripts/dungeon/FloorDatabase.gd")
const MonsterDatabaseScript = preload("res://scripts/monsters/MonsterDatabase.gd")
const DungeonInputControllerScript = preload("res://scripts/dungeon/DungeonInputController.gd")
const DungeonSaveControllerScript = preload("res://scripts/dungeon/DungeonSaveController.gd")
const ItemDatabaseScript = preload("res://scripts/items/ItemDatabase.gd")


# ------------------------------------------------------------
# RÉFÉRENCES DE NŒUDS
# ------------------------------------------------------------

@onready var player: GridPlayer = $Player
@onready var game_ui: GameUI = $GameUI
@onready var combat_manager = $CombatManager
@onready var dungeon_renderer = $DungeonRenderer


# ------------------------------------------------------------
# ÉTAT DU DONJON
# ------------------------------------------------------------

var discovered_ability_ids: Array[String] = []
var ability_discovery_locations: Dictionary = {}
var chest_definitions: Dictionary = {}
var message_definitions: Dictionary = {}
var locked_door_definitions: Dictionary = {}
var discovered_map_cells: Dictionary = {}

var current_floor_theme = null
var current_floor_id: int = 1
var current_floor_data = null
var layout: Array[String] = []
var stairs_down_cell: Vector2i = Vector2i(-1, -1)
var stairs_up_cell: Vector2i = Vector2i(-1, -1)

var active_boss_combat_cell: Vector2i = Vector2i(-1, -1)
var active_boss_return_cell: Vector2i = Vector2i(-1, -1)
var active_boss_monster_id: String = ""
var active_boss_in_progress: bool = false


# ------------------------------------------------------------
# ÉTAT DU GROUPE ET DES CONTRÔLEURS
# ------------------------------------------------------------

var party: Array = []
var selected_combat_command: int = 0
var input_controller = null
var save_controller = null


# ------------------------------------------------------------
# INITIALISATION
# ------------------------------------------------------------

func _ready() -> void:
	randomize()

	input_controller = DungeonInputControllerScript.new()
	save_controller = DungeonSaveControllerScript.new()

	if not GameSession.has_party():
		get_tree().change_scene_to_file(PARTY_CREATION_SCENE_PATH)
		return

	party = GameSession.get_party()

	load_floor(GameSession.current_floor_id)

	if GameSession.is_loading_save:
		save_controller.apply_loaded_game_data(self)

	if combat_manager != null:
		combat_manager.in_combat = false
		combat_manager.party = party

	connect_combat_signals()
	connect_in_game_menu_signals()
	connect_game_ui_command_signals()

	GameSession.set_shop_available(is_shop_cell(player.grid_cell))
	AudioManager.play_dungeon_music(current_floor_id)

	refresh_ui()


# ------------------------------------------------------------
# INPUT
# ------------------------------------------------------------

func _input(event: InputEvent) -> void:
	if input_controller == null:
		input_controller = DungeonInputControllerScript.new()

	if input_controller.has_method("handle_priority_input"):
		if input_controller.handle_priority_input(self, event):
			get_viewport().set_input_as_handled()


func _unhandled_input(event: InputEvent) -> void:
	if input_controller == null:
		input_controller = DungeonInputControllerScript.new()

	input_controller.handle_input(self, event)


# ------------------------------------------------------------
# SIGNALS DE COMBAT
# ------------------------------------------------------------

func connect_combat_signals() -> void:
	if combat_manager == null:
		return

	if not combat_manager.has_signal("battle_finished"):
		return

	var callback: Callable = Callable(self, "on_combat_battle_finished")

	if not combat_manager.is_connected("battle_finished", callback):
		combat_manager.connect("battle_finished", callback)


func on_combat_battle_finished(result_status: String, enemy) -> void:
	var normalized_status: String = result_status.strip_edges().to_lower()

	if normalized_status == "defeat":
		handle_party_defeat()
		return

	if not active_boss_in_progress:
		return

	var boss_cell: Vector2i = active_boss_combat_cell
	var return_cell: Vector2i = active_boss_return_cell
	var boss_monster_id: String = active_boss_monster_id

	reset_active_boss_context()

	if boss_monster_id != GUARDIAN_BOSS_MONSTER_ID:
		return

	if normalized_status == "victory":
		complete_boss_victory(boss_cell)
		return

	restore_player_after_boss_interrupt(return_cell, normalized_status)


func reset_active_boss_context() -> void:
	active_boss_combat_cell = Vector2i(-1, -1)
	active_boss_return_cell = Vector2i(-1, -1)
	active_boss_monster_id = ""
	active_boss_in_progress = false


func handle_party_defeat() -> void:
	reset_active_boss_context()
	GameSession.prepare_new_game()
	get_tree().call_deferred("change_scene_to_file", MAIN_MENU_SCENE_PATH)


func complete_boss_victory(boss_cell: Vector2i) -> void:
	if is_inside_map(boss_cell) and get_layout_tile(boss_cell) == BOSS_TILE:
		set_layout_tile(boss_cell, ".")
		discover_cell(boss_cell)

		if dungeon_renderer != null:
			build_current_floor()

	store_current_floor_state()
	append_to_battle_log(BOSS_DEFEATED_MESSAGE)


func restore_player_after_boss_interrupt(return_cell: Vector2i, result_status: String) -> void:
	if is_inside_map(return_cell) and is_walkable(return_cell):
		player.move_to_cell(return_cell)
		discover_around_player()

	if result_status == "escape":
		append_to_battle_log(BOSS_RETREAT_MESSAGE)


func append_to_battle_log(message: String) -> void:
	if combat_manager == null:
		return

	if message == "":
		return

	if combat_manager.battle_log != "":
		combat_manager.battle_log += "\n"

	combat_manager.battle_log += message


# ------------------------------------------------------------
# MENU D'AVENTURE
# ------------------------------------------------------------

func toggle_adventure_menu() -> void:
	if combat_manager != null:
		if combat_manager.in_combat:
			return

	if game_ui == null:
		return

	GameSession.set_shop_available(is_shop_cell(player.grid_cell))
	game_ui.toggle_in_game_menu(party)


func connect_in_game_menu_signals() -> void:
	if game_ui == null:
		return

	if not game_ui.in_game_menu_save_requested.is_connected(on_in_game_menu_save_requested):
		game_ui.in_game_menu_save_requested.connect(on_in_game_menu_save_requested)

	if not game_ui.in_game_menu_quit_requested.is_connected(on_in_game_menu_quit_requested):
		game_ui.in_game_menu_quit_requested.connect(on_in_game_menu_quit_requested)


func connect_game_ui_command_signals() -> void:
	if game_ui == null:
		return

	if game_ui.has_signal("exploration_command_pressed"):
		if not game_ui.exploration_command_pressed.is_connected(on_game_ui_exploration_command_pressed):
			game_ui.exploration_command_pressed.connect(on_game_ui_exploration_command_pressed)

	if game_ui.has_signal("combat_command_pressed"):
		if not game_ui.combat_command_pressed.is_connected(on_game_ui_combat_command_pressed):
			game_ui.combat_command_pressed.connect(on_game_ui_combat_command_pressed)


func on_game_ui_exploration_command_pressed(command_id: String) -> void:
	if input_controller == null:
		input_controller = DungeonInputControllerScript.new()

	if input_controller.has_method("execute_exploration_command"):
		input_controller.execute_exploration_command(self, command_id)


func on_game_ui_combat_command_pressed(command_index: int) -> void:
	if input_controller == null:
		input_controller = DungeonInputControllerScript.new()

	if input_controller.has_method("execute_combat_command_by_index"):
		input_controller.execute_combat_command_by_index(self, command_index)


func on_in_game_menu_save_requested() -> void:
	if save_controller == null:
		save_controller = DungeonSaveControllerScript.new()

	var result: Dictionary = save_controller.request_save(self)
	var message: String = str(result.get("message", ""))

	if game_ui != null:
		game_ui.show_in_game_menu_message(message)


func on_in_game_menu_quit_requested() -> void:
	GameSession.prepare_new_game()
	get_tree().change_scene_to_file(MAIN_MENU_SCENE_PATH)


# ------------------------------------------------------------
# ÉTAGE / THÈME / RENDU
# ------------------------------------------------------------

func load_floor(
	floor_id: int,
	spawn_cell: Vector2i = Vector2i(-1, -1)
) -> void:
	current_floor_id = floor_id
	GameSession.current_floor_id = current_floor_id

	current_floor_data = FloorDatabaseScript.get_floor_data(current_floor_id)
	layout = current_floor_data.layout.duplicate()

	stairs_down_cell = current_floor_data.stairs_down_cell
	stairs_up_cell = current_floor_data.stairs_up_cell

	ability_discovery_locations.clear()
	chest_definitions.clear()
	message_definitions.clear()
	locked_door_definitions.clear()
	discovered_map_cells.clear()

	current_floor_theme = create_current_floor_theme()

	setup_ability_discoveries()
	setup_chests()
	setup_messages()
	setup_locked_doors()

	apply_floor_state_from_session(current_floor_id)

	var target_spawn_cell: Vector2i = spawn_cell

	if not is_inside_map(target_spawn_cell) or not is_walkable(target_spawn_cell):
		target_spawn_cell = current_floor_data.player_start_cell

	player.move_to_cell(target_spawn_cell)

	build_current_floor()

	if game_ui != null:
		game_ui.set_dungeon_theme(current_floor_theme)

	discover_around_player()


func create_current_floor_theme():
	var theme = DungeonThemeDataScript.new()

	if current_floor_data != null:
		if current_floor_data.theme_id == "dark_earth":
			theme.setup_dark_earth_theme()
			return theme

		if current_floor_data.theme_id == "gray_stone":
			theme.setup_gray_stone_theme()
			return theme

	theme.setup_dark_earth_theme()
	return theme


func build_current_floor() -> void:
	if dungeon_renderer == null:
		return

	dungeon_renderer.build_dungeon(
		layout,
		ability_discovery_locations,
		CELL_SIZE,
		current_floor_theme
	)


# ------------------------------------------------------------
# ÉTATS D'ÉTAGE
# Sauvegarde en session les portes ouvertes, coffres ouverts
# et cellules découvertes par étage via le layout courant.
# ------------------------------------------------------------

# Stocke l'état de l'étage courant avant une transition ou une sauvegarde.
func store_current_floor_state() -> void:
	if current_floor_id <= 0:
		return

	GameSession.set_floor_state(current_floor_id, create_current_floor_state())


# Produit un état sérialisable pour la session et la sauvegarde.
func create_current_floor_state() -> Dictionary:
	return {
		"layout": layout.duplicate(),
		"discovered_map_cells": serialize_discovered_map_cells(discovered_map_cells)
	}


# Restaure l'état mémorisé d'un étage si le joueur y est déjà passé.
func apply_floor_state_from_session(floor_id: int) -> void:
	var floor_state: Dictionary = GameSession.get_floor_state(floor_id)

	if floor_state.is_empty():
		return

	apply_floor_state(floor_state)


func apply_floor_state(floor_state: Dictionary) -> void:
	if floor_state.has("layout"):
		var saved_layout = floor_state["layout"]

		if saved_layout is Array:
			layout.clear()

			for row in saved_layout:
				layout.append(str(row))

	if floor_state.has("discovered_map_cells"):
		restore_discovered_map_cells(floor_state["discovered_map_cells"])


func serialize_discovered_map_cells(cells: Dictionary) -> Array:
	var serialized_cells: Array = []

	for cell in cells.keys():
		if cell is Vector2i:
			serialized_cells.append({
				"x": cell.x,
				"y": cell.y
			})

	return serialized_cells


func restore_discovered_map_cells(serialized_cells) -> void:
	discovered_map_cells.clear()

	if not serialized_cells is Array:
		return

	for cell_data in serialized_cells:
		if not cell_data is Dictionary:
			continue

		var cell: Vector2i = Vector2i(
			int(cell_data.get("x", 0)),
			int(cell_data.get("y", 0))
		)
		discovered_map_cells[cell] = true


# ------------------------------------------------------------
# AUTOMAP
# ------------------------------------------------------------

func discover_around_player() -> void:
	discover_cell(player.grid_cell)

	var directions: Array[Vector2i] = [
		Vector2i(0, -1),
		Vector2i(1, 0),
		Vector2i(0, 1),
		Vector2i(-1, 0)
	]

	for direction in directions:
		discover_visible_line(player.grid_cell, direction, 2)


func discover_visible_line(
	origin: Vector2i,
	direction: Vector2i,
	max_distance: int
) -> void:
	var current_cell: Vector2i = origin

	for step in range(max_distance):
		current_cell += direction

		if not is_inside_map(current_cell):
			return

		discover_cell(current_cell)

		var tile: String = get_layout_tile(current_cell)

		if tile == "#":
			return

		if tile == CLOSED_DOOR_TILE or tile == LOCKED_DOOR_TILE:
			return


func discover_cell(cell: Vector2i) -> void:
	if not is_inside_map(cell):
		return

	discovered_map_cells[cell] = true


# ------------------------------------------------------------
# DÉCOUVERTES DE SORTS
# ------------------------------------------------------------

func setup_ability_discoveries() -> void:
	ability_discovery_locations.clear()

	if current_floor_data == null:
		return

	for cell in current_floor_data.ability_discovery_locations.keys():
		ability_discovery_locations[cell] = current_floor_data.ability_discovery_locations[cell]


func check_ability_discovery() -> bool:
	var current_cell: Vector2i = player.grid_cell

	if not ability_discovery_locations.has(current_cell):
		return false

	var discovery_id: String = ability_discovery_locations[current_cell]

	if discovered_ability_ids.has(discovery_id):
		return false

	discovered_ability_ids.append(discovery_id)

	if dungeon_renderer != null:
		dungeon_renderer.hide_discovery_marker(current_cell)

	if combat_manager != null:
		combat_manager.battle_log = get_ability_discovery_message(discovery_id)

	return true


func get_ability_discovery_message(discovery_id: String) -> String:
	if discovery_id == "spell_ice_shard":
		return "Vous trouvez une rune glacée.\nLe groupe découvre le sort : Éclat de givre.\nUn Mage de niveau 2 pourra l'utiliser."

	if discovery_id == "spell_flame":
		return "Vous trouvez un grimoire brûlant.\nLe groupe découvre le sort : Flamme.\nUn Mage de niveau 3 pourra l'utiliser."

	if discovery_id == "spell_greater_heal":
		return "Vous trouvez un symbole sacré ancien.\nLe groupe découvre le sort : Soin majeur.\nUne Prêtresse de niveau 4 pourra l'utiliser."

	return "Le groupe découvre un savoir magique oublié."


# ------------------------------------------------------------
# COFFRES
# ------------------------------------------------------------

func setup_chests() -> void:
	chest_definitions.clear()

	if current_floor_data == null:
		return

	for cell in current_floor_data.chest_definitions.keys():
		chest_definitions[cell] = current_floor_data.chest_definitions[cell].duplicate(true)


func check_chest() -> bool:
	var current_cell: Vector2i = player.grid_cell

	if get_layout_tile(current_cell) != CHEST_TILE:
		return false

	var chest_data: Dictionary = get_chest_data(current_cell)
	var reward_message: String = open_chest_at(current_cell, chest_data)

	if combat_manager != null:
		combat_manager.battle_log = reward_message

	return true


func get_chest_data(cell: Vector2i) -> Dictionary:
	if chest_definitions.has(cell):
		var chest_data = chest_definitions[cell]

		if chest_data is Dictionary:
			return chest_data.duplicate(true)

	return {}


func open_chest_at(cell: Vector2i, chest_data: Dictionary) -> String:
	var gold_amount: int = max(0, int(chest_data.get("gold", 0)))
	var item_id: String = str(chest_data.get("item_id", "")).strip_edges().to_lower()
	var message_lines: Array[String] = ["Le groupe ouvre un coffre."]

	if item_id != "":
		if not GameSession.can_add_inventory_item(item_id, 1):
			return "Le coffre contient " + ItemDatabaseScript.get_display_name(item_id) + ",\nmais l'inventaire est plein."

		var add_result: Dictionary = GameSession.add_inventory_item(item_id, 1)

		if not bool(add_result.get("success", false)):
			return "Impossible de récupérer le contenu du coffre."

		message_lines.append("Vous obtenez : " + ItemDatabaseScript.get_display_name(item_id) + ".")

	if gold_amount > 0:
		GameSession.add_gold(gold_amount)
		message_lines.append("Vous trouvez " + str(gold_amount) + " or.")

	if item_id == "" and gold_amount <= 0:
		message_lines.append("Il est vide.")

	set_layout_tile(cell, ".")
	discover_cell(cell)

	if dungeon_renderer != null:
		build_current_floor()

	return "\n".join(message_lines)


# ------------------------------------------------------------
# MESSAGES / INDICES
# ------------------------------------------------------------

func setup_messages() -> void:
	message_definitions.clear()

	if current_floor_data == null:
		return

	for cell in current_floor_data.message_definitions.keys():
		message_definitions[cell] = str(current_floor_data.message_definitions[cell])


func check_message_tile() -> bool:
	var current_cell: Vector2i = player.grid_cell

	if get_layout_tile(current_cell) != MESSAGE_TILE:
		return false

	var message: String = get_message_for_cell(current_cell)

	if combat_manager != null:
		combat_manager.battle_log = message

	return true


func get_message_for_cell(cell: Vector2i) -> String:
	if message_definitions.has(cell):
		return str(message_definitions[cell])

	return "Une inscription ancienne est trop effacée pour être lue."


# ------------------------------------------------------------
# PORTES VERROUILLÉES
# ------------------------------------------------------------

func setup_locked_doors() -> void:
	locked_door_definitions.clear()

	if current_floor_data == null:
		return

	for cell in current_floor_data.locked_door_definitions.keys():
		locked_door_definitions[cell] = current_floor_data.locked_door_definitions[cell].duplicate(true)


func is_locked_door_cell(cell: Vector2i) -> bool:
	if not is_inside_map(cell):
		return false

	return get_layout_tile(cell) == LOCKED_DOOR_TILE


func try_unlock_locked_door_at(cell: Vector2i) -> bool:
	var door_data: Dictionary = get_locked_door_data(cell)
	var required_item_id: String = str(door_data.get("required_item_id", BOSS_KEY_ITEM_ID)).strip_edges().to_lower()

	if required_item_id == "":
		return false

	if GameSession.get_inventory_item_quantity(required_item_id) <= 0:
		var locked_message: String = str(door_data.get("locked_message", "Cette porte est verrouillée."))

		if combat_manager != null:
			combat_manager.battle_log = locked_message

		return false

	if not GameSession.remove_inventory_item(required_item_id, 1):
		if combat_manager != null:
			combat_manager.battle_log = "La clé est introuvable dans l'inventaire."

		return false

	set_layout_tile(cell, OPEN_DOOR_TILE)
	discover_cell(cell)

	if dungeon_renderer != null:
		dungeon_renderer.set_door_open(cell)

	var unlocked_message: String = str(door_data.get("unlocked_message", "La porte se déverrouille."))

	if combat_manager != null:
		combat_manager.battle_log = unlocked_message

	AudioManager.play_sfx("door")

	return true


func get_locked_door_data(cell: Vector2i) -> Dictionary:
	if locked_door_definitions.has(cell):
		var door_data = locked_door_definitions[cell]

		if door_data is Dictionary:
			return door_data.duplicate(true)

	return {}


# ------------------------------------------------------------
# INTERFACE
# ------------------------------------------------------------

func refresh_ui() -> void:
	if game_ui == null:
		return

	if party.is_empty():
		return

	if combat_manager.in_combat:
		var active_hero = combat_manager.get_active_hero(party)
		var commands = combat_manager.get_current_commands(party)
		var dodge_feedback_hero = null

		if combat_manager.has_method("consume_dodge_feedback_hero"):
			dodge_feedback_hero = combat_manager.consume_dodge_feedback_hero()

		AudioManager.play_battle_music()

		game_ui.show_combat(
			combat_manager.current_enemy,
			party,
			combat_manager.battle_log,
			active_hero,
			commands,
			selected_combat_command,
			layout,
			discovered_map_cells,
			player.grid_cell,
			player.get_facing_name(),
			dodge_feedback_hero
		)
	else:
		AudioManager.play_dungeon_music(current_floor_id)

		game_ui.show_exploration(
			player.grid_cell,
			player.get_facing_name(),
			party,
			combat_manager.battle_log,
			layout,
			discovered_map_cells
		)


# ------------------------------------------------------------
# DÉPLACEMENT ET PORTES
# ------------------------------------------------------------

func move_forward() -> void:
	var target: Vector2i = player.get_forward_cell()
	try_move_to_cell(target)


func move_backward() -> void:
	var target: Vector2i = player.get_backward_cell()
	try_move_to_cell(target)


func try_move_to_cell(target: Vector2i) -> void:
	if not is_walkable(target):
		return

	var origin_cell: Vector2i = player.grid_cell

	if is_locked_door_cell(target):
		if not try_unlock_locked_door_at(target):
			refresh_ui()
			return

	if is_closed_door_cell(target):
		open_door_at(target)

	player.move_to_cell(target)
	AudioManager.play_sfx("step")

	discover_around_player()

	var found_discovery: bool = check_ability_discovery()
	var found_chest: bool = check_chest()
	var found_message: bool = check_message_tile()
	var found_stairs: bool = check_stairs()
	var found_temple: bool = check_healing_temple()
	var found_shop: bool = check_shop()
	var found_boss_marker: bool = check_boss_marker(origin_cell)

	GameSession.set_shop_available(is_shop_cell(player.grid_cell))

	if (
		not found_discovery
		and not found_chest
		and not found_message
		and not found_stairs
		and not found_temple
		and not found_shop
		and not found_boss_marker
	):
		check_random_encounter_for_current_floor()

	if combat_manager != null:
		if combat_manager.in_combat:
			selected_combat_command = 0

	refresh_ui()


func open_door_at(cell: Vector2i) -> void:
	set_layout_tile(cell, OPEN_DOOR_TILE)
	discover_cell(cell)

	if dungeon_renderer != null:
		dungeon_renderer.set_door_open(cell)


func set_layout_tile(cell: Vector2i, new_tile: String) -> void:
	if not is_inside_map(cell):
		return

	var row: String = layout[cell.y]
	var before: String = row.substr(0, cell.x)
	var after: String = row.substr(cell.x + 1)
	layout[cell.y] = before + new_tile + after


func is_closed_door_cell(cell: Vector2i) -> bool:
	if not is_inside_map(cell):
		return false

	var tile: String = get_layout_tile(cell)
	return tile == CLOSED_DOOR_TILE


func turn_left() -> void:
	player.turn_left()
	discover_around_player()
	refresh_ui()


func turn_right() -> void:
	player.turn_right()
	discover_around_player()
	refresh_ui()


func check_stairs() -> bool:
	if player.grid_cell == stairs_down_cell:
		return check_stairs_down()

	if player.grid_cell == stairs_up_cell:
		return check_stairs_up()

	return false


# Gère l'escalier descendant.
# Si l'étage suivant existe, la transition est immédiate.
# Sinon, l'escalier reste un élément visuel / futur et bloque les rencontres.
func check_stairs_down() -> bool:
	var next_floor_id: int = current_floor_id + 1

	if not FloorDatabaseScript.has_floor(next_floor_id):
		if combat_manager != null:
			combat_manager.battle_log = INACTIVE_STAIRS_MESSAGE

		return true

	transition_to_floor(
		next_floor_id,
		"Le groupe descend vers l'étage " + str(next_floor_id) + "."
	)

	return true


# Gère l'escalier montant.
# Le joueur revient sur l'escalier descendant de l'étage précédent.
func check_stairs_up() -> bool:
	var previous_floor_id: int = current_floor_id - 1

	if previous_floor_id < 1 or not FloorDatabaseScript.has_floor(previous_floor_id):
		if combat_manager != null:
			combat_manager.battle_log = STAIRS_UP_MESSAGE

		return true

	var previous_floor_data = FloorDatabaseScript.get_floor_data(previous_floor_id)
	var destination_cell: Vector2i = previous_floor_data.stairs_down_cell

	transition_to_floor(
		previous_floor_id,
		"Le groupe remonte vers l'étage " + str(previous_floor_id) + ".",
		destination_cell
	)

	return true


# Charge un nouvel étage en conservant le groupe, l'inventaire, l'or et l'équipement.
func transition_to_floor(
	next_floor_id: int,
	transition_message: String,
	destination_cell: Vector2i = Vector2i(-1, -1)
) -> void:
	store_current_floor_state()

	GameSession.current_floor_id = next_floor_id
	load_floor(next_floor_id, destination_cell)
	GameSession.set_shop_available(is_shop_cell(player.grid_cell))

	if combat_manager != null:
		combat_manager.battle_log = transition_message


# Lance une rencontre aléatoire en utilisant la table de l'étage courant.
func check_random_encounter_for_current_floor() -> void:
	if combat_manager == null:
		return

	if combat_manager.in_combat:
		return

	if party.is_empty():
		return

	var encounter_chance: float = float(combat_manager.random_encounter_chance)

	if randf() > encounter_chance:
		return

	var enemy = MonsterDatabaseScript.get_random_encounter_monster(current_floor_id)
	combat_manager.start_battle(party, enemy)


# ------------------------------------------------------------
# TEMPLE DE GUÉRISON
# ------------------------------------------------------------

# Vérifie si le joueur vient d'entrer sur une case de temple.
# Si oui, restaure le groupe et indique au déplacement qu'aucune rencontre aléatoire
# ne doit être déclenchée sur cette case.
func check_healing_temple() -> bool:
	if get_layout_tile(player.grid_cell) != HEALING_TEMPLE_TILE:
		return false

	restore_party_at_temple()

	if combat_manager != null:
		combat_manager.battle_log = "Le groupe se recueille au temple.\nTous les PV et PM sont restaurés."

	AudioManager.play_sfx("heal")

	return true


# Restaure complètement tous les membres du groupe.
# Cette version restaure aussi les héros tombés à 0 PV.
func restore_party_at_temple() -> void:
	for hero in party:
		if hero == null:
			continue

		hero.hp = hero.max_hp
		hero.mp = hero.max_mp


# ------------------------------------------------------------
# BOUTIQUE
# ------------------------------------------------------------

# Vérifie si le joueur vient d'entrer sur une case de boutique.
# La boutique est un lieu sûr : aucune rencontre aléatoire ne doit s'y déclencher.
func check_shop() -> bool:
	if not is_shop_cell(player.grid_cell):
		return false

	if combat_manager != null:
		combat_manager.battle_log = SHOP_DISCOVERY_MESSAGE

	return true


func is_shop_cell(cell: Vector2i) -> bool:
	return get_layout_tile(cell) == SHOP_TILE


# ------------------------------------------------------------
# BOSS / RENCONTRE MAJEURE
# ------------------------------------------------------------

# Déclenche une rencontre fixe quand le joueur entre sur un symbole X.
func check_boss_marker(previous_cell: Vector2i = Vector2i(-1, -1)) -> bool:
	if get_layout_tile(player.grid_cell) != BOSS_TILE:
		return false

	return start_boss_encounter_at(player.grid_cell, previous_cell)


# Lance le boss de l'étage courant.
# Pour v0.7.1, le seul boss actif est le gardien de l'étage 2.
func start_boss_encounter_at(boss_cell: Vector2i, return_cell: Vector2i) -> bool:
	if combat_manager == null:
		return true

	if combat_manager.in_combat:
		return true

	if party.is_empty():
		return true

	var boss_monster_id: String = get_boss_monster_id_for_cell(current_floor_id, boss_cell)

	if boss_monster_id == "":
		return true

	active_boss_combat_cell = boss_cell
	active_boss_return_cell = return_cell
	active_boss_monster_id = boss_monster_id
	active_boss_in_progress = true

	var enemy = MonsterDatabaseScript.get_monster_data(boss_monster_id)
	combat_manager.start_battle(party, enemy)
	selected_combat_command = 0

	return true


# Associe les symboles X aux futurs boss fixes.
# Cette fonction pourra recevoir d'autres coordonnées plus tard.
func get_boss_monster_id_for_cell(floor_id: int, cell: Vector2i) -> String:
	if floor_id == 2 and cell == Vector2i(4, 1):
		return GUARDIAN_BOSS_MONSTER_ID

	return ""


# ------------------------------------------------------------
# LECTURE DE LA CARTE
# ------------------------------------------------------------

func is_walkable(cell: Vector2i) -> bool:
	if not is_inside_map(cell):
		return false

	var tile: String = get_layout_tile(cell)

	if tile == "#":
		return false

	return true


func is_inside_map(cell: Vector2i) -> bool:
	if cell.y < 0 or cell.y >= layout.size():
		return false

	if cell.x < 0 or cell.x >= layout[cell.y].length():
		return false

	return true


func get_layout_tile(cell: Vector2i) -> String:
	if not is_inside_map(cell):
		return "#"

	return layout[cell.y].substr(cell.x, 1)


# ------------------------------------------------------------
# OUTIL TEMPORAIRE DE DÉVELOPPEMENT
# Téléportation manuelle pour accélérer les tests de layout.
# À supprimer ou désactiver avant une version finale.
# ------------------------------------------------------------

# Renvoie la position actuelle du joueur pour préremplir le menu de test.
func get_debug_player_cell() -> Vector2i:
	if player == null:
		return Vector2i.ZERO

	return player.grid_cell


# Déplace instantanément le joueur vers une case marchable sans rencontre aléatoire.
# Cette fonction est volontairement réservée au menu temporaire de développement.
func debug_teleport_to_cell(target_cell: Vector2i) -> Dictionary:
	if combat_manager != null and combat_manager.in_combat:
		return {
			"success": false,
			"message": "Téléportation impossible pendant un combat."
		}

	if not is_inside_map(target_cell):
		return {
			"success": false,
			"message": "Coordonnée hors carte : " + str(target_cell)
		}

	if not is_walkable(target_cell):
		return {
			"success": false,
			"message": "Case non marchable : " + str(target_cell)
		}

	if is_locked_door_cell(target_cell):
		if not try_unlock_locked_door_at(target_cell):
			return {
				"success": false,
				"message": "Porte verrouillée : clé requise."
			}

	if is_closed_door_cell(target_cell):
		open_door_at(target_cell)

	var origin_cell: Vector2i = player.grid_cell
	player.move_to_cell(target_cell)
	discover_around_player()

	var found_discovery: bool = check_ability_discovery()
	var found_chest: bool = check_chest()
	var found_message: bool = check_message_tile()
	var found_stairs: bool = check_stairs()
	var found_temple: bool = check_healing_temple()
	var found_shop: bool = check_shop()
	var found_boss_marker: bool = check_boss_marker(origin_cell)

	if (
		not found_discovery
		and not found_chest
		and not found_message
		and not found_stairs
		and not found_temple
		and not found_shop
		and not found_boss_marker
	):
		if combat_manager != null:
			combat_manager.battle_log = "Téléportation de test vers " + str(target_cell) + "."

	GameSession.set_shop_available(is_shop_cell(player.grid_cell))

	if game_ui != null and game_ui.has_method("close_in_game_menu"):
		game_ui.close_in_game_menu()

	refresh_ui()

	return {
		"success": true,
		"message": "Téléporté vers X " + str(target_cell.x) + " / Y " + str(target_cell.y)
	}


# ------------------------------------------------------------
# SAUVEGARDE
# ------------------------------------------------------------

func save_current_game() -> void:
	if save_controller == null:
		save_controller = DungeonSaveControllerScript.new()

	var result: Dictionary = save_controller.request_save(self)
	var message: String = str(result.get("message", ""))

	if combat_manager != null:
		combat_manager.battle_log = message

	refresh_ui()
