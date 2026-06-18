extends RefCounted

# ------------------------------------------------------------
# CRÉATION DES HÉROS
# Isole la création des CharacterData depuis la sélection courante
# de l'écran de création d'équipe.
# ------------------------------------------------------------

const CharacterDataScript = preload("res://scripts/characters/CharacterData.gd")


static func create_hero(selected_class_name: String, current_stats, hero_index: int):
	var hero = CharacterDataScript.new()
	hero.character_name = get_default_hero_name_for_class(selected_class_name, hero_index)
	hero.job = selected_class_name
	hero.level = 1

	if object_has_property(hero, "exp"):
		hero.exp = 0

	if current_stats != null:
		if current_stats.has_method("create_copy"):
			hero.stats = current_stats.create_copy()
		else:
			hero.stats = current_stats

	if hero.has_method("recalculate_derived_stats"):
		hero.recalculate_derived_stats()

	if object_has_property(hero, "max_hp"):
		hero.hp = hero.max_hp

	if object_has_property(hero, "max_mp"):
		hero.mp = hero.max_mp

	return hero


static func get_default_hero_name_for_class(job_name: String, hero_index: int) -> String:
	if job_name == "Guerrier":
		return "Ardan"
	if job_name == "Voleuse":
		return "Nyra"
	if job_name == "Mage":
		return "Mira"
	if job_name == "Prêtre":
		return "Eldric"
	if job_name == "Prêtresse":
		return "Eldric"
	return "Héros " + str(hero_index + 1)


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
