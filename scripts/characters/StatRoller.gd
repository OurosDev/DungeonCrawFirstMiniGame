extends RefCounted

# ------------------------------------------------------------
# RÔLE DE CE SCRIPT
# ------------------------------------------------------------
#
# StatRoller génère une répartition aléatoire de caractéristiques.
#
# Il respecte :
# - un total de points
# - une valeur minimum par caractéristique
# - une valeur maximum par caractéristique
#
# Il servira plus tard à l'écran de création d'équipe.


const StatBlockScript = preload("res://scripts/core/StatBlock.gd")


# Génère un nouveau StatBlock.
func roll_stats(
	total_points: int = 24,
	min_value: int = 2,
	max_value: int = 10
):
	var stat_count: int = 4

	var minimum_total: int = min_value * stat_count
	var maximum_total: int = max_value * stat_count

	# Sécurité : on force le total à rester possible.
	if total_points < minimum_total:
		total_points = minimum_total

	if total_points > maximum_total:
		total_points = maximum_total

	# On commence avec le minimum partout.
	var strength: int = min_value
	var agility: int = min_value
	var endurance: int = min_value
	var magic_power: int = min_value

	var remaining_points: int = total_points - minimum_total

	# On distribue les points restants au hasard.
	while remaining_points > 0:
		var stat_index: int = randi_range(0, 3)

		if stat_index == 0 and strength < max_value:
			strength += 1
			remaining_points -= 1

		elif stat_index == 1 and agility < max_value:
			agility += 1
			remaining_points -= 1

		elif stat_index == 2 and endurance < max_value:
			endurance += 1
			remaining_points -= 1

		elif stat_index == 3 and magic_power < max_value:
			magic_power += 1
			remaining_points -= 1

	return StatBlockScript.new(
		strength,
		agility,
		endurance,
		magic_power
	)


# Transforme un roll en texte lisible.
func get_roll_text(stats) -> String:
	var text: String = ""

	text += "FOR "
	text += str(stats.strength)
	text += "  AGI "
	text += str(stats.agility)
	text += "  END "
	text += str(stats.endurance)
	text += "  MAG "
	text += str(stats.magic_power)

	text += "  TOTAL "
	text += str(get_total(stats))

	return text


# Calcule le total des caractéristiques.
func get_total(stats) -> int:
	return stats.strength + stats.agility + stats.endurance + stats.magic_power
