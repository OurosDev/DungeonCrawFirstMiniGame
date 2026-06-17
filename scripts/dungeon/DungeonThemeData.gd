extends Resource

var theme_name: String = "Terre sombre"

var has_floor_patches: bool = true
var has_ceiling: bool = true
var has_ceiling_stone_lines: bool = true
var has_ceiling_patches: bool = true
var has_wall_bricks: bool = true

var floor_y: float = -0.55
var ceiling_y: float = 1.55
var wall_height: float = 2.0
var wall_center_y: float = 0.5

var light_energy: float = 1.4

var floor_color: Color = Color(0.15, 0.10, 0.06)
var floor_patch_color_a: Color = Color(0.19, 0.13, 0.08)
var floor_patch_color_b: Color = Color(0.10, 0.07, 0.045)
var floor_border_color: Color = Color(0.04, 0.03, 0.025)

var ceiling_color: Color = Color(0.10, 0.075, 0.055)
var ceiling_line_color: Color = Color(0.035, 0.028, 0.022)
var ceiling_patch_color: Color = Color(0.13, 0.095, 0.065)

var wall_color: Color = Color(0.25, 0.25, 0.26)
var brick_line_color: Color = Color(0.065, 0.065, 0.075)

var rune_color: Color = Color(0.1, 0.7, 1.0)

var door_color: Color = Color(0.23, 0.12, 0.055)
var door_frame_color: Color = Color(0.08, 0.045, 0.025)
var door_line_color: Color = Color(0.12, 0.065, 0.035)
var door_handle_color: Color = Color(0.75, 0.55, 0.20)

var door_height: float = 1.65
var door_thickness: float = 0.12
var door_width_ratio: float = 0.78
var door_open_offset_ratio: float = 0.38

var fog_color: Color = Color(0.0, 0.0, 0.0, 1.0)

var fog_curtain_distances: Array[float] = [
	4.25,
	5.25,
	6.25
]

var fog_curtain_alphas: Array[float] = [
	0.44,
	0.64,
	0.96
]

func _init() -> void:
	setup_dark_earth_theme()


func setup_dark_earth_theme() -> void:
	theme_name = "Terre sombre"

	has_floor_patches = true
	has_ceiling = true
	has_ceiling_stone_lines = true
	has_ceiling_patches = true
	has_wall_bricks = true

	floor_y = -0.55
	ceiling_y = 1.55
	wall_height = 2.0
	wall_center_y = 0.5

	light_energy = 1.4

	floor_color = Color(0.15, 0.10, 0.06)
	floor_patch_color_a = Color(0.19, 0.13, 0.08)
	floor_patch_color_b = Color(0.10, 0.07, 0.045)
	floor_border_color = Color(0.04, 0.03, 0.025)

	ceiling_color = Color(0.10, 0.075, 0.055)
	ceiling_line_color = Color(0.035, 0.028, 0.022)
	ceiling_patch_color = Color(0.13, 0.095, 0.065)

	wall_color = Color(0.25, 0.25, 0.26)
	brick_line_color = Color(0.065, 0.065, 0.075)

	rune_color = Color(0.1, 0.7, 1.0)

	door_color = Color(0.23, 0.12, 0.055)
	door_frame_color = Color(0.08, 0.045, 0.025)
	door_line_color = Color(0.12, 0.065, 0.035)
	door_handle_color = Color(0.75, 0.55, 0.20)

	door_height = 2.05
	door_thickness = 0.22
	door_width_ratio = 0.98
	door_open_offset_ratio = 0.38

	fog_color = Color(0.0, 0.0, 0.0, 1.0)
	fog_curtain_distances = [
	4.25,
	5.25,
	6.25
]
	fog_curtain_alphas = [
	0.44,
	0.64,
	0.96
]

func setup_gray_stone_theme() -> void:
	theme_name = "Pierre grise"

	has_floor_patches = true
	has_ceiling = true
	has_ceiling_stone_lines = true
	has_ceiling_patches = false
	has_wall_bricks = true

	floor_color = Color(0.18, 0.18, 0.19)
	floor_patch_color_a = Color(0.22, 0.22, 0.23)
	floor_patch_color_b = Color(0.12, 0.12, 0.13)
	floor_border_color = Color(0.04, 0.04, 0.045)

	ceiling_color = Color(0.13, 0.13, 0.14)
	ceiling_line_color = Color(0.045, 0.045, 0.05)
	ceiling_patch_color = Color(0.16, 0.16, 0.17)

	wall_color = Color(0.30, 0.30, 0.32)
	brick_line_color = Color(0.07, 0.07, 0.08)

	rune_color = Color(0.1, 0.7, 1.0)

	door_color = Color(0.35, 0.20, 0.05)
	door_frame_color = Color(0.30, 0.100, 0.05)
	door_line_color = Color(0.12, 0.07, 0.04)
	door_handle_color = Color(0.10, 0.05, 0.0)
	
	fog_color = Color(0.04, 0.045, 0.055, 1.0)
	fog_curtain_distances = [
	4.25,
	5.25,
	6.25
]
	fog_curtain_alphas = [
	0.36,
	0.54,
	0.86
]
