extends RefCounted
class_name MonsterDatabase

# ------------------------------------------------------------
# DÉPENDANCES
# Fournit les ressources nécessaires à la création des monstres.
# ------------------------------------------------------------

const MonsterDataScript = preload("res://scripts/monsters/MonsterData.gd")
const StatBlockScript = preload("res://scripts/core/StatBlock.gd")


# ------------------------------------------------------------
# ACCÈS AUX MONSTRES
# Retourne une nouvelle instance de monstre selon son identifiant.
# ------------------------------------------------------------

static func get_monster_data(monster_id: String):
	if monster_id == "zombie":
		return create_zombie()

	if monster_id == "chauve_souris":
		return create_bat()

	if monster_id == "gobelin":
		return create_goblin()

	if monster_id == "troll":
		return create_troll()

	if monster_id == "gardien":
		return create_guardian()

	return create_zombie()


static func get_random_encounter_monster(floor_id: int = 1):
	var encounter_table: Array = get_floor_encounter_table(floor_id)
	var monster_id: String = choose_monster_id_from_table(encounter_table)

	return get_monster_data(monster_id)


# ------------------------------------------------------------
# TABLES DE RENCONTRE
# Définit les monstres possibles par étage avec des poids de tirage.
# ------------------------------------------------------------

static func get_floor_encounter_table(floor_id: int) -> Array:
	if floor_id == 1:
		return [
			{ "monster_id": "zombie", "weight": 42 },
			{ "monster_id": "chauve_souris", "weight": 30 },
			{ "monster_id": "gobelin", "weight": 18 },
			{ "monster_id": "troll", "weight": 8 },
			{ "monster_id": "gardien", "weight": 2 }
		]

	if floor_id == 2:
		return [
			{ "monster_id": "zombie", "weight": 20 },
			{ "monster_id": "chauve_souris", "weight": 22 },
			{ "monster_id": "gobelin", "weight": 28 },
			{ "monster_id": "troll", "weight": 20 },
			{ "monster_id": "gardien", "weight": 10 }
		]

	return [
		{ "monster_id": "zombie", "weight": 100 }
	]


static func choose_monster_id_from_table(encounter_table: Array) -> String:
	var total_weight: int = 0

	for entry in encounter_table:
		if not (entry is Dictionary):
			continue

		var weight: int = int(entry.get("weight", 0))

		if weight > 0:
			total_weight += weight

	if total_weight <= 0:
		return "zombie"

	var roll: int = randi_range(1, total_weight)
	var current_weight: int = 0

	for entry in encounter_table:
		if not (entry is Dictionary):
			continue

		var monster_id: String = str(entry.get("monster_id", "zombie"))
		var weight: int = int(entry.get("weight", 0))

		if weight <= 0:
			continue

		current_weight += weight

		if roll <= current_weight:
			return monster_id

	return "zombie"


# ------------------------------------------------------------
# MONSTRES - ÉTAGE 1 / ÉTAGE 2 TEMPORAIRE
# Crée les ennemis disponibles actuellement.
# L'étage 2 réutilise ces monstres avec une table plus dangereuse.
# ------------------------------------------------------------

static func create_zombie():
	return create_monster(
		"zombie",
		"zombie",
		"Zombie",
		4,
		2,
		4,
		0,
		12,
		0,
		1,
		3,
		4,
		[
			create_loot_entry("rusty_sword", "Épée rouillée", 8),
			create_loot_entry("worn_tunic", "Tunique usée", 10),
			create_loot_entry("cracked_shield", "Bouclier fendu", 5)
		]
	)


static func create_bat():
	return create_monster(
		"chauve_souris",
		"chauve_souris",
		"Chauve-souris",
		2,
		9,
		2,
		0,
		8,
		0,
		1,
		4,
		5,
		[
			create_loot_entry("torn_cloak", "Cape déchirée", 8),
			create_loot_entry("fragile_dagger", "Dague fragile", 5),
			create_loot_entry("tarnished_ring", "Anneau terni", 3)
		]
	)


static func create_goblin():
	return create_monster(
		"gobelin",
		"gobelin",
		"Gobelin",
		5,
		6,
		4,
		0,
		16,
		0,
		2,
		5,
		9,
		[
			create_loot_entry("goblin_dagger", "Dague gobeline", 10),
			create_loot_entry("short_bow", "Arc court", 6),
			create_loot_entry("leather_vest", "Gilet de cuir", 8),
			create_loot_entry("small_shield", "Petit bouclier", 6)
		]
	)


static func create_troll():
	return create_monster(
		"troll",
		"troll",
		"Troll",
		8,
		3,
		8,
		0,
		34,
		0,
		4,
		8,
		20,
		[
			create_loot_entry("heavy_club", "Masse lourde", 12),
			create_loot_entry("reinforced_leather", "Cuir renforcé", 7),
			create_loot_entry("chipped_axe", "Hache ébréchée", 5),
			create_loot_entry("thick_boots", "Bottes épaisses", 8),
			create_loot_entry("trollhide_vest", "Gilet de peau de troll", 2)
		]
	)


static func create_guardian():
	return create_monster(
		"gardien",
		"gardien",
		"Gardien",
		9,
		5,
		9,
		1,
		45,
		0,
		5,
		10,
		35,
		[
			create_loot_entry("ancient_blade", "Lame ancienne", 8),
			create_loot_entry("guardian_mail", "Cotte gardienne", 6),
			create_loot_entry("stone_amulet", "Amulette de pierre", 5),
			create_loot_entry("ancient_shield", "Bouclier ancien", 4),
			create_loot_entry("guardian_relic", "Relique de gardien", 2)
		]
	)


# ------------------------------------------------------------
# CONSTRUCTION DE MONSTRE
# Centralise la création des monstres pour garder les fiches lisibles.
# ------------------------------------------------------------

static func create_monster(
	monster_id: String,
	visual_id: String,
	monster_name: String,
	strength: int,
	agility: int,
	endurance: int,
	magic_power: int,
	max_hp: int,
	max_mp: int,
	attack_min: int,
	attack_max: int,
	exp_reward: int,
	loot_table: Array
):
	var enemy = MonsterDataScript.new()

	set_property_if_available(enemy, "monster_id", monster_id)
	set_property_if_available(enemy, "visual_id", visual_id)
	set_property_if_available(enemy, "monster_name", monster_name)
	set_property_if_available(
		enemy,
		"stats",
		StatBlockScript.new(
			strength,
			agility,
			endurance,
			magic_power
		)
	)
	set_property_if_available(enemy, "max_hp", max_hp)
	set_property_if_available(enemy, "hp", max_hp)
	set_property_if_available(enemy, "max_mp", max_mp)
	set_property_if_available(enemy, "mp", max_mp)
	set_property_if_available(enemy, "attack_min", attack_min)
	set_property_if_available(enemy, "attack_max", attack_max)
	set_property_if_available(enemy, "exp_reward", exp_reward)
	set_property_if_available(enemy, "loot_table", loot_table.duplicate(true))

	return enemy


static func create_loot_entry(
	item_id: String,
	display_name: String,
	chance: float,
	min_quantity: int = 1,
	max_quantity: int = 1
) -> Dictionary:
	return {
		"item_id": item_id,
		"display_name": display_name,
		"chance": chance,
		"min_quantity": min_quantity,
		"max_quantity": max_quantity
	}


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Permet de rester compatible avec l’évolution progressive de MonsterData.
# ------------------------------------------------------------

static func set_property_if_available(target, property_name: String, value) -> void:
	if target == null:
		return

	if not object_has_property(target, property_name):
		return

	target.set(property_name, value)


static func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
