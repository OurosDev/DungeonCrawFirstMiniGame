extends Resource

var ability_id: String = ""
var display_name: String = ""

var ability_kind: String = ""
var target_kind: String = ""

var mp_cost: int = 0

var power_min: int = 0
var power_max: int = 0

var uses_magic_modifier: bool = true

var required_level: int = 1

var requires_discovery: bool = false
var discovery_id: String = ""

var description: String = ""


func _init(
	p_ability_id: String = "",
	p_display_name: String = "",
	p_ability_kind: String = "",
	p_target_kind: String = "",
	p_mp_cost: int = 0,
	p_power_min: int = 0,
	p_power_max: int = 0,
	p_uses_magic_modifier: bool = true,
	p_required_level: int = 1,
	p_requires_discovery: bool = false,
	p_discovery_id: String = "",
	p_description: String = ""
) -> void:
	ability_id = p_ability_id
	display_name = p_display_name

	ability_kind = p_ability_kind
	target_kind = p_target_kind

	mp_cost = p_mp_cost

	power_min = p_power_min
	power_max = p_power_max

	uses_magic_modifier = p_uses_magic_modifier

	required_level = p_required_level

	requires_discovery = p_requires_discovery
	discovery_id = p_discovery_id

	description = p_description
