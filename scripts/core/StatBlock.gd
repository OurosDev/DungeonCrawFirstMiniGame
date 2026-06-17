extends Resource

var strength: int = 1
var agility: int = 1
var endurance: int = 1
var magic_power: int = 1


func _init(
	p_strength: int = 1,
	p_agility: int = 1,
	p_endurance: int = 1,
	p_magic_power: int = 1
) -> void:
	strength = p_strength
	agility = p_agility
	endurance = p_endurance
	magic_power = p_magic_power


func get_strength_modifier() -> int:
	var modifier: int = 0

	if strength >= 6:
		modifier = 1

	if strength >= 8:
		modifier = 2

	if strength >= 10:
		modifier = 3

	if strength >= 12:
		modifier = 4

	return modifier


func get_magic_modifier() -> int:
	var modifier: int = 0

	if magic_power >= 3:
		modifier = 1

	if magic_power >= 6:
		modifier = 2

	if magic_power >= 9:
		modifier = 3

	if magic_power >= 12:
		modifier = 4

	return modifier

func create_copy():
	var copied_stats = get_script().new(
		strength,
		agility,
		endurance,
		magic_power
	)

	return copied_stats
