extends Panel
class_name CommandOverlayUI
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

# ------------------------------------------------------------
# SIGNAUX
# ------------------------------------------------------------

signal exploration_command_pressed(command_id: String)
signal combat_command_pressed(command_index: int)

# ------------------------------------------------------------
# CONSTANTES
# ------------------------------------------------------------

const EXPLORATION_COMMAND_FORWARD: String = "move_forward"
const EXPLORATION_COMMAND_BACK: String = "move_back"
const EXPLORATION_COMMAND_TURN_LEFT: String = "turn_left"
const EXPLORATION_COMMAND_TURN_RIGHT: String = "turn_right"
const EXPLORATION_COMMAND_MENU: String = "menu"

const BUTTON_MIN_SIZE: Vector2 = Vector2(94, 30)
const MENU_BUTTON_MIN_SIZE: Vector2 = Vector2(78, 30)

# ------------------------------------------------------------
# RÉFÉRENCES UI
# ------------------------------------------------------------

var commands_box: HBoxContainer = null

# ------------------------------------------------------------
# ÉTAT
# ------------------------------------------------------------

var ui_built: bool = false

# ------------------------------------------------------------
# INITIALISATION
# ------------------------------------------------------------

func _ready() -> void:
	build_ui()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	# L'overlay doit recevoir la souris pour rendre les commandes cliquables.
	mouse_filter = Control.MOUSE_FILTER_STOP

	# Le conteneur des commandes reste invisible.
	# Les boutons portent maintenant leur propre cadre texturé, donc le
	# long panneau de fond n'est plus nécessaire visuellement.
	add_theme_stylebox_override("panel", StyleBoxEmpty.new())

	anchor_left = 0.08
	anchor_top = 1.0
	anchor_right = 0.92
	anchor_bottom = 1.0
	offset_left = 0
	offset_top = -58
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
	commands_box.add_theme_constant_override("separation", 6)
	add_child(commands_box)

# ------------------------------------------------------------
# COMMANDES D'EXPLORATION
# ------------------------------------------------------------

func show_exploration_commands() -> void:
	ensure_ui_ready()

	visible = true
	clear_container(commands_box)

	add_exploration_command_button("Z ↑ Avancer", EXPLORATION_COMMAND_FORWARD, BUTTON_MIN_SIZE)
	add_exploration_command_button("S ↓ Reculer", EXPLORATION_COMMAND_BACK, BUTTON_MIN_SIZE)
	add_exploration_command_button("Q ← Tourner", EXPLORATION_COMMAND_TURN_LEFT, BUTTON_MIN_SIZE)
	add_exploration_command_button("D → Tourner", EXPLORATION_COMMAND_TURN_RIGHT, BUTTON_MIN_SIZE)
	add_exploration_command_button("E Menu", EXPLORATION_COMMAND_MENU, MENU_BUTTON_MIN_SIZE)


func add_exploration_command_button(
	button_text: String,
	command_id: String,
	minimum_size: Vector2 = BUTTON_MIN_SIZE
) -> void:
	var button: Button = create_command_button(button_text, false, minimum_size)
	button.pressed.connect(on_exploration_button_pressed.bind(command_id))
	commands_box.add_child(button)


func on_exploration_button_pressed(command_id: String) -> void:
	# Le signal du bouton Godot verrouille temporairement le contrôle cliqué.
	# On diffère donc la commande pour éviter de reconstruire l'overlay
	# pendant que le bouton est encore en cours d'émission.
	call_deferred("emit_exploration_command_pressed", command_id)


func emit_exploration_command_pressed(command_id: String) -> void:
	exploration_command_pressed.emit(command_id)

# ------------------------------------------------------------
# COMMANDES DE COMBAT
# ------------------------------------------------------------

func show_combat_commands(
	commands: Array[String],
	selected_command_index: int
) -> void:
	ensure_ui_ready()

	visible = true
	clear_container(commands_box)

	for i in range(commands.size()):
		var selected: bool = i == selected_command_index
		add_combat_command_button(commands[i], i, selected)


func add_combat_command_button(
	button_text: String,
	command_index: int,
	selected: bool
) -> void:
	var button: Button = create_command_button(button_text, selected, BUTTON_MIN_SIZE)
	button.pressed.connect(on_combat_button_pressed.bind(command_index))
	commands_box.add_child(button)


func on_combat_button_pressed(command_index: int) -> void:
	# Même logique que pour l'exploration : le clic est relayé après
	# la fin du callback du bouton, ce qui sécurise les rafraîchissements UI.
	call_deferred("emit_combat_command_pressed", command_index)


func emit_combat_command_pressed(command_index: int) -> void:
	combat_command_pressed.emit(command_index)

# ------------------------------------------------------------
# VISIBILITÉ
# ------------------------------------------------------------

func hide_commands() -> void:
	visible = false

# ------------------------------------------------------------
# FABRIQUE UI
# ------------------------------------------------------------

func create_command_button(
	button_text: String,
	selected: bool,
	minimum_size: Vector2
) -> Button:
	var panel_color: Color = Color(0.10, 0.065, 0.035, 0.95)
	var border_color: Color = Color(0.32, 0.20, 0.08, 1.0)
	var text_color: Color = Color(0.86, 0.78, 0.58)

	if selected:
		panel_color = Color(0.28, 0.16, 0.06, 0.98)
		border_color = Color(1.0, 0.78, 0.22, 1.0)
		text_color = Color(1.0, 0.92, 0.42)

	var button: Button = Button.new()
	button.text = button_text
	button.custom_minimum_size = minimum_size
	button.focus_mode = Control.FOCUS_NONE
	button.mouse_filter = Control.MOUSE_FILTER_STOP
	button.alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.add_theme_font_size_override("font_size", 14)
	button.add_theme_color_override("font_color", text_color)
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.96, 0.72))

	button.add_theme_stylebox_override(
		"normal",
		UIFrameStyleScript.create_button_style(panel_color, border_color, 2)
	)
	button.add_theme_stylebox_override(
		"hover",
		UIFrameStyleScript.create_button_style(
			Color(panel_color.r + 0.04, panel_color.g + 0.03, panel_color.b + 0.02, panel_color.a),
			Color(0.78, 0.50, 0.16, 1.0),
			2
		)
	)
	button.add_theme_stylebox_override(
		"pressed",
		UIFrameStyleScript.create_button_style(
			Color(0.36, 0.21, 0.08, 0.98),
			Color(1.0, 0.78, 0.22, 1.0),
			2
		)
	)
	button.add_theme_stylebox_override(
		"disabled",
		UIFrameStyleScript.create_button_style(Color(0.06, 0.04, 0.03, 0.80), Color(0.18, 0.12, 0.06, 1.0), 2)
	)

	return button


# ------------------------------------------------------------
# OUTILS
# ------------------------------------------------------------

func clear_container(container: Node) -> void:
	if container == null:
		return

	for child in container.get_children():
		child.free()


func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
