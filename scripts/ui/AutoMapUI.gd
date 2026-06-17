extends Panel
class_name AutoMapUI

const VISIBLE_RADIUS_X: int = 7
const VISIBLE_RADIUS_Y: int = 5

var title_label: Label = null
var map_grid: GridContainer = null
var info_label: Label = null

var ui_built: bool = false

var cell_pixel_size: int = 10


func _ready() -> void:
	build_ui()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.075, 0.045, 0.025, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			2
		)
	)

	var box: VBoxContainer = VBoxContainer.new()
	box.set_anchors_preset(Control.PRESET_FULL_RECT)
	box.offset_left = 8
	box.offset_top = 6
	box.offset_right = -8
	box.offset_bottom = -6
	box.add_theme_constant_override("separation", 5)
	add_child(box)

	title_label = create_label(
		"AUTOMAP",
		16,
		Color(0.95, 0.78, 0.38)
	)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(title_label)

	var map_center: CenterContainer = CenterContainer.new()
	map_center.size_flags_vertical = Control.SIZE_EXPAND_FILL
	map_center.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	box.add_child(map_center)

	map_grid = GridContainer.new()
	map_grid.name = "MapGrid"
	map_grid.add_theme_constant_override("h_separation", 1)
	map_grid.add_theme_constant_override("v_separation", 1)
	map_center.add_child(map_grid)

	info_label = create_label(
		"",
		12,
		Color(0.65, 0.76, 0.58)
	)
	info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(info_label)


func update_map(
	layout: Array[String],
	discovered_cells: Dictionary,
	player_position: Vector2i,
	facing_name: String
) -> void:
	ensure_ui_ready()

	clear_container(map_grid)

	if layout.is_empty():
		title_label.text = "AUTOMAP"
		info_label.text = "Aucune carte."
		return

	var start_x: int = player_position.x - VISIBLE_RADIUS_X
	var end_x: int = player_position.x + VISIBLE_RADIUS_X

	var start_y: int = player_position.y - VISIBLE_RADIUS_Y
	var end_y: int = player_position.y + VISIBLE_RADIUS_Y

	var visible_width: int = end_x - start_x + 1
	map_grid.columns = visible_width

	for y in range(start_y, end_y + 1):
		for x in range(start_x, end_x + 1):
			var cell: Vector2i = Vector2i(x, y)
			var tile: String = get_layout_tile(layout, cell)

			var is_player_cell: bool = cell == player_position
			var is_discovered: bool = discovered_cells.has(cell)
			var is_outside_map: bool = not is_inside_layout(layout, cell)

			var cell_panel: Panel = create_map_cell(
				tile,
				is_discovered,
				is_player_cell,
				is_outside_map,
				facing_name
			)

			map_grid.add_child(cell_panel)

	title_label.text = "AUTOMAP"

	var info: String = ""
	info += "Pos : " + str(player_position.x) + ", " + str(player_position.y)
	info += "  " + facing_name

	info_label.text = info


func create_map_cell(
	tile: String,
	is_discovered: bool,
	is_player_cell: bool,
	is_outside_map: bool,
	facing_name: String
) -> Panel:
	var background_color: Color = Color(0.025, 0.020, 0.016, 1.0)
	var border_color: Color = Color(0.045, 0.035, 0.025, 1.0)
	var text_color: Color = Color(0.75, 0.68, 0.50)
	var symbol: String = ""

	if is_outside_map:
		background_color = Color(0.010, 0.008, 0.006, 1.0)
		border_color = Color(0.010, 0.008, 0.006, 1.0)
		symbol = ""

	elif is_player_cell:
		background_color = Color(0.18, 0.12, 0.045, 1.0)
		border_color = Color(1.0, 0.78, 0.22, 1.0)
		text_color = Color(1.0, 0.92, 0.42)
		symbol = get_player_symbol(facing_name)

	elif not is_discovered:
		background_color = Color(0.018, 0.014, 0.012, 1.0)
		border_color = Color(0.025, 0.020, 0.016, 1.0)
		symbol = ""

	elif tile == "#":
		background_color = Color(0.22, 0.22, 0.23, 1.0)
		border_color = Color(0.08, 0.08, 0.09, 1.0)
		symbol = ""

	elif tile == "D":
		background_color = Color(0.34, 0.18, 0.07, 1.0)
		border_color = Color(0.85, 0.58, 0.20, 1.0)
		text_color = Color(1.0, 0.82, 0.36)
		symbol = "D"

	elif tile == "d":
		background_color = Color(0.22, 0.12, 0.05, 1.0)
		border_color = Color(0.55, 0.34, 0.12, 1.0)
		text_color = Color(0.95, 0.78, 0.38)
		symbol = "/"

	elif tile == ">":
		background_color = Color(0.09, 0.06, 0.035, 1.0)
		border_color = Color(0.50, 0.36, 0.12, 1.0)
		text_color = Color(0.95, 0.78, 0.38)
		symbol = ">"

	elif tile == "<":
		background_color = Color(0.09, 0.06, 0.035, 1.0)
		border_color = Color(0.50, 0.36, 0.12, 1.0)
		text_color = Color(0.95, 0.78, 0.38)
		symbol = "<"

	else:
		background_color = Color(0.08, 0.055, 0.035, 1.0)
		border_color = Color(0.12, 0.08, 0.045, 1.0)
		symbol = ""

	var panel: Panel = Panel.new()
	panel.custom_minimum_size = Vector2(cell_pixel_size, cell_pixel_size)
	panel.add_theme_stylebox_override(
		"panel",
		create_panel_style(
			background_color,
			border_color,
			1
		)
	)

	var label: Label = create_label(
		symbol,
		8,
		text_color
	)
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	panel.add_child(label)

	return panel


func get_player_symbol(facing_name: String) -> String:
	var lower_name: String = facing_name.to_lower()

	if lower_name.contains("nord") or lower_name.contains("north"):
		return "▲"

	if lower_name.contains("ouest") or lower_name.contains("west"):
		return "◀"

	if lower_name.contains("est") or lower_name.contains("east"):
		return "▶"

	if lower_name.contains("sud") or lower_name.contains("south"):
		return "▼"

	return "@"


func is_inside_layout(layout: Array[String], cell: Vector2i) -> bool:
	if cell.y < 0 or cell.y >= layout.size():
		return false

	if cell.x < 0 or cell.x >= layout[cell.y].length():
		return false

	return true


func get_layout_tile(layout: Array[String], cell: Vector2i) -> String:
	if not is_inside_layout(layout, cell):
		return "#"

	return layout[cell.y].substr(cell.x, 1)


func create_panel_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBoxFlat:
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = background_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.corner_radius_top_left = 1
	style.corner_radius_top_right = 1
	style.corner_radius_bottom_left = 1
	style.corner_radius_bottom_right = 1

	return style


func create_label(
	text: String,
	font_size: int,
	font_color: Color
) -> Label:
	var label: Label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label


func clear_container(container: Node) -> void:
	if container == null:
		return

	for child in container.get_children():
		child.free()


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
