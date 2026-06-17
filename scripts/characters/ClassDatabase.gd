extends RefCounted

# ------------------------------------------------------------
# ClassDatabase
# ------------------------------------------------------------
#
# Centralise toutes les classes disponibles.
#
# Chaque classe peut maintenant avoir :
# - des commandes
# - une liste de sorts/compétences potentiels
#
# Attention :
# un sort listé ici n'est pas forcément utilisable immédiatement.
# Il peut encore demander :
# - un niveau minimum
# - une découverte dans le labyrinthe


const ClassDataScript = preload("res://scripts/characters/ClassData.gd")


static func get_available_class_names() -> Array[String]:
	return [
		"Guerrier",
		"Voleuse",
		"Mage",
		"Prêtresse"
	]


static func get_class_data(job_name: String):
	if job_name == "Guerrier":
		return ClassDataScript.new(
			"Guerrier",
			"GUE",
			14,
			0,
			2,
			false,
			["Attaquer", "Fuir"],
			[],
			["épée", "hache", "lance", "dague"],
			["lourde", "moyenne", "légère"],
			"Avantages : HP élevés, bons dégâts physiques, bon équipement.\nInconvénients : pas de magie."
		)

	if job_name == "Voleuse":
		return ClassDataScript.new(
			"Voleuse",
			"VOL",
			10,
			0,
			1,
			false,
			["Attaquer", "Fuir"],
			[],
			["dague", "arc", "épée courte"],
			["légère"],
			"Avantages : bonne Agilité, utile plus tard pour pièges et coffres.\nInconvénients : moins résistante qu'un Guerrier."
		)

	if job_name == "Mage":
		return ClassDataScript.new(
			"Mage",
			"MAG",
			6,
			8,
			0,
			true,
			["Attaquer", "Magie", "Fuir"],
			["spark", "ice_shard", "flame", "poison_cloud"],
			["bâton", "dague"],
			["robe"],
			"Avantages : magie offensive, beaucoup de MP si MAG élevée.\nInconvénients : HP faibles, équipement limité."
		)

	if job_name == "Prêtresse":
		return ClassDataScript.new(
			"Prêtresse",
			"PRE",
			9,
			6,
			0,
			true,
			["Attaquer", "Soin", "Fuir"],
			["light_heal", "greater_heal", "holy_light"],
			["masse", "bâton"],
			["robe", "moyenne"],
			"Avantages : soins, bonne survie, magie utile.\nInconvénients : dégâts physiques moyens."
		)

	return ClassDataScript.new(
		job_name,
		job_name,
		8,
		0,
		0,
		false,
		["Attaquer", "Fuir"],
		[],
		[],
		[],
		"Aucune description disponible."
	)


static func get_class_description(job_name: String) -> String:
	var class_data = get_class_data(job_name)
	return class_data.description


static func get_short_name(job_name: String) -> String:
	var class_data = get_class_data(job_name)
	return class_data.short_name
