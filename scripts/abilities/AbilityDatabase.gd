extends RefCounted

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13-Magicka
# ------------------------------------------------------------


const AbilityDataScript = preload("res://scripts/abilities/AbilityData.gd")


# ------------------------------------------------------------
# SORTS / CAPACITÉS
# Centralise les données d'équilibrage des capacités.
# ------------------------------------------------------------

static func get_ability_data(ability_id: String):
	if ability_id == "spark":
		return AbilityDataScript.new(
			"spark",
			"Étincelle",
			"damage",
			"enemy",
			6,
			8,
			16,
			true,
			1,
			false,
			"",
			"Un petit sort offensif qui inflige des dégâts magiques à un ennemi."
		)

	if ability_id == "ice_shard":
		return AbilityDataScript.new(
			"ice_shard",
			"Éclat de givre",
			"damage",
			"enemy",
			10,
			12,
			24,
			true,
			2,
			true,
			"spell_ice_shard",
			"Un sort de glace découvert dans le donjon. Plus coûteux qu'Étincelle, mais nettement plus puissant."
		)

	if ability_id == "poison":
		return AbilityDataScript.new(
			"poison",
			"Poison",
			"damage",
			"enemy_poison",
			10,
			5,
			10,
			false,
			5,
			false,
			"",
			"Empoisonne un ennemi. Le poison inflige 5 à 10 % des PV max du monstre à la fin de son tour."
		)

	if ability_id == "flame":
		return AbilityDataScript.new(
			"flame",
			"Flamme",
			"damage",
			"enemy",
			6,
			14,
			24,
			true,
			3,
			true,
			"spell_flame",
			"Un sort de feu plus puissant. Il doit être découvert dans le labyrinthe."
		)

	if ability_id == "poison_cloud":
		return AbilityDataScript.new(
			"poison_cloud",
			"Nuage toxique",
			"damage",
			"enemy",
			8,
			12,
			28,
			true,
			5,
			true,
			"spell_poison_cloud",
			"Un sort dangereux découvert dans une salle secrète."
		)

	if ability_id == "light_heal":
		return AbilityDataScript.new(
			"light_heal",
			"Soin léger",
			"heal",
			"ally",
			4,
			8,
			14,
			true,
			1,
			false,
			"",
			"Un sort de soin simple qui rend des HP à un allié blessé."
		)

	if ability_id == "greater_heal":
		return AbilityDataScript.new(
			"greater_heal",
			"Soin renforcé",
			"heal",
			"ally",
			9,
			16,
			28,
			true,
			5,
			false,
			"",
			"Un soin avancé appris par les prêtres expérimentés. Il soigne le double du soin léger."
		)

	if ability_id == "group_heal":
		return AbilityDataScript.new(
			"group_heal",
			"Soin de groupe",
			"heal",
			"all_allies",
			9,
			7,
			13,
			true,
			1,
			true,
			"spell_group_heal",
			"Une ancienne prière qui soigne toute l'équipe, mais moins fortement qu'un soin ciblé."
		)

	if ability_id == "holy_light":
		return AbilityDataScript.new(
			"holy_light",
			"Lumière sacrée",
			"damage",
			"enemy",
			7,
			12,
			26,
			true,
			4,
			true,
			"spell_holy_light",
			"Un sort sacré offensif réservé aux prêtres expérimentés."
		)

	return AbilityDataScript.new()


# ------------------------------------------------------------
# DISPONIBILITÉ
# Vérifie les prérequis de niveau et de découverte.
# ------------------------------------------------------------

static func is_ability_available_for_hero(
	ability_id: String,
	hero,
	discovered_ability_ids: Array[String]
) -> bool:
	var ability = get_ability_data(ability_id)

	if ability.ability_id == "":
		return false

	if hero.level < ability.required_level:
		return false

	if ability.requires_discovery:
		if not discovered_ability_ids.has(ability.discovery_id):
			return false

	return true


static func get_available_ability_ids(
	possible_ability_ids: Array[String],
	hero,
	discovered_ability_ids: Array[String]
) -> Array[String]:
	var result: Array[String] = []

	for ability_id in possible_ability_ids:
		if is_ability_available_for_hero(
			ability_id,
			hero,
			discovered_ability_ids
		):
			result.append(ability_id)

	return result


static func get_first_available_ability_id_by_kind(
	possible_ability_ids: Array[String],
	hero,
	discovered_ability_ids: Array[String],
	ability_kind: String
) -> String:
	var available_ids: Array[String] = get_available_ability_ids(
		possible_ability_ids,
		hero,
		discovered_ability_ids
	)

	for ability_id in available_ids:
		var ability = get_ability_data(ability_id)

		if ability.ability_kind == ability_kind:
			return ability_id

	return ""
