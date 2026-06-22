extends RefCounted
class_name DevTeleportMenuView

# ------------------------------------------------------------
# VERSION SCRIPT
# v0.13.1-DevFlags
# ------------------------------------------------------------

# ------------------------------------------------------------
# VUE TÉLÉPORTATION DEV
# Construit l'outil temporaire de déplacement rapide pour les tests de layout.
# La disponibilité est contrôlée par scripts/core/BuildFlags.gd.
# ------------------------------------------------------------

const BuildFlagsScript = preload("res://scripts/core/BuildFlags.gd")


# ------------------------------------------------------------
# ÉTAT DU FLAG
# Centralise le test pour éviter les copies de conditions.
# ------------------------------------------------------------
static func is_dev_teleport_enabled() -> bool:
	return BuildFlagsScript.DEV_TELEPORT_ENABLED


# ------------------------------------------------------------
# BOUTON D'ACCÈS
# Crée le petit bouton carré "T" affiché en haut à gauche du menu.
# ------------------------------------------------------------
static func create_dev_teleport_button(owner) -> void:
	if not is_dev_teleport_enabled():
		if owner.dev_teleport_button != null:
			owner.dev_teleport_button.visible = false
		return

	if owner.dev_teleport_button != null:
		owner.dev_teleport_button.visible = true
		return

	owner.dev_teleport_button = Button.new()
	owner.dev_teleport_button.name = "DevTeleportButton"
	owner.dev_teleport_button.text = "T"
	owner.dev_teleport_button.focus_mode = Control.FOCUS_NONE
	owner.dev_teleport_button.custom_minimum_size = Vector2(34, 34)
	owner.dev_teleport_button.add_theme_font_size_override("font_size", 14)
	owner.dev_teleport_button.tooltip_text = "Téléportation de test"

	owner.dev_teleport_button.anchor_left = 0.0
	owner.dev_teleport_button.anchor_top = 0.0
	owner.dev_teleport_button.anchor_right = 0.0
	owner.dev_teleport_button.anchor_bottom = 0.0
	owner.dev_teleport_button.offset_left = 8
	owner.dev_teleport_button.offset_top = 8
	owner.dev_teleport_button.offset_right = 42
	owner.dev_teleport_button.offset_bottom = 42

	owner.dev_teleport_button.pressed.connect(Callable(owner, "show_dev_teleport_screen"))
	owner.root_panel.add_child(owner.dev_teleport_button)


# ------------------------------------------------------------
# ÉCRAN DE TÉLÉPORTATION
# Affiche un écran simple permettant de saisir une coordonnée X/Y.
# ------------------------------------------------------------
static func show_dev_teleport_screen(owner) -> void:
	if not is_dev_teleport_enabled():
		return

	owner.set_menu_chrome_visible(false)
	owner.clear_content()

	var wrapper: VBoxContainer = VBoxContainer.new()
	wrapper.custom_minimum_size = Vector2(360, 280)
	wrapper.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	wrapper.alignment = BoxContainer.ALIGNMENT_CENTER
	wrapper.add_theme_constant_override("separation", 10)
	owner.content_box.add_child(wrapper)

	var title: Label = owner.create_label(
		"TÉLÉPORTATION TEST",
		18,
		Color(1.0, 0.82, 0.35)
	)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(title)

	var current_position: Vector2i = owner.get_dev_current_player_cell()
	var current_label: Label = owner.create_label(
		"Position actuelle : X "
		+ str(current_position.x)
		+ " / Y "
		+ str(current_position.y),
		13,
		Color(0.82, 0.74, 0.56)
	)
	current_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	current_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(current_label)

	var input_panel: Panel = owner.create_panel(
		Color(0.060, 0.040, 0.030, 1.0),
		Color(0.32, 0.21, 0.10, 1.0),
		1
	)
	input_panel.custom_minimum_size = Vector2(320, 92)
	input_panel.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	wrapper.add_child(input_panel)

	var input_box: VBoxContainer = VBoxContainer.new()
	input_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	input_box.offset_left = 14
	input_box.offset_top = 12
	input_box.offset_right = -14
	input_box.offset_bottom = -12
	input_box.add_theme_constant_override("separation", 8)
	input_panel.add_child(input_box)

	input_box.add_child(
		owner.create_dev_coordinate_row("X", true, current_position.x)
	)
	input_box.add_child(
		owner.create_dev_coordinate_row("Y", false, current_position.y)
	)

	owner.dev_teleport_feedback_label = owner.create_label(
		"Coordonnées de grille Vector2i(x, y).",
		12,
		Color(0.70, 0.62, 0.48)
	)
	owner.dev_teleport_feedback_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	owner.dev_teleport_feedback_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(owner.dev_teleport_feedback_label)

	var teleport_button: Button = owner.create_menu_button("Téléporter")
	teleport_button.custom_minimum_size = Vector2(220, 36)
	teleport_button.add_theme_font_size_override("font_size", 15)
	teleport_button.pressed.connect(Callable(owner, "on_dev_teleport_pressed"))
	wrapper.add_child(teleport_button)

	var back_button: Button = owner.create_compact_menu_button("Retour menu")
	back_button.pressed.connect(Callable(owner, "show_main_screen"))
	wrapper.add_child(back_button)

	var hint_label: Label = owner.create_label(
		"Outil temporaire de développement",
		11,
		Color(0.56, 0.50, 0.42)
	)
	hint_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	hint_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	wrapper.add_child(hint_label)


# ------------------------------------------------------------
# SAISIE X/Y
# Crée une ligne de saisie pour X ou Y.
# ------------------------------------------------------------
static func create_dev_coordinate_row(
	owner,
	label_text: String,
	is_x_input: bool,
	default_value: int
) -> Control:
	var row: HBoxContainer = HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	row.add_theme_constant_override("separation", 8)

	var label: Label = owner.create_label(label_text, 15, Color(0.95, 0.86, 0.62))
	label.custom_minimum_size = Vector2(28, 0)
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	row.add_child(label)

	var input: LineEdit = LineEdit.new()
	input.text = str(default_value)
	input.custom_minimum_size = Vector2(90, 26)
	input.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	input.placeholder_text = "0"
	input.alignment = HORIZONTAL_ALIGNMENT_CENTER
	input.max_length = 4
	input.focus_mode = Control.FOCUS_ALL
	row.add_child(input)

	if is_x_input:
		owner.dev_teleport_x_input = input
	else:
		owner.dev_teleport_y_input = input

	return row


# ------------------------------------------------------------
# POSITION COURANTE
# Renvoie la position actuelle du joueur si la scène courante l'expose.
# ------------------------------------------------------------
static func get_dev_current_player_cell(owner) -> Vector2i:
	if not is_dev_teleport_enabled():
		return Vector2i.ZERO

	var scene = owner.get_tree().current_scene
	if scene == null:
		return Vector2i.ZERO

	if not scene.has_method("get_debug_player_cell"):
		return Vector2i.ZERO

	return scene.get_debug_player_cell()


# ------------------------------------------------------------
# VALIDATION
# Valide les valeurs saisies et demande au donjon de déplacer le joueur.
# ------------------------------------------------------------
static func on_dev_teleport_pressed(owner) -> void:
	if not is_dev_teleport_enabled():
		set_dev_teleport_feedback(
			owner,
			"Téléportation désactivée pour cette build.",
			true
		)
		return

	if owner.dev_teleport_x_input == null or owner.dev_teleport_y_input == null:
		owner.set_dev_teleport_feedback("Champs de coordonnées introuvables.", true)
		return

	var x_text: String = owner.dev_teleport_x_input.text.strip_edges()
	var y_text: String = owner.dev_teleport_y_input.text.strip_edges()

	if not x_text.is_valid_int() or not y_text.is_valid_int():
		owner.set_dev_teleport_feedback("Coordonnées invalides.", true)
		return

	var target_cell: Vector2i = Vector2i(int(x_text), int(y_text))
	var scene = owner.get_tree().current_scene

	if scene == null or not scene.has_method("debug_teleport_to_cell"):
		owner.set_dev_teleport_feedback(
			"La scène courante ne permet pas la téléportation.",
			true
		)
		return

	var result: Dictionary = scene.debug_teleport_to_cell(target_cell)
	var success: bool = bool(result.get("success", false))
	var message: String = str(result.get("message", ""))

	if not success:
		owner.set_dev_teleport_feedback(message, true)
		return

	owner.set_dev_teleport_feedback(message, false)


# ------------------------------------------------------------
# FEEDBACK
# Affiche le résultat de validation dans l'écran de téléportation.
# ------------------------------------------------------------
static func set_dev_teleport_feedback(owner, text: String, is_error: bool) -> void:
	if owner.dev_teleport_feedback_label == null:
		return

	owner.dev_teleport_feedback_label.text = text

	if is_error:
		owner.dev_teleport_feedback_label.add_theme_color_override(
			"font_color",
			Color(1.0, 0.48, 0.35)
		)
	else:
		owner.dev_teleport_feedback_label.add_theme_color_override(
			"font_color",
			Color(0.70, 0.90, 0.60)
		)
