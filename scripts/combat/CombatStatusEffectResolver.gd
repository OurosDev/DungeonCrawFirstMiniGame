extends RefCounted
class_name CombatStatusEffectResolver

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------


# ------------------------------------------------------------
# STATUTS DE COMBAT
# Première base réutilisable pour les effets temporaires.
# v0.13-Magicka introduit Poison sur les monstres.
# ------------------------------------------------------------

const CombatActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")
const CombatDamageResolverScript = preload("res://scripts/combat/CombatDamageResolver.gd")

const STATUS_META_KEY: String = "status_effects"
const STATUS_POISON: String = "poison"
const POISON_BOSS_IMMUNE_IDS: Array[String] = ["gardien_boss_etage_2"]


# ------------------------------------------------------------
# POISON
# Applique ou rafraîchit le poison sur un monstre.
# ------------------------------------------------------------

static func apply_poison_to_monster(
	monster,
	min_percent: int,
	max_percent: int
) -> Dictionary:
	var result: Dictionary = {
		"success": false,
		"message": ""
	}

	if monster == null:
		result["message"] = "La cible du poison est introuvable."
		return result

	var monster_name: String = CombatActorAccessScript.get_enemy_name(monster)

	if is_poison_immune(monster):
		result["message"] = monster_name + " résiste au poison."
		return result

	var status_effects: Dictionary = get_status_effects(monster)
	var poison_data: Dictionary = {
		"elapsed_ticks": 0,
		"min_percent": max(1, min_percent),
		"max_percent": max(max(1, min_percent), max_percent)
	}

	var was_already_poisoned: bool = status_effects.has(STATUS_POISON)
	status_effects[STATUS_POISON] = poison_data
	set_status_effects(monster, status_effects)

	result["success"] = true

	if was_already_poisoned:
		result["message"] = "Le poison qui ronge " + monster_name + " est ravivé."
	else:
		result["message"] = monster_name + " est empoisonné."

	return result


static func is_poison_immune(monster) -> bool:
	var monster_id: String = CombatActorAccessScript.get_monster_identifier(monster)
	return POISON_BOSS_IMMUNE_IDS.has(monster_id)


# ------------------------------------------------------------
# FIN DE TOUR MONSTRE
# Résout les ticks de poison après l'action du monstre.
# ------------------------------------------------------------

static func resolve_monster_end_turn_status_effects(monster) -> Array[String]:
	var log_lines: Array[String] = []

	if monster == null:
		return log_lines

	var status_effects: Dictionary = get_status_effects(monster)

	if status_effects.has(STATUS_POISON):
		resolve_poison_tick(monster, status_effects, log_lines)

	set_status_effects(monster, status_effects)
	return log_lines


static func resolve_poison_tick(
	monster,
	status_effects: Dictionary,
	log_lines: Array[String]
) -> void:
	if not status_effects.has(STATUS_POISON):
		return

	var poison_data = status_effects.get(STATUS_POISON, {})
	if not (poison_data is Dictionary):
		status_effects.erase(STATUS_POISON)
		return

	var elapsed_ticks: int = int(poison_data.get("elapsed_ticks", 0)) + 1
	poison_data["elapsed_ticks"] = elapsed_ticks

	var min_percent: int = int(poison_data.get("min_percent", 5))
	var max_percent: int = int(poison_data.get("max_percent", 10))
	if max_percent < min_percent:
		max_percent = min_percent

	var percent: int = randi_range(min_percent, max_percent)
	var max_hp: int = CombatActorAccessScript.get_int_property(monster, "max_hp", 1)
	var damage: int = max(1, int(round(float(max_hp) * float(percent) / 100.0)))

	CombatDamageResolverScript.apply_damage_to_actor(monster, damage)

	var monster_name: String = CombatActorAccessScript.get_enemy_name(monster)
	log_lines.append("Le poison inflige " + str(damage) + " dégâts à " + monster_name + ".")

	var current_hp: int = CombatActorAccessScript.get_int_property(monster, "hp", 0)
	if current_hp <= 0:
		return

	if should_poison_end(elapsed_ticks):
		status_effects.erase(STATUS_POISON)
		log_lines.append("Le poison qui affectait " + monster_name + " se dissipe.")
		return

	status_effects[STATUS_POISON] = poison_data


static func should_poison_end(elapsed_ticks: int) -> bool:
	if elapsed_ticks >= 4:
		return true

	var denominator: int = 6
	if elapsed_ticks == 2:
		denominator = 4
	elif elapsed_ticks == 3:
		denominator = 2

	return randi_range(1, denominator) == 1


# ------------------------------------------------------------
# STOCKAGE
# Les statuts sont stockés en meta pour éviter d'étendre tous les acteurs
# dès cette première intégration.
# ------------------------------------------------------------

static func get_status_effects(actor) -> Dictionary:
	if actor == null:
		return {}

	if actor.has_meta(STATUS_META_KEY):
		var data = actor.get_meta(STATUS_META_KEY)
		if data is Dictionary:
			return data.duplicate(true)

	return {}


static func set_status_effects(actor, status_effects: Dictionary) -> void:
	if actor == null:
		return

	actor.set_meta(STATUS_META_KEY, status_effects.duplicate(true))


static func clear_status_effects(actor) -> void:
	if actor == null:
		return

	if actor.has_meta(STATUS_META_KEY):
		actor.remove_meta(STATUS_META_KEY)
