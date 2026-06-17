extends Resource

const StatBlockScript = preload("res://scripts/core/StatBlock.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")

var character_name: String = ""
var job: String = ""

var level: int = 1
var exp: int = 0
var exp_to_next: int = 20

var stats = null

var hp: int = 1
var max_hp: int = 1

var mp: int = 0
var max_mp: int = 0


func _init(
	p_character_name: String = "",
	p_job: String = "",
	p_strength: int = 1,
	p_agility: int = 1,
	p_endurance: int = 1,
	p_magic_power: int = 1
) -> void:
	character_name = p_character_name
	job = p_job

	stats = StatBlockScript.new(
		p_strength,
		p_agility,
		p_endurance,
		p_magic_power
	)

	recalculate_derived_stats(true)


# ------------------------------------------------------------
# CLASSE
# ------------------------------------------------------------

func get_class_data():
	return ClassDatabaseScript.get_class_data(job)

func get_possible_ability_ids() -> Array[String]:
	var class_data = get_class_data()
	return class_data.ability_ids


func get_available_ability_ids(discovered_ability_ids: Array[String]) -> Array[String]:
	return AbilityDatabaseScript.get_available_ability_ids(
		get_possible_ability_ids(),
		self,
		discovered_ability_ids
	)


func get_first_available_ability_id_by_kind(
	ability_kind: String,
	discovered_ability_ids: Array[String]
) -> String:
	return AbilityDatabaseScript.get_first_available_ability_id_by_kind(
		get_possible_ability_ids(),
		self,
		discovered_ability_ids,
		ability_kind
	)
# ------------------------------------------------------------
# CALCULS DÉRIVÉS
# ------------------------------------------------------------

func recalculate_derived_stats(full_restore: bool = false) -> void:
	var class_data = get_class_data()

	max_hp = class_data.base_hp + stats.endurance * 3 + (level - 1) * 2

	if class_data.uses_magic_resource:
		max_mp = class_data.base_mp + stats.magic_power * 3 + (level - 1)
	else:
		max_mp = 0

	if full_restore:
		hp = max_hp
		mp = max_mp
	else:
		if hp > max_hp:
			hp = max_hp

		if mp > max_mp:
			mp = max_mp


# ------------------------------------------------------------
# ÉTAT DU HÉROS
# ------------------------------------------------------------

func is_alive() -> bool:
	return hp > 0


func take_damage(amount: int) -> void:
	hp -= amount

	if hp < 0:
		hp = 0


func heal(amount: int) -> void:
	hp += amount

	if hp > max_hp:
		hp = max_hp


# ------------------------------------------------------------
# COMBAT
# ------------------------------------------------------------

func roll_attack_damage() -> int:
	var base_damage: int = randi_range(1, 4)
	var strength_bonus: int = stats.get_strength_modifier()
	var class_data = get_class_data()

	return base_damage + strength_bonus + class_data.physical_bonus


func roll_spell_damage(base_min: int, base_max: int) -> int:
	var base_damage: int = randi_range(base_min, base_max)
	var magic_bonus: int = stats.get_magic_modifier()

	return base_damage + magic_bonus


func can_spend_mp(amount: int) -> bool:
	return mp >= amount


func spend_mp(amount: int) -> bool:
	if mp < amount:
		return false

	mp -= amount
	return true


func get_combat_commands() -> Array[String]:
	var class_data = get_class_data()
	return class_data.commands


# ------------------------------------------------------------
# EXPÉRIENCE ET NIVEAUX
# ------------------------------------------------------------

func gain_exp(amount: int) -> String:
	exp += amount

	var message: String = character_name + " gagne " + str(amount) + " EXP."

	while exp >= exp_to_next:
		exp -= exp_to_next
		message += "\n" + level_up()

	return message


func level_up() -> String:
	level += 1

	apply_level_growth()
	recalculate_derived_stats(true)

	exp_to_next = int(float(exp_to_next) * 1.4)

	return character_name + " atteint le niveau " + str(level) + " !"


func apply_level_growth() -> void:
	if job == "Guerrier":
		stats.strength += 1
		stats.endurance += 1

	elif job == "Voleuse":
		stats.agility += 1

		if randi_range(1, 2) == 1:
			stats.strength += 1
		else:
			stats.endurance += 1

	elif job == "Mage":
		stats.magic_power += 1

		if randi_range(1, 2) == 1:
			stats.agility += 1
		else:
			stats.endurance += 1

	elif job == "Prêtresse":
		stats.magic_power += 1
		stats.endurance += 1

	else:
		stats.endurance += 1
