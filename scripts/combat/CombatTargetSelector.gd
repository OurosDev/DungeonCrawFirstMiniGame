extends RefCounted
class_name CombatTargetSelector

# ------------------------------------------------------------
# CIBLAGE
# Centralise le choix des cibles vivantes et blessées.
# ------------------------------------------------------------

const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")


static func choose_enemy_target(party: Array):
	var living_heroes: Array = []
	for hero in party:
		if hero == null:
			continue
		if ActorAccessScript.is_hero_alive(hero):
			living_heroes.append(hero)

	if living_heroes.is_empty():
		return null

	return living_heroes[randi_range(0, living_heroes.size() - 1)]


static func get_most_wounded_living_hero(party: Array):
	var best_target = null
	var best_ratio: float = 1.1

	for hero in party:
		if hero == null:
			continue
		if not ActorAccessScript.is_hero_alive(hero):
			continue

		var max_hp: int = ActorAccessScript.get_int_property(hero, "max_hp", 1)
		var hp: int = ActorAccessScript.get_int_property(hero, "hp", max_hp)
		if max_hp <= 0:
			continue

		var ratio: float = float(hp) / float(max_hp)
		if ratio < best_ratio:
			best_ratio = ratio
			best_target = hero

	return best_target
