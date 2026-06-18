extends Resource
class_name FloorData

# ------------------------------------------------------------
# DONNÉES D'ÉTAGE
# Représente un étage complet du donjon : layout, départ, escaliers,
# découvertes et thème visuel.
# ------------------------------------------------------------

var floor_id: int = 1
var display_name: String = ""
var layout: Array[String] = []

var player_start_cell: Vector2i = Vector2i(1, 1)
var stairs_down_cell: Vector2i = Vector2i(-1, -1)
var stairs_up_cell: Vector2i = Vector2i(-1, -1)

var ability_discovery_locations: Dictionary = {}
var theme_id: String = "dark_earth"


func _init(
	p_floor_id: int = 1,
	p_display_name: String = "",
	p_layout: Array[String] = [],
	p_player_start_cell: Vector2i = Vector2i(1, 1),
	p_stairs_down_cell: Vector2i = Vector2i(-1, -1),
	p_ability_discovery_locations: Dictionary = {},
	p_theme_id: String = "dark_earth",
	p_stairs_up_cell: Vector2i = Vector2i(-1, -1)
) -> void:
	floor_id = p_floor_id
	display_name = p_display_name
	layout = p_layout.duplicate()
	player_start_cell = p_player_start_cell
	stairs_down_cell = p_stairs_down_cell
	stairs_up_cell = p_stairs_up_cell
	ability_discovery_locations = p_ability_discovery_locations.duplicate()
	theme_id = p_theme_id
