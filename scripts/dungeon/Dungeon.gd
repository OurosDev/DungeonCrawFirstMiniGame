extends Node3D

const CELL_SIZE: float = 2.0
const HEALING_TEMPLE_TILE: String = "O"

const DungeonThemeDataScript = preload("res://scripts/dungeon/DungeonThemeData.gd")
const FloorDatabaseScript = preload("res://scripts/dungeon/FloorDatabase.gd")
const DungeonInputControllerScript = preload("res://scripts/dungeon/DungeonInputController.gd")
const DungeonSaveControllerScript = preload("res://scripts/dungeon/DungeonSaveController.gd")

const PARTY_CREATION_SCENE_PATH: String = "res://scenes/PartyCreation.tscn"
const MAIN_MENU_SCENE_PATH: String = "res://scenes/MainMenu.tscn"


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
var discovered_map_cells: Dictionary = {}

var current_floor_theme = null
var current_floor_id: int = 1
var current_floor_data = null
var layout: Array[String] = []
var stairs_down_cell: Vector2i = Vector2i(-1, -1)


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

	connect_in_game_menu_signals()

	AudioManager.play_dungeon_music(current_floor_id)

	refresh_ui()


# ------------------------------------------------------------
# INPUT
# ------------------------------------------------------------

func _unhandled_input(event: InputEvent) -> void:
	if input_controller == null:
		input_controller = DungeonInputControllerScript.new()

	input_controller.handle_input(self, event)


# ------------------------------------------------------------
# MENU D'AVENTURE
# ------------------------------------------------------------

func toggle_adventure_menu() -> void:
	if combat_manager != null:
		if combat_manager.in_combat:
			return

	if game_ui == null:
		return

	game_ui.toggle_in_game_menu(party)


func connect_in_game_menu_signals() -> void:
	if game_ui == null:
		return

	if not game_ui.in_game_menu_save_requested.is_connected(on_in_game_menu_save_requested):
		game_ui.in_game_menu_save_requested.connect(on_in_game_menu_save_requested)

	if not game_ui.in_game_menu_quit_requested.is_connected(on_in_game_menu_quit_requested):
		game_ui.in_game_menu_quit_requested.connect(on_in_game_menu_quit_requested)


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

func load_floor(floor_id: int) -> void:
	current_floor_id = floor_id
	current_floor_data = FloorDatabaseScript.get_floor_data(current_floor_id)

	layout = current_floor_data.layout.duplicate()
	stairs_down_cell = current_floor_data.stairs_down_cell

	ability_discovery_locations.clear()
	discovered_map_cells.clear()

	player.move_to_cell(current_floor_data.player_start_cell)

	current_floor_theme = create_current_floor_theme()

	setup_ability_discoveries()
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

		if tile == "D":
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

	if is_closed_door_cell(target):
		open_door_at(target)

	player.move_to_cell(target)

	AudioManager.play_sfx("step")

	discover_around_player()

	var found_discovery: bool = check_ability_discovery()
	var found_stairs: bool = check_stairs()
	var found_temple: bool = check_healing_temple()

	if not found_discovery and not found_stairs and not found_temple:
		if combat_manager != null:
			combat_manager.check_random_encounter(party)

	if combat_manager != null:
		if combat_manager.in_combat:
			selected_combat_command = 0

	refresh_ui()


func open_door_at(cell: Vector2i) -> void:
	set_layout_tile(cell, "d")
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

	return tile == "D"


func turn_left() -> void:
	player.turn_left()
	discover_around_player()
	refresh_ui()


func turn_right() -> void:
	player.turn_right()
	discover_around_player()
	refresh_ui()


func check_stairs() -> bool:
	if player.grid_cell != stairs_down_cell:
		return false

	if combat_manager != null:
		combat_manager.battle_log = "Un escalier descend vers l'étage inférieur."

	return true


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
