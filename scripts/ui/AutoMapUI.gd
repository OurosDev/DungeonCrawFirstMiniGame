extends Panel
class_name AutoMapUI
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

const VISIBLE_RADIUS_X: int = 7
const VISIBLE_RADIUS_Y: int = 5
const COMPACT_MAP_FALLBACK_CELL_PIXEL_SIZE: int = 10
const COMPACT_MAP_MIN_CELL_PIXEL_SIZE: int = 10
const COMPACT_MAP_MAX_CELL_PIXEL_SIZE: int = 13
const COMPACT_MAP_GRID_SEPARATION: int = 1
const FULL_MAP_FALLBACK_CELL_PIXEL_SIZE: int = 16
const FULL_MAP_MIN_CELL_PIXEL_SIZE: int = 8
const FULL_MAP_MAX_CELL_PIXEL_SIZE: int = 20
const FULL_MAP_GRID_SEPARATION: int = 1
const COORDINATE_TOOLTIP_MIN_SIZE: Vector2 = Vector2(118, 28)
const COORDINATE_TOOLTIP_LABEL_MIN_SIZE: Vector2 = Vector2(96, 18)
const COORDINATE_TOOLTIP_FONT_SIZE: int = 12
const COORDINATE_TOOLTIP_MOUSE_OFFSET: Vector2 = Vector2(14, 14)
const COORDINATE_TOOLTIP_VIEWPORT_MARGIN: float = 4.0

# ------------------------------------------------------------
# RÉFÉRENCES UI
# ------------------------------------------------------------

var title_label: Label = null
var content_box: VBoxContainer = null
var map_center_container: CenterContainer = null
var map_grid: GridContainer = null
var info_label: Label = null
var coordinate_tooltip: Panel = null
var coordinate_tooltip_label: Label = null


# ------------------------------------------------------------
# ÉTAT UI
# ------------------------------------------------------------

var ui_built: bool = false
var cell_pixel_size: int = COMPACT_MAP_FALLBACK_CELL_PIXEL_SIZE
var is_full_map_mode: bool = false


# ------------------------------------------------------------
# INITIALISATION
# ------------------------------------------------------------

func _ready() -> void:
	build_ui()


# Construit l'interface de l'automap une seule fois.
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

	content_box = VBoxContainer.new()
	content_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	content_box.offset_left = 8
	content_box.offset_top = 6
	content_box.offset_right = -8
	content_box.offset_bottom = -6
	content_box.add_theme_constant_override("separation", 5)
	add_child(content_box)

	title_label = create_label("", 16, Color(0.95, 0.78, 0.38))
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content_box.add_child(title_label)

	map_center_container = CenterContainer.new()
	map_center_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	map_center_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	content_box.add_child(map_center_container)

	map_grid = GridContainer.new()
	map_grid.name = "MapGrid"
	map_grid.add_theme_constant_override("h_separation", 1)
	map_grid.add_theme_constant_override("v_separation", 1)
	map_center_container.add_child(map_grid)

	info_label = create_label("", 12, Color(0.65, 0.76, 0.58))
	info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	content_box.add_child(info_label)

	build_coordinate_tooltip()


# ------------------------------------------------------------
# MISE À JOUR DE LA CARTE
# ------------------------------------------------------------

# Reconstruit la portion visible de l'automap autour du joueur.
func update_map(
	layout: Array[String],
	discovered_cells: Dictionary,
	player_position: Vector2i,
	facing_name: String
) -> void:
	ensure_ui_ready()
	apply_compact_map_mode()

	map_grid.add_theme_constant_override("h_separation", COMPACT_MAP_GRID_SEPARATION)
	map_grid.add_theme_constant_override("v_separation", COMPACT_MAP_GRID_SEPARATION)

	clear_container(map_grid)

	if layout.is_empty():
		title_label.text = ""
		info_label.text = "Aucune carte."
		return

	var start_x: int = player_position.x - VISIBLE_RADIUS_X
	var end_x: int = player_position.x + VISIBLE_RADIUS_X
	var start_y: int = player_position.y - VISIBLE_RADIUS_Y
	var end_y: int = player_position.y + VISIBLE_RADIUS_Y
	var visible_width: int = end_x - start_x + 1
	var visible_height: int = end_y - start_y + 1

	# Garde au minimum la fenêtre historique 15x11, mais adapte légèrement
	# la taille des cellules à l'espace réellement disponible.
	cell_pixel_size = get_adaptive_map_cell_size(
		visible_width,
		visible_height,
		COMPACT_MAP_GRID_SEPARATION,
		COMPACT_MAP_FALLBACK_CELL_PIXEL_SIZE,
		COMPACT_MAP_MIN_CELL_PIXEL_SIZE,
		COMPACT_MAP_MAX_CELL_PIXEL_SIZE
	)

	map_grid.columns = visible_width

	for y in range(start_y, end_y + 1):
		for x in range(start_x, end_x + 1):
			add_map_cell_to_grid(
				layout,
				discovered_cells,
				Vector2i(x, y),
				player_position,
				facing_name
			)

	title_label.text = ""

	var info: String = ""
	info += "Pos : " + str(player_position.x) + ", " + str(player_position.y)
	info += " " + facing_name
	info_label.text = info


# Reconstruit toute la carte de l'étage, sans révéler les cellules non découvertes.
func update_full_map(
	layout: Array[String],
	discovered_cells: Dictionary,
	player_position: Vector2i,
	facing_name: String
) -> void:
	ensure_ui_ready()
	apply_full_map_overlay_mode()

	cell_pixel_size = get_adaptive_full_map_cell_size(layout)
	map_grid.add_theme_constant_override("h_separation", FULL_MAP_GRID_SEPARATION)
	map_grid.add_theme_constant_override("v_separation", FULL_MAP_GRID_SEPARATION)

	clear_container(map_grid)

	if layout.is_empty():
		title_label.text = ""
		info_label.text = ""
		return

	var map_width: int = get_layout_width(layout)
	var map_height: int = layout.size()

	map_grid.columns = max(1, map_width)

	for y in range(map_height):
		for x in range(map_width):
			add_map_cell_to_grid(
				layout,
				discovered_cells,
				Vector2i(x, y),
				player_position,
				facing_name
			)

	title_label.text = ""
	info_label.text = ""


# Ajoute une cellule de carte avec la même logique visuelle pour l'automap
# compacte et la carte agrandie.
func add_map_cell_to_grid(
	layout: Array[String],
	discovered_cells: Dictionary,
	cell: Vector2i,
	player_position: Vector2i,
	facing_name: String
) -> void:
	var tile: String = get_layout_tile(layout, cell)
	var is_player_cell: bool = cell == player_position
	var is_discovered: bool = discovered_cells.has(cell)
	var is_outside_map: bool = not is_inside_layout(layout, cell)
	var cell_panel: Panel = create_map_cell(
		tile,
		is_discovered,
		is_player_cell,
		is_outside_map,
		facing_name,
		cell
	)
	map_grid.add_child(cell_panel)


# ------------------------------------------------------------
# CELLULES DE LA CARTE
# ------------------------------------------------------------

# Crée une cellule visuelle selon le contenu de la case :
# mur, porte, porte verrouillée, escalier, temple, boutique,
# coffre, message, boss, joueur ou zone non découverte.
func create_map_cell(
	tile: String,
	is_discovered: bool,
	is_player_cell: bool,
	is_outside_map: bool,
	facing_name: String,
	cell_coordinates: Vector2i = Vector2i(-1, -1)
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
	elif tile == "L":
		background_color = Color(0.18, 0.06, 0.035, 1.0)
		border_color = Color(0.90, 0.32, 0.14, 1.0)
		text_color = Color(1.0, 0.58, 0.32, 1.0)
		symbol = "L"
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
	elif tile == "O":
		background_color = Color(0.035, 0.09, 0.08, 1.0)
		border_color = Color(0.35, 0.85, 0.75, 1.0)
		text_color = Color(0.75, 1.0, 0.92, 1.0)
		symbol = "O"
	elif tile == "B":
		background_color = Color(0.11, 0.065, 0.025, 1.0)
		border_color = Color(0.86, 0.58, 0.18, 1.0)
		text_color = Color(1.0, 0.82, 0.34, 1.0)
		symbol = "B"
	elif tile == "C":
		background_color = Color(0.12, 0.075, 0.035, 1.0)
		border_color = Color(0.88, 0.62, 0.22, 1.0)
		text_color = Color(1.0, 0.82, 0.38, 1.0)
		symbol = "C"
	elif tile == "X":
		background_color = Color(0.12, 0.025, 0.025, 1.0)
		border_color = Color(0.90, 0.18, 0.12, 1.0)
		text_color = Color(1.0, 0.45, 0.32, 1.0)
		symbol = "X"
	elif tile == "F":
		background_color = Color(0.11, 0.04, 0.025, 1.0)
		border_color = Color(0.85, 0.32, 0.12, 1.0)
		text_color = Color(1.0, 0.60, 0.38, 1.0)
		symbol = "F"
	elif tile == "M":
		background_color = Color(0.055, 0.075, 0.08, 1.0)
		border_color = Color(0.42, 0.72, 0.80, 1.0)
		text_color = Color(0.75, 0.95, 1.0, 1.0)
		symbol = "M"
	else:
		background_color = Color(0.08, 0.055, 0.035, 1.0)
		border_color = Color(0.12, 0.08, 0.045, 1.0)
		symbol = ""

	var panel: Panel = Panel.new()
	panel.custom_minimum_size = Vector2(cell_pixel_size, cell_pixel_size)
	panel.add_theme_stylebox_override(
		"panel",
		create_map_cell_style(background_color, border_color, 1)
	)

	var can_show_coordinates: bool = is_discovered and not is_outside_map and tile != "#"

	if can_show_coordinates:
		panel.mouse_filter = Control.MOUSE_FILTER_STOP
		panel.mouse_entered.connect(
			func():
				show_coordinate_tooltip(cell_coordinates)
		)
		panel.mouse_exited.connect(hide_coordinate_tooltip)
	else:
		panel.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var label_font_size: int = get_cell_label_font_size()

	var label: Label = create_label(symbol, label_font_size, text_color)
	label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	panel.add_child(label)

	return panel


# ------------------------------------------------------------
# SYMBOLE DU JOUEUR
# ------------------------------------------------------------

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


# ------------------------------------------------------------
# LECTURE DU LAYOUT
# ------------------------------------------------------------

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


func get_layout_width(layout: Array[String]) -> int:
	var width: int = 0

	for row in layout:
		width = max(width, row.length())

	return width


# ------------------------------------------------------------
# OUTILS UI
# ------------------------------------------------------------

func build_coordinate_tooltip() -> void:
	coordinate_tooltip = Panel.new()
	coordinate_tooltip.name = "CoordinateTooltip"
	coordinate_tooltip.visible = false
	coordinate_tooltip.mouse_filter = Control.MOUSE_FILTER_IGNORE
	coordinate_tooltip.z_index = 100
	coordinate_tooltip.custom_minimum_size = COORDINATE_TOOLTIP_MIN_SIZE
	coordinate_tooltip.size = COORDINATE_TOOLTIP_MIN_SIZE
	coordinate_tooltip.add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.06, 0.04, 0.03, 0.96),
			Color(0.78, 0.50, 0.16, 1.0),
			2
		)
	)
	add_child(coordinate_tooltip)

	var margin: MarginContainer = MarginContainer.new()
	margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 8)
	margin.add_theme_constant_override("margin_top", 4)
	margin.add_theme_constant_override("margin_right", 8)
	margin.add_theme_constant_override("margin_bottom", 4)
	coordinate_tooltip.add_child(margin)

	coordinate_tooltip_label = create_label("", COORDINATE_TOOLTIP_FONT_SIZE, Color(0.95, 0.82, 0.45))
	coordinate_tooltip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	coordinate_tooltip_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	coordinate_tooltip_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	coordinate_tooltip_label.clip_text = false
	coordinate_tooltip_label.custom_minimum_size = COORDINATE_TOOLTIP_LABEL_MIN_SIZE
	margin.add_child(coordinate_tooltip_label)


func show_coordinate_tooltip(cell_coordinates: Vector2i) -> void:
	if coordinate_tooltip == null or coordinate_tooltip_label == null:
		return

	# Format compact et sans retour à la ligne, plus robuste avec une police globale plus large.
	coordinate_tooltip_label.text = "X:%d  Y:%d" % [cell_coordinates.x, cell_coordinates.y]
	coordinate_tooltip_label.autowrap_mode = TextServer.AUTOWRAP_OFF
	coordinate_tooltip_label.clip_text = false

	coordinate_tooltip.custom_minimum_size = COORDINATE_TOOLTIP_MIN_SIZE
	coordinate_tooltip.size = COORDINATE_TOOLTIP_MIN_SIZE

	var local_mouse_position: Vector2 = get_local_mouse_position()
	var tooltip_size: Vector2 = COORDINATE_TOOLTIP_MIN_SIZE

	var target_position: Vector2 = local_mouse_position + COORDINATE_TOOLTIP_MOUSE_OFFSET
	var max_x: float = max(
		COORDINATE_TOOLTIP_VIEWPORT_MARGIN,
		size.x - tooltip_size.x - COORDINATE_TOOLTIP_VIEWPORT_MARGIN
	)
	var max_y: float = max(
		COORDINATE_TOOLTIP_VIEWPORT_MARGIN,
		size.y - tooltip_size.y - COORDINATE_TOOLTIP_VIEWPORT_MARGIN
	)

	target_position.x = clamp(
		target_position.x,
		COORDINATE_TOOLTIP_VIEWPORT_MARGIN,
		max_x
	)
	target_position.y = clamp(
		target_position.y,
		COORDINATE_TOOLTIP_VIEWPORT_MARGIN,
		max_y
	)

	coordinate_tooltip.position = target_position
	coordinate_tooltip.visible = true


func hide_coordinate_tooltip() -> void:
	if coordinate_tooltip != null:
		coordinate_tooltip.visible = false


func apply_compact_map_mode() -> void:
	is_full_map_mode = false
	hide_coordinate_tooltip()

	# L'automap compacte reste implicite : pas de titre pour gagner de la place.
	if title_label != null:
		title_label.visible = false

	if info_label != null:
		info_label.visible = true

	if content_box != null:
		content_box.offset_left = 6
		content_box.offset_top = 4
		content_box.offset_right = -6
		content_box.offset_bottom = -4
		content_box.add_theme_constant_override("separation", 3)

	add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.075, 0.045, 0.025, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			2
		)
	)


func apply_full_map_overlay_mode() -> void:
	is_full_map_mode = true
	hide_coordinate_tooltip()

	# La fenêtre de carte agrandie possède déjà son propre cadre texturé.
	# On retire donc le cadre interne, le titre et la ligne d'info afin de
	# réserver l'espace au dessin de la carte.
	if title_label != null:
		title_label.visible = false

	if info_label != null:
		info_label.visible = false

	if content_box != null:
		content_box.offset_left = 0
		content_box.offset_top = 0
		content_box.offset_right = 0
		content_box.offset_bottom = 0
		content_box.add_theme_constant_override("separation", 0)

	add_theme_stylebox_override("panel", StyleBoxEmpty.new())


func get_adaptive_full_map_cell_size(layout: Array[String]) -> int:
	var map_width: int = max(1, get_layout_width(layout))
	var map_height: int = max(1, layout.size())

	return get_adaptive_map_cell_size(
		map_width,
		map_height,
		FULL_MAP_GRID_SEPARATION,
		FULL_MAP_FALLBACK_CELL_PIXEL_SIZE,
		FULL_MAP_MIN_CELL_PIXEL_SIZE,
		FULL_MAP_MAX_CELL_PIXEL_SIZE
	)


func get_adaptive_map_cell_size(
	map_width: int,
	map_height: int,
	grid_separation: int,
	fallback_cell_size: int,
	min_cell_size: int,
	max_cell_size: int
) -> int:
	var available_size: Vector2 = size

	if map_center_container != null:
		if map_center_container.size.x > 0 and map_center_container.size.y > 0:
			available_size = map_center_container.size

	if available_size.x <= 0 or available_size.y <= 0:
		return fallback_cell_size

	var horizontal_separation_total: int = max(0, map_width - 1) * grid_separation
	var vertical_separation_total: int = max(0, map_height - 1) * grid_separation

	var available_width: float = max(1.0, available_size.x - float(horizontal_separation_total))
	var available_height: float = max(1.0, available_size.y - float(vertical_separation_total))

	var size_from_width: int = int(floor(available_width / float(max(1, map_width))))
	var size_from_height: int = int(floor(available_height / float(max(1, map_height))))
	var fitted_size: int = min(size_from_width, size_from_height)

	return int(clamp(
		float(fitted_size),
		float(min_cell_size),
		float(max_cell_size)
	))


func get_cell_label_font_size() -> int:
	return int(clamp(float(cell_pixel_size) * 0.70, 7.0, 12.0))


func create_panel_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBox:
	return UIFrameStyleScript.create_panel_style(
		background_color,
		border_color,
		border_width
	)


func create_map_cell_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBoxFlat:
	return UIFrameStyleScript.create_flat_style(
		background_color,
		border_color,
		border_width
	)


func create_label(text: String, font_size: int, font_color: Color) -> Label:
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
