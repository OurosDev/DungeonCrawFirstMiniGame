extends Resource

# ------------------------------------------------------------
# DÉPENDANCES
# Utilise StatBlock pour stocker les statistiques du monstre.
# ------------------------------------------------------------

const StatBlockScript = preload("res://scripts/core/StatBlock.gd")


# ------------------------------------------------------------
# IDENTITÉ
# Définit les informations principales du monstre.
# ------------------------------------------------------------

var monster_id: String = ""
var monster_name: String = ""
var visual_id: String = ""


# ------------------------------------------------------------
# STATISTIQUES
# Stocke les statistiques et les ressources de combat du monstre.
# ------------------------------------------------------------

var stats = null

var hp: int = 1
var max_hp: int = 1

var mp: int = 0
var max_mp: int = 0

var attack_min: int = 1
var attack_max: int = 4

var exp_reward: int = 1


# ------------------------------------------------------------
# BUTIN
# Prépare les futurs drops sans forcer l’inventaire maintenant.
# ------------------------------------------------------------

var loot_table: Array = []


# ------------------------------------------------------------
# INITIALISATION
# Crée un monstre avec des valeurs de base utilisables.
# ------------------------------------------------------------

func _init(
	p_monster_name: String = "",
	p_strength: int = 1,
	p_agility: int = 1,
	p_endurance: int = 1,
	p_magic_power: int = 0,
	p_exp_reward: int = 1
) -> void:
	monster_name = p_monster_name

	stats = StatBlockScript.new(
		p_strength,
		p_agility,
		p_endurance,
		p_magic_power
	)

	exp_reward = p_exp_reward

	recalculate_derived_stats(true)


# ------------------------------------------------------------
# STATS DÉRIVÉES
# Recalcule les HP/MP à partir des statistiques.
# ------------------------------------------------------------

func recalculate_derived_stats(full_restore: bool = false) -> void:
	if stats == null:
		stats = StatBlockScript.new()

	max_hp = 50 + stats.endurance * 3

	if stats.magic_power > 0:
		max_mp = stats.magic_power * 2
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
# ÉTAT DE COMBAT
# Vérifie et modifie l’état vital du monstre.
# ------------------------------------------------------------

func is_alive() -> bool:
	return hp > 0


func take_damage(amount: int) -> void:
	hp -= max(0, amount)

	if hp < 0:
		hp = 0


# ------------------------------------------------------------
# DÉGÂTS
# Calcule les dégâts physiques et magiques du monstre.
# ------------------------------------------------------------

func roll_attack_damage() -> int:
	if attack_max < attack_min:
		attack_max = attack_min

	return randi_range(attack_min, attack_max)


func roll_spell_damage(base_min: int, base_max: int) -> int:
	if base_max < base_min:
		base_max = base_min

	var base_damage: int = randi_range(base_min, base_max)
	var magic_bonus: int = 0

	if stats != null:
		magic_bonus = stats.get_magic_modifier()

	return base_damage + magic_bonus


# ------------------------------------------------------------
# COPIE DE COMBAT
# Crée une vraie copie contrôlée, plutôt qu’un duplicate générique.
# ------------------------------------------------------------

func create_battle_copy():
	var copied_monster = get_script().new()

	copied_monster.monster_id = monster_id
	copied_monster.monster_name = monster_name
	copied_monster.visual_id = visual_id

	if stats != null:
		copied_monster.stats = stats.create_copy()
	else:
		copied_monster.stats = StatBlockScript.new()

	copied_monster.max_hp = max_hp
	copied_monster.hp = hp

	copied_monster.max_mp = max_mp
	copied_monster.mp = mp

	copied_monster.attack_min = attack_min
	copied_monster.attack_max = attack_max

	copied_monster.exp_reward = exp_reward

	copied_monster.loot_table = loot_table.duplicate(true)

	return copied_monster
