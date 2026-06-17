extends Node3D
class_name DungeonRenderer

const DungeonThemeDataScript = preload("res://scripts/dungeon/DungeonThemeData.gd")

var cell_size: float = 2.0

var generated_root: Node3D = null

var current_layout: Array[String] = []
var current_theme = null

var floor_material: StandardMaterial3D
var floor_patch_material_a: StandardMaterial3D
var floor_patch_material_b: StandardMaterial3D
var floor_border_material: StandardMaterial3D

var ceiling_material: StandardMaterial3D
var ceiling_line_material: StandardMaterial3D
var ceiling_patch_material: StandardMaterial3D

var wall_material: StandardMaterial3D
var brick_line_material: StandardMaterial3D

var rune_material: StandardMaterial3D

var door_material: StandardMaterial3D
var door_frame_material: StandardMaterial3D
var door_line_material: StandardMaterial3D
var door_handle_material: StandardMaterial3D

var ability_discovery_markers: Dictionary = {}
var door_visuals: Dictionary = {}


func build_dungeon(
	layout: Array[String],
	ability_discovery_locations: Dictionary,
	p_cell_size: float,
	theme
) -> void:
	cell_size = p_cell_size
	current_layout = layout

	if theme == null:
		current_theme = DungeonThemeDataScript.new()
	else:
		current_theme = theme

	clear_dungeon()
	create_materials()

	generated_root = Node3D.new()
	generated_root.name = "GeneratedDungeon"
	add_child(generated_root)

	create_light()

	for y in range(current_layout.size()):
		for x in range(current_layout[y].length()):
			var tile: String = current_layout[y].substr(x, 1)

			if tile == "#":
				create_wall_tile(x, y)
			else:
				create_floor_tile(x, y)

				if current_theme.has_ceiling:
					create_ceiling_tile(x, y)

				if tile == "D":
					create_closed_door_tile(Vector2i(x, y))

				elif tile == "d":
					create_open_door_tile(Vector2i(x, y))

	create_ability_discovery_markers(ability_discovery_locations)


func clear_dungeon() -> void:
	ability_discovery_markers.clear()
	door_visuals.clear()

	if generated_root != null:
		generated_root.queue_free()
		generated_root = null


func create_materials() -> void:
	floor_material = create_material(current_theme.floor_color)
	floor_patch_material_a = create_material(current_theme.floor_patch_color_a)
	floor_patch_material_b = create_material(current_theme.floor_patch_color_b)
	floor_border_material = create_material(current_theme.floor_border_color)

	ceiling_material = create_material(current_theme.ceiling_color)
	ceiling_line_material = create_material(current_theme.ceiling_line_color)
	ceiling_patch_material = create_material(current_theme.ceiling_patch_color)

	wall_material = create_material(current_theme.wall_color)
	brick_line_material = create_material(current_theme.brick_line_color)

	rune_material = create_material(current_theme.rune_color)

	door_material = create_material(current_theme.door_color)
	door_frame_material = create_material(current_theme.door_frame_color)
	door_line_material = create_material(current_theme.door_line_color)
	door_handle_material = create_material(current_theme.door_handle_color)


func create_material(color: Color) -> StandardMaterial3D:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = color
	return material


func create_light() -> void:
	var light: DirectionalLight3D = DirectionalLight3D.new()
	light.name = "DungeonLight"
	light.rotation_degrees = Vector3(-60.0, 30.0, 0.0)
	light.light_energy = current_theme.light_energy
	generated_root.add_child(light)


func create_box(
	box_name: String,
	box_size: Vector3,
	box_position: Vector3,
	material: Material,
	parent_node: Node3D = null
) -> MeshInstance3D:
	var mesh_instance: MeshInstance3D = MeshInstance3D.new()
	var mesh: BoxMesh = BoxMesh.new()

	mesh.size = box_size

	mesh_instance.name = box_name
	mesh_instance.mesh = mesh
	mesh_instance.position = box_position

	if material != null:
		mesh_instance.material_override = material

	if parent_node == null:
		generated_root.add_child(mesh_instance)
	else:
		parent_node.add_child(mesh_instance)

	return mesh_instance


# ------------------------------------------------------------
# SOL
# ------------------------------------------------------------

func create_floor_tile(x: int, y: int) -> void:
	var center_position: Vector3 = Vector3(
		float(x) * cell_size,
		current_theme.floor_y,
		float(y) * cell_size
	)

	create_box(
		"Floor",
		Vector3(cell_size, 0.08, cell_size),
		center_position,
		floor_material
	)

	create_floor_borders(center_position)

	if current_theme.has_floor_patches:
		create_floor_dirt_patches(center_position)


func create_floor_borders(center_position: Vector3) -> void:
	var border_height: float = current_theme.floor_y + 0.06
	var border_thickness: float = 0.04

	create_box(
		"FloorBorderNorth",
		Vector3(cell_size, 0.025, border_thickness),
		Vector3(center_position.x, border_height, center_position.z - cell_size / 2.0),
		floor_border_material
	)

	create_box(
		"FloorBorderSouth",
		Vector3(cell_size, 0.025, border_thickness),
		Vector3(center_position.x, border_height, center_position.z + cell_size / 2.0),
		floor_border_material
	)

	create_box(
		"FloorBorderWest",
		Vector3(border_thickness, 0.025, cell_size),
		Vector3(center_position.x - cell_size / 2.0, border_height, center_position.z),
		floor_border_material
	)

	create_box(
		"FloorBorderEast",
		Vector3(border_thickness, 0.025, cell_size),
		Vector3(center_position.x + cell_size / 2.0, border_height, center_position.z),
		floor_border_material
	)


func create_floor_dirt_patches(center_position: Vector3) -> void:
	var patch_height: float = current_theme.floor_y + 0.065

	create_box(
		"FloorDirtPatchA",
		Vector3(0.55, 0.018, 0.28),
		Vector3(center_position.x - 0.35, patch_height, center_position.z - 0.25),
		floor_patch_material_a
	)

	create_box(
		"FloorDirtPatchB",
		Vector3(0.35, 0.018, 0.45),
		Vector3(center_position.x + 0.38, patch_height, center_position.z + 0.20),
		floor_patch_material_b
	)

	create_box(
		"FloorDirtPatchC",
		Vector3(0.30, 0.018, 0.22),
		Vector3(center_position.x - 0.10, patch_height, center_position.z + 0.45),
		floor_patch_material_a
	)


# ------------------------------------------------------------
# PLAFOND
# ------------------------------------------------------------

func create_ceiling_tile(x: int, y: int) -> void:
	var center_position: Vector3 = Vector3(
		float(x) * cell_size,
		current_theme.ceiling_y,
		float(y) * cell_size
	)

	create_box(
		"Ceiling",
		Vector3(cell_size, 0.08, cell_size),
		center_position,
		ceiling_material
	)

	if current_theme.has_ceiling_stone_lines:
		create_ceiling_stone_lines(center_position)

	if current_theme.has_ceiling_patches:
		create_ceiling_stone_patches(center_position)


func create_ceiling_stone_lines(center_position: Vector3) -> void:
	var line_height: float = current_theme.ceiling_y - 0.055
	var line_thickness: float = 0.035

	create_box(
		"CeilingLineNorth",
		Vector3(cell_size, 0.025, line_thickness),
		Vector3(center_position.x, line_height, center_position.z - cell_size / 2.0),
		ceiling_line_material
	)

	create_box(
		"CeilingLineSouth",
		Vector3(cell_size, 0.025, line_thickness),
		Vector3(center_position.x, line_height, center_position.z + cell_size / 2.0),
		ceiling_line_material
	)

	create_box(
		"CeilingLineWest",
		Vector3(line_thickness, 0.025, cell_size),
		Vector3(center_position.x - cell_size / 2.0, line_height, center_position.z),
		ceiling_line_material
	)

	create_box(
		"CeilingLineEast",
		Vector3(line_thickness, 0.025, cell_size),
		Vector3(center_position.x + cell_size / 2.0, line_height, center_position.z),
		ceiling_line_material
	)

	create_box(
		"CeilingLineMiddleX",
		Vector3(line_thickness, 0.025, cell_size),
		Vector3(center_position.x, line_height, center_position.z),
		ceiling_line_material
	)

	create_box(
		"CeilingLineMiddleZ",
		Vector3(cell_size, 0.025, line_thickness),
		Vector3(center_position.x, line_height, center_position.z),
		ceiling_line_material
	)


func create_ceiling_stone_patches(center_position: Vector3) -> void:
	var patch_height: float = current_theme.ceiling_y - 0.06

	create_box(
		"CeilingStonePatchA",
		Vector3(0.50, 0.018, 0.35),
		Vector3(center_position.x - 0.35, patch_height, center_position.z + 0.30),
		ceiling_patch_material
	)

	create_box(
		"CeilingStonePatchB",
		Vector3(0.35, 0.018, 0.45),
		Vector3(center_position.x + 0.35, patch_height, center_position.z - 0.25),
		ceiling_patch_material
	)


# ------------------------------------------------------------
# MURS
# ------------------------------------------------------------

func create_wall_tile(x: int, y: int) -> void:
	create_box(
		"Wall",
		Vector3(cell_size, current_theme.wall_height, cell_size),
		Vector3(
			float(x) * cell_size,
			current_theme.wall_center_y,
			float(y) * cell_size
		),
		wall_material
	)

	if current_theme.has_wall_bricks:
		create_wall_brick_pattern(x, y)


func create_wall_brick_pattern(x: int, y: int) -> void:
	if not is_wall_cell(Vector2i(x, y - 1)):
		create_wall_brick_face_north(x, y)

	if not is_wall_cell(Vector2i(x, y + 1)):
		create_wall_brick_face_south(x, y)

	if not is_wall_cell(Vector2i(x - 1, y)):
		create_wall_brick_face_west(x, y)

	if not is_wall_cell(Vector2i(x + 1, y)):
		create_wall_brick_face_east(x, y)


func create_wall_brick_face_north(x: int, y: int) -> void:
	var wall_x: float = float(x) * cell_size
	var wall_z: float = float(y) * cell_size - cell_size / 2.0 - 0.012

	create_horizontal_brick_lines_x(wall_x, wall_z)
	create_vertical_brick_lines_x(wall_x, wall_z)


func create_wall_brick_face_south(x: int, y: int) -> void:
	var wall_x: float = float(x) * cell_size
	var wall_z: float = float(y) * cell_size + cell_size / 2.0 + 0.012

	create_horizontal_brick_lines_x(wall_x, wall_z)
	create_vertical_brick_lines_x(wall_x, wall_z)


func create_wall_brick_face_west(x: int, y: int) -> void:
	var wall_x: float = float(x) * cell_size - cell_size / 2.0 - 0.012
	var wall_z: float = float(y) * cell_size

	create_horizontal_brick_lines_z(wall_x, wall_z)
	create_vertical_brick_lines_z(wall_x, wall_z)


func create_wall_brick_face_east(x: int, y: int) -> void:
	var wall_x: float = float(x) * cell_size + cell_size / 2.0 + 0.012
	var wall_z: float = float(y) * cell_size

	create_horizontal_brick_lines_z(wall_x, wall_z)
	create_vertical_brick_lines_z(wall_x, wall_z)


func create_horizontal_brick_lines_x(wall_x: float, wall_z: float) -> void:
	var line_depth: float = 0.025
	var line_height: float = 0.035

	var y_values: Array[float] = [
		0.0,
		0.5,
		1.0
	]

	for y_value in y_values:
		create_box(
			"BrickHorizontalLine",
			Vector3(cell_size, line_height, line_depth),
			Vector3(wall_x, y_value, wall_z),
			brick_line_material
		)


func create_horizontal_brick_lines_z(wall_x: float, wall_z: float) -> void:
	var line_depth: float = 0.025
	var line_height: float = 0.035

	var y_values: Array[float] = [
		0.0,
		0.5,
		1.0
	]

	for y_value in y_values:
		create_box(
			"BrickHorizontalLine",
			Vector3(line_depth, line_height, cell_size),
			Vector3(wall_x, y_value, wall_z),
			brick_line_material
		)


func create_vertical_brick_lines_x(wall_x: float, wall_z: float) -> void:
	var line_width: float = 0.035
	var line_depth: float = 0.025
	var row_height: float = 0.42

	var row_centers: Array[float] = [
		-0.25,
		0.25,
		0.75,
		1.25
	]

	for row_index in range(row_centers.size()):
		var row_y: float = row_centers[row_index]

		if row_index % 2 == 0:
			create_box(
				"BrickVerticalLine",
				Vector3(line_width, row_height, line_depth),
				Vector3(wall_x, row_y, wall_z),
				brick_line_material
			)
		else:
			create_box(
				"BrickVerticalLine",
				Vector3(line_width, row_height, line_depth),
				Vector3(wall_x - 0.50, row_y, wall_z),
				brick_line_material
			)

			create_box(
				"BrickVerticalLine",
				Vector3(line_width, row_height, line_depth),
				Vector3(wall_x + 0.50, row_y, wall_z),
				brick_line_material
			)


func create_vertical_brick_lines_z(wall_x: float, wall_z: float) -> void:
	var line_width: float = 0.035
	var line_depth: float = 0.025
	var row_height: float = 0.42

	var row_centers: Array[float] = [
		-0.25,
		0.25,
		0.75,
		1.25
	]

	for row_index in range(row_centers.size()):
		var row_y: float = row_centers[row_index]

		if row_index % 2 == 0:
			create_box(
				"BrickVerticalLine",
				Vector3(line_depth, row_height, line_width),
				Vector3(wall_x, row_y, wall_z),
				brick_line_material
			)
		else:
			create_box(
				"BrickVerticalLine",
				Vector3(line_depth, row_height, line_width),
				Vector3(wall_x, row_y, wall_z - 0.50),
				brick_line_material
			)

			create_box(
				"BrickVerticalLine",
				Vector3(line_depth, row_height, line_width),
				Vector3(wall_x, row_y, wall_z + 0.50),
				brick_line_material
			)


# ------------------------------------------------------------
# PORTES
# ------------------------------------------------------------

func create_door_visual_root(cell: Vector2i) -> Node3D:
	clear_door_visual(cell)

	var root: Node3D = Node3D.new()
	root.name = "Door_" + str(cell.x) + "_" + str(cell.y)

	generated_root.add_child(root)

	door_visuals[cell] = root

	return root


func clear_door_visual(cell: Vector2i) -> void:
	if not door_visuals.has(cell):
		return

	var visual = door_visuals[cell]

	if visual != null and is_instance_valid(visual):
		visual.queue_free()

	door_visuals.erase(cell)


func set_door_open(cell: Vector2i) -> void:
	create_open_door_tile(cell)


func get_door_orientation(cell: Vector2i) -> String:
	var left_is_wall: bool = is_wall_cell(Vector2i(cell.x - 1, cell.y))
	var right_is_wall: bool = is_wall_cell(Vector2i(cell.x + 1, cell.y))

	var north_is_wall: bool = is_wall_cell(Vector2i(cell.x, cell.y - 1))
	var south_is_wall: bool = is_wall_cell(Vector2i(cell.x, cell.y + 1))

	if left_is_wall and right_is_wall:
		return "x"

	if north_is_wall and south_is_wall:
		return "z"

	return "x"


func get_door_center(cell: Vector2i) -> Vector3:
	return Vector3(
		float(cell.x) * cell_size,
		current_theme.floor_y + 0.08 + current_theme.door_height / 2.0,
		float(cell.y) * cell_size
	)


func create_closed_door_tile(cell: Vector2i) -> void:
	var root: Node3D = create_door_visual_root(cell)
	var orientation: String = get_door_orientation(cell)
	var center: Vector3 = get_door_center(cell)

	var door_width: float = cell_size * current_theme.door_width_ratio
	var door_height: float = current_theme.door_height
	var door_thickness: float = current_theme.door_thickness

	if orientation == "x":
		create_box(
			"ClosedDoorPanel",
			Vector3(door_width, door_height, door_thickness),
			center,
			door_material,
			root
		)

		create_closed_door_details_x(root, center, door_width, door_height, door_thickness)
	else:
		create_box(
			"ClosedDoorPanel",
			Vector3(door_thickness, door_height, door_width),
			center,
			door_material,
			root
		)

		create_closed_door_details_z(root, center, door_width, door_height, door_thickness)


func create_closed_door_details_x(
	root: Node3D,
	center: Vector3,
	door_width: float,
	door_height: float,
	door_thickness: float
) -> void:
	var frame_size: float = 0.08

	create_box(
		"DoorTopFrame",
		Vector3(door_width, frame_size, door_thickness + 0.03),
		Vector3(center.x, center.y + door_height / 2.0 - frame_size / 2.0, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorBottomFrame",
		Vector3(door_width, frame_size, door_thickness + 0.03),
		Vector3(center.x, center.y - door_height / 2.0 + frame_size / 2.0, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorLeftFrame",
		Vector3(frame_size, door_height, door_thickness + 0.03),
		Vector3(center.x - door_width / 2.0 + frame_size / 2.0, center.y, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorRightFrame",
		Vector3(frame_size, door_height, door_thickness + 0.03),
		Vector3(center.x + door_width / 2.0 - frame_size / 2.0, center.y, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorMiddleLine",
		Vector3(door_width - 0.15, 0.045, door_thickness + 0.04),
		Vector3(center.x, center.y, center.z),
		door_line_material,
		root
	)

	create_box(
		"DoorHandle",
		Vector3(0.12, 0.12, door_thickness + 0.06),
		Vector3(center.x + door_width * 0.22, center.y, center.z),
		door_handle_material,
		root
	)


func create_closed_door_details_z(
	root: Node3D,
	center: Vector3,
	door_width: float,
	door_height: float,
	door_thickness: float
) -> void:
	var frame_size: float = 0.08

	create_box(
		"DoorTopFrame",
		Vector3(door_thickness + 0.03, frame_size, door_width),
		Vector3(center.x, center.y + door_height / 2.0 - frame_size / 2.0, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorBottomFrame",
		Vector3(door_thickness + 0.03, frame_size, door_width),
		Vector3(center.x, center.y - door_height / 2.0 + frame_size / 2.0, center.z),
		door_frame_material,
		root
	)

	create_box(
		"DoorLeftFrame",
		Vector3(door_thickness + 0.03, door_height, frame_size),
		Vector3(center.x, center.y, center.z - door_width / 2.0 + frame_size / 2.0),
		door_frame_material,
		root
	)

	create_box(
		"DoorRightFrame",
		Vector3(door_thickness + 0.03, door_height, frame_size),
		Vector3(center.x, center.y, center.z + door_width / 2.0 - frame_size / 2.0),
		door_frame_material,
		root
	)

	create_box(
		"DoorMiddleLine",
		Vector3(door_thickness + 0.04, 0.045, door_width - 0.15),
		Vector3(center.x, center.y, center.z),
		door_line_material,
		root
	)

	create_box(
		"DoorHandle",
		Vector3(door_thickness + 0.06, 0.12, 0.12),
		Vector3(center.x, center.y, center.z + door_width * 0.22),
		door_handle_material,
		root
	)


func create_open_door_tile(cell: Vector2i) -> void:
	var root: Node3D = create_door_visual_root(cell)
	var orientation: String = get_door_orientation(cell)
	var center: Vector3 = get_door_center(cell)

	var door_width: float = cell_size * current_theme.door_width_ratio
	var door_height: float = current_theme.door_height
	var door_thickness: float = current_theme.door_thickness
	var open_offset: float = cell_size * current_theme.door_open_offset_ratio

	if orientation == "x":
		create_box(
			"OpenDoorPanelLeft",
			Vector3(door_thickness, door_height, door_width * 0.45),
			Vector3(center.x - open_offset, center.y, center.z),
			door_material,
			root
		)

		create_box(
			"OpenDoorPanelRight",
			Vector3(door_thickness, door_height, door_width * 0.45),
			Vector3(center.x + open_offset, center.y, center.z),
			door_material,
			root
		)

		create_box(
			"OpenDoorFrameLeft",
			Vector3(door_thickness + 0.03, door_height, 0.08),
			Vector3(center.x - open_offset, center.y, center.z),
			door_frame_material,
			root
		)

		create_box(
			"OpenDoorFrameRight",
			Vector3(door_thickness + 0.03, door_height, 0.08),
			Vector3(center.x + open_offset, center.y, center.z),
			door_frame_material,
			root
		)
	else:
		create_box(
			"OpenDoorPanelLeft",
			Vector3(door_width * 0.45, door_height, door_thickness),
			Vector3(center.x, center.y, center.z - open_offset),
			door_material,
			root
		)

		create_box(
			"OpenDoorPanelRight",
			Vector3(door_width * 0.45, door_height, door_thickness),
			Vector3(center.x, center.y, center.z + open_offset),
			door_material,
			root
		)

		create_box(
			"OpenDoorFrameLeft",
			Vector3(0.08, door_height, door_thickness + 0.03),
			Vector3(center.x, center.y, center.z - open_offset),
			door_frame_material,
			root
		)

		create_box(
			"OpenDoorFrameRight",
			Vector3(0.08, door_height, door_thickness + 0.03),
			Vector3(center.x, center.y, center.z + open_offset),
			door_frame_material,
			root
		)


# ------------------------------------------------------------
# MARQUEURS DE DÉCOUVERTE
# ------------------------------------------------------------

func create_ability_discovery_markers(
	ability_discovery_locations: Dictionary
) -> void:
	ability_discovery_markers.clear()

	for cell_key in ability_discovery_locations.keys():
		var cell: Vector2i = cell_key

		var marker_position: Vector3 = Vector3(
			float(cell.x) * cell_size,
			current_theme.floor_y + 0.09,
			float(cell.y) * cell_size
		)

		var marker: MeshInstance3D = create_box(
			"RuneMarker",
			Vector3(0.6, 0.06, 0.6),
			marker_position,
			rune_material
		)

		ability_discovery_markers[cell] = marker


func hide_discovery_marker(cell: Vector2i) -> void:
	if not ability_discovery_markers.has(cell):
		return

	var marker = ability_discovery_markers[cell]

	if marker != null:
		marker.visible = false


# ------------------------------------------------------------
# LECTURE DE LA CARTE
# ------------------------------------------------------------

func is_wall_cell(cell: Vector2i) -> bool:
	if cell.y < 0 or cell.y >= current_layout.size():
		return true

	if cell.x < 0 or cell.x >= current_layout[cell.y].length():
		return true

	var tile: String = current_layout[cell.y].substr(cell.x, 1)

	return tile == "#"
