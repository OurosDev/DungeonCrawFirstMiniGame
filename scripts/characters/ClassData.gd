extends Resource

# ------------------------------------------------------------
# ClassData
# ------------------------------------------------------------
#
# Représente les données d'une classe de héros.
#
# Attention :
# on n'utilise pas "class_name" comme variable,
# car c'est un mot-clé réservé par Godot.


var display_name: String = ""
var short_name: String = ""

var base_hp: int = 8
var base_mp: int = 0

var physical_bonus: int = 0
var uses_magic_resource: bool = false

var commands: Array[String] = []

var ability_ids: Array[String] = []

var allowed_weapon_tags: Array[String] = []
var allowed_armor_tags: Array[String] = []

var description: String = ""


func _init(
	p_display_name: String = "",
	p_short_name: String = "",
	p_base_hp: int = 8,
	p_base_mp: int = 0,
	p_physical_bonus: int = 0,
	p_uses_magic_resource: bool = false,
	p_commands: Array[String] = [],
	p_ability_ids: Array[String] = [],
	p_allowed_weapon_tags: Array[String] = [],
	p_allowed_armor_tags: Array[String] = [],
	p_description: String = ""
) -> void:
	display_name = p_display_name
	short_name = p_short_name

	base_hp = p_base_hp
	base_mp = p_base_mp

	physical_bonus = p_physical_bonus
	uses_magic_resource = p_uses_magic_resource

	commands = p_commands
	ability_ids = p_ability_ids
	allowed_weapon_tags = p_allowed_weapon_tags
	allowed_armor_tags = p_allowed_armor_tags

	description = p_description
