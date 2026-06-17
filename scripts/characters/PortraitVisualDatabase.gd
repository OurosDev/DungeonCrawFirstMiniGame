extends RefCounted
class_name PortraitVisualDatabase

const PortraitVisualDataScript = preload("res://scripts/characters/PortraitVisualData.gd")

# Guerrier
const WARRIOR_IDLE_01 = preload("res://assets/warrior/warrior_idle_01.png")
const WARRIOR_IDLE_02 = preload("res://assets/warrior/warrior_idle_02.png")
const WARRIOR_DAMAGE = preload("res://assets/warrior/warrior_damage.png")

# Mage
const MAGE_IDLE_01 = preload("res://assets/mage/mage_idle_01.png")
const MAGE_IDLE_02 = preload("res://assets/mage/mage_idle_02.png")
const MAGE_DAMAGE = preload("res://assets/mage/mage_damage.png")

# Voleur / Voleuse
const THIEF_IDLE_01 = preload("res://assets/thief/thief_idle_01.png")
const THIEF_IDLE_02 = preload("res://assets/thief/thief_idle_02.png")
const THIEF_DAMAGE = preload("res://assets/thief/thief_damage.png")

# Prêtre / Cleric
const CLERIC_IDLE_01 = preload("res://assets/cleric/cleric_idle_01.png")
const CLERIC_IDLE_02 = preload("res://assets/cleric/cleric_idle_02.png")
const CLERIC_DAMAGE = preload("res://assets/cleric/cleric_damage.png")


static func get_portrait_for_class(job_name: String):
	var normalized_job: String = normalize_job_name(job_name)

	if normalized_job == "guerrier" or normalized_job == "warrior":
		return get_warrior_portrait()

	if normalized_job == "mage" or normalized_job == "magicien" or normalized_job == "magicienne":
		return get_mage_portrait()

	if normalized_job == "voleur" or normalized_job == "voleuse" or normalized_job == "thief" or normalized_job == "rogue":
		return get_thief_portrait()

	if normalized_job == "pretre" or normalized_job == "pretresse" or normalized_job == "clerc" or normalized_job == "cleric" or normalized_job == "priest" or normalized_job == "priestess":
		return get_cleric_portrait()

	return get_warrior_portrait()


static func normalize_job_name(job_name: String) -> String:
	var text: String = job_name.strip_edges().to_lower()

	text = text.replace("é", "e")
	text = text.replace("è", "e")
	text = text.replace("ê", "e")
	text = text.replace("ë", "e")
	text = text.replace("à", "a")
	text = text.replace("â", "a")
	text = text.replace("ù", "u")
	text = text.replace("û", "u")
	text = text.replace("î", "i")
	text = text.replace("ï", "i")
	text = text.replace("ô", "o")
	text = text.replace("ö", "o")
	text = text.replace("ç", "c")

	return text


static func get_warrior_portrait():
	return PortraitVisualDataScript.new(
		[
			WARRIOR_IDLE_01,
			WARRIOR_IDLE_02
		],
		WARRIOR_DAMAGE
	)


static func get_mage_portrait():
	return PortraitVisualDataScript.new(
		[
			MAGE_IDLE_01,
			MAGE_IDLE_02
		],
		MAGE_DAMAGE
	)


static func get_thief_portrait():
	return PortraitVisualDataScript.new(
		[
			THIEF_IDLE_01,
			THIEF_IDLE_02
		],
		THIEF_DAMAGE
	)


static func get_cleric_portrait():
	return PortraitVisualDataScript.new(
		[
			CLERIC_IDLE_01,
			CLERIC_IDLE_02
		],
		CLERIC_DAMAGE
	)
