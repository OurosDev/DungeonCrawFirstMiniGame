extends RefCounted

# ------------------------------------------------------------
# RÉSUMÉ DE L'ÉQUIPE
# Assemble les textes de progression affichés pendant la création
# de l'équipe.
# ------------------------------------------------------------

static func build_party_summary(created_party: Array) -> String:
	var text: String = "Équipe : "

	if created_party.is_empty():
		text += "aucun héros validé"
		return text

	for i in range(created_party.size()):
		if i > 0:
			text += " | "

		var hero = created_party[i]
		text += str(hero.character_name) + " - " + str(hero.job)

	return text
