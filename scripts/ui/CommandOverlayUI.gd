extends Panel
class_name CommandOverlayUI

var commands_box: HBoxContainer = null

var ui_built: bool = false


func _ready() -> void:
	build_ui()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	mouse_filter = Control.MOUSE_FILTER_IGNORE

	add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.045, 0.030, 0.020, 0.88),
			Color(0.55, 0.34, 0.12, 1.0),
			2
		)
	)

	anchor_left = 0.12
	anchor_top = 1.0
	anchor_right = 0.88
	anchor_bottom = 1.0
	offset_left = 0
	offset_top = -54
	offset_right = 0
	offset_bottom = -12

	commands_box = HBoxContainer.new()
	commands_box.name = "CommandsBox"
	commands_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	commands_box.offset_left = 8
	commands_box.offset_top = 6
	commands_box.offset_right = -8
	commands_box.offset_bottom = -6
	commands_box.alignment = BoxContainer.ALIGNMENT_CENTER
	commands_box.add_theme_constant_override("separation", 8)
	add_child(commands_box)


func show_exploration_commands() -> void:
	ensure_ui_ready()

	visible = true
	clear_container(commands_box)

	add_command_label("↑ Avancer", false)
	add_command_label("↓ Reculer", false)
	add_command_label("← Tourner", false)
	add_command_label("→ Tourner", false)


func show_combat_commands(
	commands: Array[String],
	selected_command_index: int
) -> void:
	ensure_ui_ready()

	visible = true
	clear_container(commands_box)

	for i in range(commands.size()):
		var selected: bool = i == selected_command_index
		add_command_label(commands[i], selected)


func hide_commands() -> void:
	visible = false


func add_command_label(command_text: String, selected: bool) -> void:
	var panel_color: Color = Color(0.10, 0.065, 0.035, 0.95)
	var border_color: Color = Color(0.32, 0.20, 0.08, 1.0)
	var text_color: Color = Color(0.86, 0.78, 0.58)

	if selected:
		panel_color = Color(0.28, 0.16, 0.06, 0.98)
		border_color = Color(1.0, 0.78, 0.22, 1.0)
		text_color = Color(1.0, 0.92, 0.42)

	var command_panel: Panel = Panel.new()
	command_panel.custom_minimum_size = Vector2(90, 30)
	command_panel.add_theme_stylebox_override(
		"panel",
		create_panel_style(
			panel_color,
			border_color,
			2
		)
	)

	commands_box.add_child(command_panel)

	var label: Label = Label.new()
	label.text = command_text
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 14)
	label.add_theme_color_override("font_color", text_color)
	command_panel.add_child(label)


func create_panel_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBoxFlat:
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = background_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.corner_radius_top_left = 2
	style.corner_radius_top_right = 2
	style.corner_radius_bottom_left = 2
	style.corner_radius_bottom_right = 2

	return style


func clear_container(container: Node) -> void:
	if container == null:
		return

	for child in container.get_children():
		child.free()


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
