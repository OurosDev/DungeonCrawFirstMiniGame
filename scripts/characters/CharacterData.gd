extends Resource

# ------------------------------------------------------------
# DÉPENDANCES
# Charge les bases nécessaires aux classes, sorts et équipements.
# ------------------------------------------------------------

const StatBlockScript = preload("res://scripts/core/StatBlock.gd")
const ClassDatabaseScript = preload("res://scripts/characters/ClassDatabase.gd")
const AbilityDatabaseScript = preload("res://scripts/abilities/AbilityDatabase.gd")
const EquipmentRulesScript = preload("res://scripts/equipment/EquipmentRules.gd")


# ------------------------------------------------------------
# DONNÉES PRINCIPALES
# Décrit l'identité, la progression et les ressources du héros.
# ------------------------------------------------------------

var character_name: String = ""
var job: String = ""

var level: int = 1
var exp: int = 0
var exp_to_next: int = 20

var base_stats = null
var stats = null

var hp: int = 1
var max_hp: int = 1
var mp: int = 0
var max_mp: int = 0

var equipped_items: Dictionary = {}
var equipment_bonuses: Dictionary = {}


# ------------------------------------------------------------
# INITIALISATION
# Crée un héros et prépare ses statistiques de base et effectives.
# ------------------------------------------------------------

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
	base_stats = StatBlockScript.new(
		p_strength,
		p_agility,
		p_endurance,
		p_magic_power
	)
	stats = base_stats.create_copy()
	equipped_items = EquipmentRulesScript.create_empty_equipment()
	equipment_bonuses = create_empty_bonus_dictionary()
	recalculate_equipment_stats()
	recalculate_derived_stats(true)


# ------------------------------------------------------------
# CLASSE
# Fournit les données de classe et les capacités disponibles.
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
# STATISTIQUES ET ÉQUIPEMENT
# Calcule les statistiques finales depuis les stats de base et les bonus équipés.
# ------------------------------------------------------------

func ensure_stat_blocks() -> void:
	if base_stats == null:
		if stats != null:
			base_stats = stats.create_copy()
		else:
			base_stats = StatBlockScript.new()

	if stats == null:
		stats = base_stats.create_copy()

	import_manually_assigned_stats_if_needed()


# Corrige le cas où un ancien écran crée un héros en assignant seulement "stats".
# Depuis l'ajout de l'équipement, "base_stats" doit contenir le roll permanent,
# et "stats" doit rester la valeur finale calculée avec les bonus équipés.
func import_manually_assigned_stats_if_needed() -> void:
	if base_stats == null or stats == null:
		return

	if not is_default_stat_block(base_stats):
		return

	if is_default_stat_block(stats):
		return

	if has_any_equipped_item():
		return

	base_stats = stats.create_copy()


func is_default_stat_block(stat_block) -> bool:
	if stat_block == null:
		return true

	return (
		int(stat_block.strength) == 1
		and int(stat_block.agility) == 1
		and int(stat_block.endurance) == 1
		and int(stat_block.magic_power) == 1
	)


func has_any_equipped_item() -> bool:
	if equipped_items == null or not (equipped_items is Dictionary):
		return false

	for slot_id in equipped_items.keys():
		if str(equipped_items.get(slot_id, "")) != "":
			return true

	return false


func ensure_equipment() -> void:
	if equipped_items == null or not (equipped_items is Dictionary):
		equipped_items = EquipmentRulesScript.create_empty_equipment()

	for slot_id in EquipmentRulesScript.get_slot_order():
		if not equipped_items.has(slot_id):
			equipped_items[slot_id] = ""

	if equipment_bonuses == null or not (equipment_bonuses is Dictionary):
		equipment_bonuses = create_empty_bonus_dictionary()


func recalculate_equipment_stats() -> void:
	ensure_stat_blocks()
	ensure_equipment()

	equipment_bonuses = EquipmentRulesScript.get_total_stat_bonuses(equipped_items)

	stats.strength = int(base_stats.strength) + int(equipment_bonuses.get("strength", 0))
	stats.agility = int(base_stats.agility) + int(equipment_bonuses.get("agility", 0))
	stats.endurance = int(base_stats.endurance) + int(equipment_bonuses.get("endurance", 0))
	stats.magic_power = int(base_stats.magic_power) + int(equipment_bonuses.get("magic_power", 0))


func get_base_stat_value(stat_name: String) -> int:
	ensure_stat_blocks()

	if stat_name == "strength":
		return int(base_stats.strength)

	if stat_name == "agility":
		return int(base_stats.agility)

	if stat_name == "endurance":
		return int(base_stats.endurance)

	if stat_name == "magic_power" or stat_name == "magic":
		return int(base_stats.magic_power)

	return 0


func get_equipment_bonus_value(stat_name: String) -> int:
	recalculate_equipment_stats()

	if stat_name == "magic":
		stat_name = "magic_power"

	return int(equipment_bonuses.get(stat_name, 0))


func get_effective_stat_value(stat_name: String) -> int:
	recalculate_equipment_stats()

	if stat_name == "strength":
		return int(stats.strength)

	if stat_name == "agility":
		return int(stats.agility)

	if stat_name == "endurance":
		return int(stats.endurance)

	if stat_name == "magic_power" or stat_name == "magic":
		return int(stats.magic_power)

	return 0


func create_empty_bonus_dictionary() -> Dictionary:
	return {
		"strength": 0,
		"agility": 0,
		"endurance": 0,
		"magic_power": 0
	}


# ------------------------------------------------------------
# ÉQUIPEMENT
# Lit et modifie les objets équipés par slot.
# ------------------------------------------------------------

func get_equipped_item(slot_id: String) -> String:
	ensure_equipment()
	return str(equipped_items.get(slot_id, ""))


func set_equipped_item(slot_id: String, item_id: String) -> void:
	ensure_equipment()

	if not EquipmentRulesScript.is_valid_slot(slot_id):
		return

	equipped_items[slot_id] = item_id.strip_edges().to_lower()
	recalculate_equipment_stats()
	recalculate_derived_stats(false)


func clear_equipped_item(slot_id: String) -> void:
	set_equipped_item(slot_id, "")


func get_equipment_save_data() -> Dictionary:
	ensure_equipment()

	var save_data: Dictionary = {}

	for slot_id in EquipmentRulesScript.get_slot_order():
		var item_id: String = str(equipped_items.get(slot_id, ""))

		if item_id == "":
			continue

		save_data[slot_id] = item_id

	return save_data


func load_equipment_save_data(save_data) -> void:
	equipped_items = EquipmentRulesScript.create_empty_equipment()

	if save_data is Dictionary:
		for slot_id in EquipmentRulesScript.get_slot_order():
			equipped_items[slot_id] = str(save_data.get(slot_id, ""))

	recalculate_equipment_stats()
	recalculate_derived_stats(false)


# ------------------------------------------------------------
# CALCULS DÉRIVÉS
# Calcule les HP/MP depuis les statistiques finales.
# ------------------------------------------------------------

func recalculate_derived_stats(full_restore: bool = false) -> void:
	recalculate_equipment_stats()

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

		if mp < 0:
			mp = 0

		if hp < 0:
			hp = 0


# ------------------------------------------------------------
# ÉTAT DU HÉROS
# Gère les HP courants du héros.
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
# Calcule les dégâts et les commandes à partir des statistiques finales.
# ------------------------------------------------------------

func roll_attack_damage() -> int:
	recalculate_equipment_stats()

	var base_damage: int = randi_range(1, 4)
	var strength_bonus: int = stats.get_strength_modifier()
	var class_data = get_class_data()

	return base_damage + strength_bonus + class_data.physical_bonus


func roll_spell_damage(base_min: int, base_max: int) -> int:
	recalculate_equipment_stats()

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
# Fait évoluer les statistiques de base, puis recalcule les stats finales.
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
	ensure_stat_blocks()

	if job == "Guerrier":
		base_stats.strength += 1
		base_stats.endurance += 1
	elif job == "Voleuse":
		base_stats.agility += 1

		if randi_range(1, 2) == 1:
			base_stats.strength += 1
		else:
			base_stats.endurance += 1
	elif job == "Mage":
		base_stats.magic_power += 1

		if randi_range(1, 2) == 1:
			base_stats.agility += 1
		else:
			base_stats.endurance += 1
	elif job == "Prêtresse":
		base_stats.magic_power += 1
		base_stats.endurance += 1
	else:
		base_stats.endurance += 1

	recalculate_equipment_stats()
