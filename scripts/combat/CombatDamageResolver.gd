extends RefCounted
class_name CombatDamageResolver

# ------------------------------------------------------------
# DÉGÂTS / SOINS
# Centralise les jets de dégâts, la puissance des sorts et les variations de HP.
# ------------------------------------------------------------

const ActorAccessScript = preload("res://scripts/combat/CombatActorAccess.gd")


static func roll_hero_attack_damage(hero) -> int:
	if hero == null:
		return 0
	if hero.has_method("roll_attack_damage"):
		return max(0, int(hero.roll_attack_damage()))

	var stats = ActorAccessScript.get_property_value(hero, "stats", null)
	var strength_bonus: int = 0
	if stats != null:
		strength_bonus = int(floor(float(ActorAccessScript.get_int_property(stats, "strength", 1)) / 3.0))

	return randi_range(1, 4) + strength_bonus


static func roll_hero_spell_power(hero, ability) -> int:
	if hero == null:
		return 0
	if ability == null:
		return 0

	var min_power: int = ActorAccessScript.get_int_property(ability, "power_min", 1)
	var max_power: int = ActorAccessScript.get_int_property(ability, "power_max", min_power)
	if max_power < min_power:
		max_power = min_power

	var amount: int = randi_range(min_power, max_power)
	var uses_magic_modifier: bool = ActorAccessScript.get_bool_property(
		ability,
		"uses_magic_modifier",
		true
	)

	if uses_magic_modifier:
		var stats = ActorAccessScript.get_property_value(hero, "stats", null)
		if stats != null and stats.has_method("get_magic_modifier"):
			amount += int(stats.get_magic_modifier())

	return max(0, amount)


static func roll_enemy_attack_damage(enemy) -> int:
	if enemy == null:
		return 0
	if enemy.has_method("roll_attack_damage"):
		return max(0, int(enemy.roll_attack_damage()))

	var min_damage: int = ActorAccessScript.get_int_property(enemy, "attack_min", 1)
	var max_damage: int = ActorAccessScript.get_int_property(enemy, "attack_max", 4)
	if max_damage < min_damage:
		max_damage = min_damage

	return randi_range(min_damage, max_damage)


static func apply_damage_to_actor(actor, amount: int) -> void:
	if actor == null:
		return

	var damage: int = max(0, amount)
	if actor.has_method("take_damage"):
		actor.take_damage(damage)
		return

	var hp: int = ActorAccessScript.get_int_property(actor, "hp", 0)
	hp -= damage
	if hp < 0:
		hp = 0

	ActorAccessScript.set_property_if_available(actor, "hp", hp)


static func apply_heal_to_hero(hero, amount: int) -> void:
	if hero == null:
		return

	var heal_amount: int = max(0, amount)
	if hero.has_method("heal"):
		hero.heal(heal_amount)
		return

	var hp: int = ActorAccessScript.get_int_property(hero, "hp", 0)
	var max_hp: int = ActorAccessScript.get_int_property(hero, "max_hp", hp)
	hp += heal_amount
	if hp > max_hp:
		hp = max_hp

	ActorAccessScript.set_property_if_available(hero, "hp", hp)
