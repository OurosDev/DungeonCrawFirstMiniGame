extends RefCounted
class_name CombatAccuracyResolver

# ------------------------------------------------------------
# PRÉCISION / ESQUIVE
# Centralise les règles de toucher des attaques physiques.
# ------------------------------------------------------------

const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")


static func roll_physical_attack_hits(attacker, defender) -> bool:
	if attacker == null:
		return false
	if defender == null:
		return false

	var attack_score: int = get_accuracy_score(attacker) + randi_range(1, 20)
	var evasion_score: int = get_evasion_score(defender) + randi_range(1, 20)
	return attack_score >= evasion_score


static func get_accuracy_score(actor) -> int:
	if ActorAccessScript.is_monster_actor(actor):
		return get_monster_accuracy_score(actor)
	return get_hero_accuracy_score(actor)


static func get_evasion_score(actor) -> int:
	if ActorAccessScript.is_monster_actor(actor):
		return get_monster_evasion_score(actor)
	return get_hero_evasion_score(actor)


static func get_hero_accuracy_score(hero) -> int:
	var job_name: String = ActorAccessScript.normalize_identifier(
		ActorAccessScript.get_string_property(hero, "job", "")
	)

	if job_name == "guerrier":
		return 13
	if job_name == "voleuse" or job_name == "voleur":
		return 11
	if job_name == "mage":
		return 8
	if job_name == "pretresse" or job_name == "pretre":
		return 10
	return 10


static func get_hero_evasion_score(hero) -> int:
	var job_name: String = ActorAccessScript.normalize_identifier(
		ActorAccessScript.get_string_property(hero, "job", "")
	)

	if job_name == "guerrier":
		return 7
	if job_name == "voleuse" or job_name == "voleur":
		return 13
	if job_name == "mage":
		return 8
	if job_name == "pretresse" or job_name == "pretre":
		return 9
	return 8


static func get_monster_accuracy_score(monster) -> int:
	var monster_id: String = ActorAccessScript.get_monster_identifier(monster)

	if monster_id == "zombie":
		return 8
	if monster_id == "chauve_souris":
		return 10
	if monster_id == "gobelin":
		return 12
	if monster_id == "troll":
		return 11
	if monster_id == "gardien" or monster_id == "gardien_boss_etage_2":
		return 14
	return 10


static func get_monster_evasion_score(monster) -> int:
	var monster_id: String = ActorAccessScript.get_monster_identifier(monster)

	if monster_id == "zombie":
		return 3
	if monster_id == "chauve_souris":
		return 14
	if monster_id == "gobelin":
		return 10
	if monster_id == "troll":
		return 4
	if monster_id == "gardien" or monster_id == "gardien_boss_etage_2":
		return 9
	return 6
