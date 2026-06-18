extends RefCounted
class_name DungeonInputController

# ------------------------------------------------------------
# CONSTANTES — ACTIONS GODOT EXISTANTES
# ------------------------------------------------------------

const ACTION_UI_ACCEPT: String = "ui_accept"
const ACTION_UI_CANCEL: String = "ui_cancel"

# Ces actions sont déclarées dans project.godot pour documenter les contrôles,
# mais les touches de lettres sont lues avec keycode plutôt qu'avec
# physical_keycode. Cela respecte le clavier AZERTY réel : Z/Q/S/D.
const ACTION_MOVE_FORWARD: String = "move_forward"
const ACTION_MOVE_BACK: String = "move_back"
const ACTION_TURN_LEFT: String = "turn_left"
const ACTION_TURN_RIGHT: String = "turn_right"
const ACTION_CONFIRM: String = "confirm_action"
const ACTION_BACK: String = "back_action"

# ------------------------------------------------------------
# CONSTANTES — COMMANDES UI
# ------------------------------------------------------------

const COMMAND_MOVE_FORWARD: String = "move_forward"
const COMMAND_MOVE_BACK: String = "move_back"
const COMMAND_TURN_LEFT: String = "turn_left"
const COMMAND_TURN_RIGHT: String = "turn_right"
const COMMAND_MENU: String = "menu"

# ------------------------------------------------------------
# INPUT PRIORITAIRE
# Sert aux clics globaux qui doivent passer avant l'interface.
# ------------------------------------------------------------

func handle_priority_input(dungeon, event: InputEvent) -> bool:
	if dungeon == null:
		return false

	if is_in_game_menu_open(dungeon):
		return false

	if not is_primary_mouse_click_event(event):
		return false

	if dungeon.combat_manager == null:
		return false

	if not dungeon.combat_manager.in_combat:
		return false

	if has_pending_combat_damage_acknowledgement(dungeon):
		acknowledge_pending_combat_damage(dungeon)
		return true

	return false

# ------------------------------------------------------------
# INPUT PRINCIPAL
# ------------------------------------------------------------

func handle_input(dungeon, event: InputEvent) -> void:
	if handle_debug_save_input(dungeon, event):
		return

	if handle_back_input(dungeon, event):
		return

	if is_in_game_menu_open(dungeon):
		return

	if dungeon.party.is_empty():
		return

	if dungeon.combat_manager == null:
		return

	if dungeon.combat_manager.in_combat:
		handle_combat_input(dungeon, event)
		return

	handle_exploration_input(dungeon, event)

# ------------------------------------------------------------
# INPUTS SYSTÈME
# ------------------------------------------------------------

func handle_debug_save_input(dungeon, event: InputEvent) -> bool:
	if not is_key_pressed(event, KEY_F5):
		return false

	dungeon.save_current_game()
	return true


func handle_back_input(dungeon, event: InputEvent) -> bool:
	if not is_back_input_event(event):
		return false

	if event is InputEventKey:
		var key_event: InputEventKey = event as InputEventKey

		if key_event.echo:
			return true

		if not key_event.pressed:
			return true

	# E imite le comportement actuel d'Échap : ouvrir / fermer le menu d'aventure.
	dungeon.toggle_adventure_menu()
	return true


func is_in_game_menu_open(dungeon) -> bool:
	if dungeon.game_ui == null:
		return false

	if not dungeon.game_ui.has_method("is_in_game_menu_open"):
		return false

	return dungeon.game_ui.is_in_game_menu_open()

# ------------------------------------------------------------
# INPUT EXPLORATION
# ------------------------------------------------------------

func handle_exploration_input(dungeon, event: InputEvent) -> bool:
	if is_move_forward_input_event(event):
		execute_exploration_command(dungeon, COMMAND_MOVE_FORWARD)
		return true

	if is_move_back_input_event(event):
		execute_exploration_command(dungeon, COMMAND_MOVE_BACK)
		return true

	if is_turn_left_input_event(event):
		execute_exploration_command(dungeon, COMMAND_TURN_LEFT)
		return true

	if is_turn_right_input_event(event):
		execute_exploration_command(dungeon, COMMAND_TURN_RIGHT)
		return true

	# A imite Espace / Entrée. En exploration, ces touches n'avaient pas encore
	# d'action dédiée ; on conserve donc ce comportement neutre.
	if is_confirm_input_event(event):
		return true

	return false


func execute_exploration_command(dungeon, command_id: String) -> bool:
	if dungeon == null:
		return false

	if dungeon.combat_manager != null and dungeon.combat_manager.in_combat:
		return false

	if is_in_game_menu_open(dungeon):
		return false

	match command_id:
		COMMAND_MOVE_FORWARD:
			dungeon.move_forward()
			return true
		COMMAND_MOVE_BACK:
			dungeon.move_backward()
			return true
		COMMAND_TURN_LEFT:
			dungeon.turn_left()
			return true
		COMMAND_TURN_RIGHT:
			dungeon.turn_right()
			return true
		COMMAND_MENU:
			dungeon.toggle_adventure_menu()
			return true
		_:
			return false

# ------------------------------------------------------------
# INPUT COMBAT
# ------------------------------------------------------------

func handle_combat_input(dungeon, event: InputEvent) -> bool:
	if dungeon.combat_manager == null:
		return false

	if not dungeon.combat_manager.in_combat:
		return false

	if has_pending_combat_damage_acknowledgement(dungeon):
		if is_confirm_input_event(event):
			acknowledge_pending_combat_damage(dungeon)

		return true

	var commands: Array[String] = get_active_combat_commands(dungeon)

	if commands.is_empty():
		dungeon.refresh_ui()
		return true

	clamp_selected_combat_command(dungeon, commands)

	if is_turn_left_input_event(event):
		dungeon.selected_combat_command -= 1

		if dungeon.selected_combat_command < 0:
			dungeon.selected_combat_command = commands.size() - 1

		dungeon.refresh_ui()
		return true

	if is_turn_right_input_event(event):
		dungeon.selected_combat_command += 1

		if dungeon.selected_combat_command >= commands.size():
			dungeon.selected_combat_command = 0

		dungeon.refresh_ui()
		return true

	if is_confirm_input_event(event):
		execute_selected_combat_command(dungeon, commands)
		return true

	return false


func execute_combat_command_by_index(dungeon, command_index: int) -> bool:
	if dungeon == null:
		return false

	if dungeon.combat_manager == null:
		return false

	if not dungeon.combat_manager.in_combat:
		return false

	if has_pending_combat_damage_acknowledgement(dungeon):
		acknowledge_pending_combat_damage(dungeon)
		return true

	var commands: Array[String] = get_active_combat_commands(dungeon)

	if commands.is_empty():
		dungeon.refresh_ui()
		return true

	if command_index < 0 or command_index >= commands.size():
		return false

	dungeon.selected_combat_command = command_index
	execute_selected_combat_command(dungeon, commands)
	return true


func get_active_combat_commands(dungeon) -> Array[String]:
	if dungeon.combat_manager == null:
		return []

	var active_hero = dungeon.combat_manager.get_active_hero()

	if active_hero == null:
		dungeon.refresh_ui()
		return []

	return active_hero.get_combat_commands()


func clamp_selected_combat_command(dungeon, commands: Array[String]) -> void:
	if commands.is_empty():
		dungeon.selected_combat_command = 0
		return

	if dungeon.selected_combat_command < 0:
		dungeon.selected_combat_command = 0

	if dungeon.selected_combat_command >= commands.size():
		dungeon.selected_combat_command = commands.size() - 1


func execute_selected_combat_command(dungeon, commands: Array[String]) -> void:
	if commands.is_empty():
		return

	clamp_selected_combat_command(dungeon, commands)

	var selected_command: String = commands[dungeon.selected_combat_command]

	if selected_command == "Attaquer":
		dungeon.combat_manager.hero_attack()
	elif selected_command == "Magie":
		dungeon.combat_manager.hero_use_first_available_magic()
	elif selected_command == "Soin":
		dungeon.combat_manager.hero_use_first_available_heal()
	elif selected_command == "Fuir":
		dungeon.combat_manager.try_escape()

	dungeon.selected_combat_command = 0
	dungeon.refresh_ui()

# ------------------------------------------------------------
# VALIDATION DES DÉGÂTS
# ------------------------------------------------------------

func has_pending_combat_damage_acknowledgement(dungeon) -> bool:
	if dungeon.combat_manager == null:
		return false

	if not dungeon.combat_manager.has_method("has_pending_damage_acknowledgement"):
		return false

	return dungeon.combat_manager.has_pending_damage_acknowledgement()


func acknowledge_pending_combat_damage(dungeon) -> bool:
	var acknowledged: bool = false

	if dungeon.game_ui != null:
		if dungeon.game_ui.has_method("has_pending_damage_acknowledgement"):
			if dungeon.game_ui.has_pending_damage_acknowledgement():
				if dungeon.game_ui.has_method("acknowledge_damage_portraits"):
					dungeon.game_ui.acknowledge_damage_portraits()
					acknowledged = true

	if dungeon.combat_manager != null:
		if dungeon.combat_manager.has_method("acknowledge_pending_damage"):
			if dungeon.combat_manager.acknowledge_pending_damage():
				acknowledged = true

	dungeon.refresh_ui()
	return acknowledged

# ------------------------------------------------------------
# OUTILS INPUT — MOUVEMENT AZERTY
# ------------------------------------------------------------

func is_move_forward_input_event(event: InputEvent) -> bool:
	return is_key_pressed(event, KEY_UP) or is_key_pressed(event, KEY_Z)


func is_move_back_input_event(event: InputEvent) -> bool:
	return is_key_pressed(event, KEY_DOWN) or is_key_pressed(event, KEY_S)


func is_turn_left_input_event(event: InputEvent) -> bool:
	return is_key_pressed(event, KEY_LEFT) or is_key_pressed(event, KEY_Q)


func is_turn_right_input_event(event: InputEvent) -> bool:
	return is_key_pressed(event, KEY_RIGHT) or is_key_pressed(event, KEY_D)


func is_confirm_input_event(event: InputEvent) -> bool:
	if is_action_pressed_safe(event, ACTION_UI_ACCEPT):
		return true

	return is_key_pressed(event, KEY_A)


func is_back_input_event(event: InputEvent) -> bool:
	if is_action_pressed_safe(event, ACTION_UI_CANCEL):
		return true

	return is_key_pressed(event, KEY_ESCAPE) or is_key_pressed(event, KEY_E)


func is_key_pressed(event: InputEvent, expected_keycode: int) -> bool:
	if not (event is InputEventKey):
		return false

	var key_event: InputEventKey = event as InputEventKey

	if not key_event.pressed:
		return false

	if key_event.echo:
		return false

	return key_event.keycode == expected_keycode


func is_primary_mouse_click_event(event: InputEvent) -> bool:
	if not (event is InputEventMouseButton):
		return false

	var mouse_event: InputEventMouseButton = event as InputEventMouseButton
	return mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_LEFT


func is_action_pressed_safe(event: InputEvent, action_name: String) -> bool:
	if not InputMap.has_action(action_name):
		return false

	return event.is_action_pressed(action_name)
