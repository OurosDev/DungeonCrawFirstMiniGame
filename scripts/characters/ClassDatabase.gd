extends RefCounted
class_name ClassDatabase

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

# ------------------------------------------------------------
# CONSTANTES
# Définit les noms canoniques des classes.
# ------------------------------------------------------------

const JOB_WARRIOR: String = "Guerrier"
const JOB_THIEF: String = "Voleuse"
const JOB_MAGE: String = "Mage"
const JOB_CLERIC: String = "Prêtre"


# ------------------------------------------------------------
# LISTE DES CLASSES
# Expose uniquement les noms corrigés/canoniques.
# ------------------------------------------------------------

static func get_available_class_names() -> Array[String]:
	return [
		JOB_WARRIOR,
		JOB_THIEF,
		JOB_MAGE,
		JOB_CLERIC
	]


# ------------------------------------------------------------
# NORMALISATION
# Corrige les anciens libellés sauvegardés ou assignés avant le hotfix.
# ------------------------------------------------------------

static func normalize_class_name(job_name: String) -> String:
	var normalized_name: String = job_name.strip_edges()

	if normalized_name.begins_with("Prêtr"):
		return JOB_CLERIC

	return normalized_name


# ------------------------------------------------------------
# DONNÉES DE CLASSE
# Retourne les caractéristiques associées à chaque classe.
# ------------------------------------------------------------

static func get_class_data(job_name: String):
	var normalized_name: String = normalize_class_name(job_name)

	if normalized_name == JOB_WARRIOR:
		return ClassDataScript.new(
			JOB_WARRIOR,
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

	if normalized_name == JOB_THIEF:
		return ClassDataScript.new(
			JOB_THIEF,
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

	if normalized_name == JOB_MAGE:
		return ClassDataScript.new(
			JOB_MAGE,
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

	if normalized_name == JOB_CLERIC:
		return ClassDataScript.new(
			JOB_CLERIC,
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
		normalized_name,
		normalized_name,
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
