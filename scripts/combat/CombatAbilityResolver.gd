extends RefCounted
class_name CombatAbilityResolver

# ------------------------------------------------------------
# CAPACITÉS / MAGIE
# Centralise la recherche de sorts disponibles et le paiement du coût en MP.
# ------------------------------------------------------------

const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")


static func get_first_available_ability(hero, requested_kind: String):
	if hero == null:
		return null

	var ability_ids: Array = get_hero_ability_ids(hero)
	for raw_ability_id in ability_ids:
		var ability_id: String = str(raw_ability_id)
		var ability = AbilityDatabaseScript.get_ability_data(ability_id)
		if ability == null:
			continue

		var ability_kind: String = ActorAccessScript.get_string_property(ability, "ability_kind", "")
		if ability_kind != requested_kind:
			continue

		if not is_ability_available_for_basic_use(hero, ability):
			continue

		return ability

	return null


static func get_hero_ability_ids(hero) -> Array:
	if hero == null:
		return []

	if ActorAccessScript.object_has_property(hero, "ability_ids"):
		var hero_ability_ids = hero.get("ability_ids")
		if hero_ability_ids is Array:
			return hero_ability_ids

	var job_name: String = ActorAccessScript.get_string_property(hero, "job", "")
	var class_data = ClassDatabaseScript.get_class_data(job_name)
	if class_data == null:
		return []

	if not ActorAccessScript.object_has_property(class_data, "ability_ids"):
		return []

	var class_ability_ids = class_data.get("ability_ids")
	if class_ability_ids is Array:
		return class_ability_ids

	return []


static func is_ability_available_for_basic_use(hero, ability) -> bool:
	if hero == null:
		return false
	if ability == null:
		return false

	var hero_level: int = ActorAccessScript.get_int_property(hero, "level", 1)
	var required_level: int = ActorAccessScript.get_int_property(ability, "required_level", 1)
	if hero_level < required_level:
		return false

	var requires_discovery: bool = ActorAccessScript.get_bool_property(
		ability,
		"requires_discovery",
		false
	)
	if not requires_discovery:
		return true

	var ability_id: String = ActorAccessScript.get_string_property(ability, "ability_id", "")
	var discovery_id: String = ActorAccessScript.get_string_property(ability, "discovery_id", "")
	return hero_has_discovered_ability(hero, ability_id, discovery_id)


static func hero_has_discovered_ability(hero, ability_id: String, discovery_id: String) -> bool:
	if group_has_discovered_ability(ability_id, discovery_id):
		return true

	if hero == null:
		return false

	var possible_property_names: Array[String] = [
		"discovered_ability_ids",
		"known_ability_ids",
		"learned_ability_ids",
		"discovered_spell_ids",
		"known_discoveries",
		"discovered_abilities"
	]

	for property_name in possible_property_names:
		if not ActorAccessScript.object_has_property(hero, property_name):
			continue

		var container = hero.get(property_name)
		if container is Array:
			if container.has(ability_id):
				return true
			if container.has(discovery_id):
				return true
		elif container is Dictionary:
			if container.has(ability_id):
				return true
			if container.has(discovery_id):
				return true

	return false


static func group_has_discovered_ability(ability_id: String, discovery_id: String) -> bool:
	# Les sorts découverts dans le donjon sont une progression de groupe.
	# GameSession est l'autoload qui conserve cette progression entre scènes.
	if GameSession == null:
		return false

	if GameSession.has_method("has_discovered_ability"):
		if discovery_id != "" and GameSession.has_discovered_ability(discovery_id):
			return true
		if ability_id != "" and GameSession.has_discovered_ability(ability_id):
			return true

	if GameSession.has_method("get_discovered_ability_ids"):
		var discovered_ids = GameSession.get_discovered_ability_ids()
		if discovered_ids is Array:
			if discovered_ids.has(discovery_id):
				return true
			if discovered_ids.has(ability_id):
				return true

	return false


static func hero_can_pay_ability_cost(hero, ability) -> bool:
	if hero == null:
		return false
	if ability == null:
		return false

	var mp_cost: int = ActorAccessScript.get_int_property(ability, "mp_cost", 0)
	if hero.has_method("can_spend_mp"):
		return hero.can_spend_mp(mp_cost)

	var current_mp: int = ActorAccessScript.get_int_property(hero, "mp", 0)
	return current_mp >= mp_cost


static func hero_pay_ability_cost(hero, ability) -> void:
	if hero == null:
		return
	if ability == null:
		return

	var mp_cost: int = ActorAccessScript.get_int_property(ability, "mp_cost", 0)
	if hero.has_method("spend_mp"):
		hero.spend_mp(mp_cost)
		return

	var current_mp: int = ActorAccessScript.get_int_property(hero, "mp", 0)
	current_mp -= mp_cost
	if current_mp < 0:
		current_mp = 0

	ActorAccessScript.set_property_if_available(hero, "mp", current_mp)
