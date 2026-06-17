extends RefCounted
class_name CombatTurnOrder

var turn_order: Array = []
var active_turn_index: int = 0


func reset() -> void:
	turn_order.clear()
	active_turn_index = 0


func rebuild(party: Array, should_reset_index: bool = false) -> void:
	if should_reset_index:
		active_turn_index = 0

	turn_order.clear()

	for hero in party:
		if hero == null:
			continue

		if is_hero_alive(hero):
			turn_order.append(hero)

	turn_order.sort_custom(func(a, b): return get_hero_agility(a) > get_hero_agility(b))

	if active_turn_index < 0:
		active_turn_index = 0

	if active_turn_index >= turn_order.size():
		active_turn_index = 0


func get_active_hero(party: Array, in_combat: bool):
	if not in_combat:
		return null

	if turn_order.is_empty():
		rebuild(party)

	if turn_order.is_empty():
		return null

	if active_turn_index < 0:
		active_turn_index = 0

	if active_turn_index >= turn_order.size():
		active_turn_index = 0

	var attempts: int = 0

	while attempts < turn_order.size():
		var active_hero = turn_order[active_turn_index]

		if active_hero != null and is_hero_alive(active_hero):
			return active_hero

		active_turn_index += 1

		if active_turn_index >= turn_order.size():
			active_turn_index = 0

		attempts += 1

	rebuild(party)

	if turn_order.is_empty():
		return null

	if active_turn_index >= turn_order.size():
		active_turn_index = 0

	var fallback_hero = turn_order[active_turn_index]

	if fallback_hero != null and is_hero_alive(fallback_hero):
		return fallback_hero

	return null


func advance_to_next_living_hero(party: Array) -> void:
	if turn_order.is_empty():
		rebuild(party)
		return

	var attempts: int = 0

	while attempts < turn_order.size():
		active_turn_index += 1

		if active_turn_index >= turn_order.size():
			active_turn_index = 0

		var hero = turn_order[active_turn_index]

		if hero != null and is_hero_alive(hero):
			return

		attempts += 1

	rebuild(party)


func is_hero_alive(hero) -> bool:
	if hero == null:
		return false

	if hero.has_method("is_alive"):
		return hero.is_alive()

	var hp: int = get_int_property(hero, "hp", 0)

	return hp > 0


func get_hero_agility(hero) -> int:
	if hero == null:
		return 0

	var stats = get_property_value(hero, "stats", null)

	if stats == null:
		return 0

	return get_int_property(stats, "agility", 0)


func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return int(target.get(property_name))


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
