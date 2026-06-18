extends RefCounted
class_name CombatActorAccess

# ------------------------------------------------------------
# ACCÈS ACTEURS / PROPRIÉTÉS
# Centralise les helpers génériques utilisés par le combat.
# ------------------------------------------------------------

static func get_int_property(target, property_name: String, default_value: int = 0) -> int:
	if target == null:
		return default_value
	if not object_has_property(target, property_name):
		return default_value
	return int(_get_property_value_unchecked(target, property_name, default_value))


static func get_bool_property(target, property_name: String, default_value: bool = false) -> bool:
	if target == null:
		return default_value
	if not object_has_property(target, property_name):
		return default_value
	return bool(_get_property_value_unchecked(target, property_name, default_value))


static func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value
	if not object_has_property(target, property_name):
		return default_value
	return str(_get_property_value_unchecked(target, property_name, default_value))


static func get_property_value(target, property_name: String, default_value = null):
	if target == null:
		return default_value
	if not object_has_property(target, property_name):
		return default_value
	return _get_property_value_unchecked(target, property_name, default_value)


static func set_property_if_available(target, property_name: String, value) -> void:
	if target == null:
		return
	if target is Dictionary:
		target[property_name] = value
		return
	if typeof(target) != TYPE_OBJECT:
		return
	if not object_has_property(target, property_name):
		return
	target.set(property_name, value)


static func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false
	if target is Dictionary:
		return target.has(property_name)
	if typeof(target) != TYPE_OBJECT:
		return false
	if not target.has_method("get_property_list"):
		return false
	var property_list: Array = target.get_property_list()
	for property_data in property_list:
		if not property_data.has("name"):
			continue
		if str(property_data["name"]) == property_name:
			return true
	return false


static func _get_property_value_unchecked(target, property_name: String, default_value = null):
	if target is Dictionary:
		return target.get(property_name, default_value)
	if typeof(target) != TYPE_OBJECT:
		return default_value
	return target.get(property_name)


# ------------------------------------------------------------
# IDENTITÉ / NOMS
# Fournit les libellés utilisés dans les logs de combat.
# ------------------------------------------------------------

static func get_enemy_name(enemy) -> String:
	if enemy == null:
		return "ennemi"
	return get_string_property(enemy, "monster_name", "ennemi")


static func get_reward_enemy_name(enemy) -> String:
	if enemy == null:
		return "L'ennemi"
	return get_string_property(enemy, "monster_name", "L'ennemi")


static func get_hero_name(hero) -> String:
	if hero == null:
		return "Héros"
	return get_string_property(hero, "character_name", "Héros")


static func get_ability_name(ability) -> String:
	if ability == null:
		return "sort"
	return get_string_property(ability, "display_name", "sort")


static func normalize_identifier(text: String) -> String:
	var normalized: String = text.strip_edges().to_lower()
	normalized = normalized.replace(" ", "_")
	normalized = normalized.replace("-", "_")
	normalized = normalized.replace("é", "e")
	normalized = normalized.replace("è", "e")
	normalized = normalized.replace("ê", "e")
	normalized = normalized.replace("ë", "e")
	normalized = normalized.replace("à", "a")
	normalized = normalized.replace("â", "a")
	normalized = normalized.replace("ù", "u")
	normalized = normalized.replace("û", "u")
	normalized = normalized.replace("î", "i")
	normalized = normalized.replace("ï", "i")
	normalized = normalized.replace("ô", "o")
	normalized = normalized.replace("ö", "o")
	normalized = normalized.replace("ç", "c")
	return normalized


# ------------------------------------------------------------
# ÉTATS ACTEURS
# Regroupe les tests communs sur les héros et monstres.
# ------------------------------------------------------------

static func is_hero_alive(hero) -> bool:
	if hero == null:
		return false
	if hero.has_method("is_alive"):
		return hero.is_alive()
	var hp: int = get_int_property(hero, "hp", 0)
	return hp > 0


static func get_hero_agility(hero) -> int:
	if hero == null:
		return 0
	var stats = get_property_value(hero, "stats", null)
	if stats == null:
		return 0
	return get_int_property(stats, "agility", 0)


static func is_monster_actor(actor) -> bool:
	if actor == null:
		return false
	if object_has_property(actor, "monster_id"):
		return true
	if object_has_property(actor, "monster_name"):
		return true
	return false


static func get_monster_identifier(monster) -> String:
	var monster_id: String = get_string_property(monster, "monster_id", "")
	if monster_id != "":
		return normalize_identifier(monster_id)

	var monster_name: String = get_string_property(monster, "monster_name", "")
	if monster_name != "":
		return normalize_identifier(monster_name)

	return ""
