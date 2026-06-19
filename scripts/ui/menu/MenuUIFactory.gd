extends RefCounted
class_name MenuUIFactory

# ------------------------------------------------------------
# DÉPENDANCES
# Utilise le helper commun NineSlice pour harmoniser les menus.
# ------------------------------------------------------------

const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")


# ------------------------------------------------------------
# FABRIQUE UI COMMUNE
# Centralise les contrôles visuels réutilisés par les écrans du menu en jeu.
# ------------------------------------------------------------

static func clear_content(content_box: VBoxContainer) -> void:
	if content_box == null:
		return

	for child in content_box.get_children():
		child.queue_free()


static func create_menu_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(260, 42)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 17)

	apply_menu_button_style(button)

	return button


static func create_compact_menu_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(200, 28)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 13)

	apply_menu_button_style(button)

	return button


static func create_label(
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


static func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	var panel: Panel = Panel.new()

	# Le Theme est posé sur chaque panneau pour que les boutons créés
	# directement dans les vues de menu héritent aussi du rendu texturé.
	panel.theme = UIFrameStyleScript.create_menu_theme()
	panel.add_theme_stylebox_override(
		"panel",
		UIFrameStyleScript.create_panel_style(
			background_color,
			border_color,
			border_width
		)
	)

	return panel


static func create_scrollable_list_inside_panel(panel: Panel) -> VBoxContainer:
	var list_margin: MarginContainer = MarginContainer.new()
	list_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	list_margin.add_theme_constant_override("margin_left", 14)
	list_margin.add_theme_constant_override("margin_top", 12)
	list_margin.add_theme_constant_override("margin_right", 14)
	list_margin.add_theme_constant_override("margin_bottom", 12)
	panel.add_child(list_margin)

	var scroll: ScrollContainer = ScrollContainer.new()
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.vertical_scroll_mode = ScrollContainer.SCROLL_MODE_AUTO
	list_margin.add_child(scroll)

	var list: VBoxContainer = VBoxContainer.new()
	list.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	list.add_theme_constant_override("separation", 4)
	scroll.add_child(list)

	return list


static func create_empty_message_label(text: String) -> Label:
	var empty_label: Label = create_label(text, 14, Color(0.62, 0.56, 0.46))
	empty_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	empty_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	empty_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	empty_label.custom_minimum_size = Vector2(0, 44)

	return empty_label


# ------------------------------------------------------------
# STYLE DES BOUTONS
# Applique la texture aux boutons créés par la fabrique.
# Les autres boutons héritent du Theme posé sur les panneaux.
# ------------------------------------------------------------

static func apply_menu_button_style(button: Button) -> void:
	if button == null:
		return

	button.add_theme_stylebox_override(
		"normal",
		UIFrameStyleScript.create_button_style(
			Color(0.11, 0.07, 0.04, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			1
		)
	)

	button.add_theme_stylebox_override(
		"hover",
		UIFrameStyleScript.create_button_style(
			Color(0.18, 0.10, 0.05, 1.0),
			Color(0.55, 0.34, 0.13, 1.0),
			1
		)
	)

	button.add_theme_stylebox_override(
		"pressed",
		UIFrameStyleScript.create_button_style(
			Color(0.28, 0.16, 0.06, 1.0),
			Color(0.95, 0.72, 0.28, 1.0),
			2
		)
	)

	button.add_theme_stylebox_override(
		"focus",
		UIFrameStyleScript.create_button_style(
			Color(0.20, 0.12, 0.05, 1.0),
			Color(0.86, 0.62, 0.20, 1.0),
			2
		)
	)

	button.add_theme_stylebox_override(
		"disabled",
		UIFrameStyleScript.create_button_style(
			Color(0.06, 0.04, 0.03, 0.80),
			Color(0.18, 0.12, 0.06, 1.0),
			1
		)
	)

	button.add_theme_color_override("font_color", Color(0.90, 0.80, 0.58))
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.92, 0.48))
	button.add_theme_color_override("font_focus_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_disabled_color", Color(0.42, 0.36, 0.28))
