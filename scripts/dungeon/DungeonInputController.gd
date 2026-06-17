extends RefCounted
class_name DungeonInputController

var escape_was_pressed: bool = false


func handle_input(dungeon, event: InputEvent) -> void:
	if handle_debug_save_input(dungeon, event):
		return

	if handle_escape_input(dungeon, event):
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


func handle_debug_save_input(dungeon, event: InputEvent) -> bool:
	if not (event is InputEventKey):
		return false

	var key_event: InputEventKey = event as InputEventKey

	if not key_event.pressed:
		return false

	if key_event.echo:
		return false

	if key_event.keycode != KEY_F5:
		return false

	dungeon.save_current_game()
	return true


func handle_escape_input(dungeon, event: InputEvent) -> bool:
	if not (event is InputEventKey):
		return false

	var key_event: InputEventKey = event as InputEventKey

	if key_event.keycode != KEY_ESCAPE and key_event.physical_keycode != KEY_ESCAPE:
		return false

	if key_event.echo:
		return true

	if key_event.pressed:
		if escape_was_pressed:
			return true

		escape_was_pressed = true
		dungeon.toggle_adventure_menu()
		return true

	escape_was_pressed = false
	return true


func is_in_game_menu_open(dungeon) -> bool:
	if dungeon.game_ui == null:
		return false

	if not dungeon.game_ui.has_method("is_in_game_menu_open"):
		return false

	return dungeon.game_ui.is_in_game_menu_open()


func handle_exploration_input(dungeon, event: InputEvent) -> bool:
	if event.is_action_pressed("ui_up"):
		dungeon.move_forward()
		return true

	if event.is_action_pressed("ui_down"):
		dungeon.move_backward()
		return true

	if event.is_action_pressed("ui_left"):
		dungeon.turn_left()
		return true

	if event.is_action_pressed("ui_right"):
		dungeon.turn_right()
		return true

	return false


func handle_combat_input(dungeon, event: InputEvent) -> bool:
	if dungeon.combat_manager == null:
		return false

	if not dungeon.combat_manager.in_combat:
		return false

	if has_pending_combat_damage_acknowledgement(dungeon):
		if event.is_action_pressed("ui_accept"):
			acknowledge_pending_combat_damage(dungeon)

		return true

	var active_hero = dungeon.combat_manager.get_active_hero()

	if active_hero == null:
		dungeon.refresh_ui()
		return true

	var commands: Array[String] = active_hero.get_combat_commands()

	if commands.is_empty():
		dungeon.refresh_ui()
		return true

	if dungeon.selected_combat_command < 0:
		dungeon.selected_combat_command = 0

	if dungeon.selected_combat_command >= commands.size():
		dungeon.selected_combat_command = commands.size() - 1

	if event.is_action_pressed("ui_left"):
		dungeon.selected_combat_command -= 1

		if dungeon.selected_combat_command < 0:
			dungeon.selected_combat_command = commands.size() - 1

		dungeon.refresh_ui()
		return true

	if event.is_action_pressed("ui_right"):
		dungeon.selected_combat_command += 1

		if dungeon.selected_combat_command >= commands.size():
			dungeon.selected_combat_command = 0

		dungeon.refresh_ui()
		return true

	if event.is_action_pressed("ui_accept"):
		if try_acknowledge_damage_input(dungeon, event):
			return true

		execute_selected_combat_command(dungeon, commands)

		dungeon.selected_combat_command = 0
		dungeon.refresh_ui()
		return true

	return false


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


func execute_selected_combat_command(dungeon, commands: Array[String]) -> void:
	if commands.is_empty():
		return

	if dungeon.selected_combat_command < 0:
		dungeon.selected_combat_command = 0

	if dungeon.selected_combat_command >= commands.size():
		dungeon.selected_combat_command = 0

	var selected_command: String = commands[dungeon.selected_combat_command]

	if selected_command == "Attaquer":
		dungeon.combat_manager.hero_attack()
		return

	if selected_command == "Magie":
		dungeon.combat_manager.hero_use_first_available_magic()
		return

	if selected_command == "Soin":
		dungeon.combat_manager.hero_use_first_available_heal()
		return

	if selected_command == "Fuir":
		dungeon.combat_manager.try_escape()
		return


func try_acknowledge_damage_input(dungeon, event: InputEvent) -> bool:
	if not event.is_action_pressed("ui_accept"):
		return false

	if dungeon.game_ui == null:
		return false

	if not dungeon.game_ui.has_method("has_pending_damage_acknowledgement"):
		return false

	if not dungeon.game_ui.has_pending_damage_acknowledgement():
		return false

	dungeon.game_ui.acknowledge_damage_portraits()
	dungeon.refresh_ui()
	return true
