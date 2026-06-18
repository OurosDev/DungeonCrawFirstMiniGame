extends RefCounted
class_name CombatLogHelper

# ------------------------------------------------------------
# JOURNAL DE COMBAT
# Centralise l'assemblage et la relecture des lignes de log.
# ------------------------------------------------------------

static func join_log(log_parts: Array[String]) -> String:
	var text: String = ""
	for i in range(log_parts.size()):
		if i > 0:
			text += "\n"
		text += log_parts[i]
	return text


static func split_log_lines(battle_log: String) -> Array[String]:
	var lines: Array[String] = []
	if battle_log == "":
		return lines

	var raw_lines = battle_log.split("\n", false)
	for raw_line in raw_lines:
		lines.append(str(raw_line))

	return lines
