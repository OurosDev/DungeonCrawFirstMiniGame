extends Panel
class_name LogPanelUI
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

# ------------------------------------------------------------
# CONSTANTES
# ------------------------------------------------------------
const LOG_ALL: String = "all"
const LOG_JOURNAL: String = "journal"
const LOG_COMBAT: String = "combat"
const LOG_SYSTEM: String = "system"

const TONE_DEFAULT: String = "default"
const TONE_SYSTEM: String = "system"
const TONE_COMBAT: String = "combat"
const TONE_ENEMY_DAMAGE: String = "enemy_damage"
const TONE_IMPORTANT: String = "important"
const TONE_MAGIC: String = "magic"
const TONE_HEAL: String = "heal"
const TONE_WARNING: String = "warning"

const ENEMY_LOG_NAME_PREFIXES: Array[String] = [
	"zombie",
	"gobelin",
	"chauve-souris",
	"chauve souris",
	"troll",
	"gardien"
]

# ------------------------------------------------------------
# NŒUDS UI
# ------------------------------------------------------------
var tabs_container: HBoxContainer = null
var log_text: RichTextLabel = null
var log_tab_buttons: Dictionary = {}

# ------------------------------------------------------------
# ÉTAT
# ------------------------------------------------------------
var selected_log_channel: String = LOG_JOURNAL
var log_entries: Array = []
var last_message_by_channel: Dictionary = {}
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

	add_theme_stylebox_override(
		"panel",
		create_panel_style(
			Color(0.075, 0.045, 0.025, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			2
		)
	)

	var log_box: VBoxContainer = VBoxContainer.new()
	log_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	log_box.offset_left = 8
	log_box.offset_top = 6
	log_box.offset_right = -8
	log_box.offset_bottom = -8
	log_box.add_theme_constant_override("separation", 6)
	add_child(log_box)

	tabs_container = HBoxContainer.new()
	tabs_container.name = "LogTabs"
	tabs_container.custom_minimum_size = Vector2(0, 28)
	tabs_container.add_theme_constant_override("separation", 5)
	log_box.add_child(tabs_container)

	add_log_tab_button(LOG_ALL, "Tous")
	add_log_tab_button(LOG_JOURNAL, "Journal")
	add_log_tab_button(LOG_COMBAT, "Combat")
	add_log_tab_button(LOG_SYSTEM, "Système")

	log_text = RichTextLabel.new()
	log_text.name = "LogText"
	log_text.size_flags_vertical = Control.SIZE_EXPAND_FILL
	log_text.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	log_text.bbcode_enabled = true
	log_text.scroll_following = true
	log_text.fit_content = false
	log_text.add_theme_font_size_override("normal_font_size", 16)
	log_text.add_theme_color_override("default_color", Color(0.94, 0.86, 0.68))
	log_text.add_theme_color_override("font_shadow_color", Color(0.0, 0.0, 0.0, 0.75))
	log_text.add_theme_constant_override("shadow_offset_x", 1)
	log_text.add_theme_constant_override("shadow_offset_y", 1)
	log_box.add_child(log_text)

	update_log_tab_buttons()
	update_log_display()

# ------------------------------------------------------------
# ONGLETS
# ------------------------------------------------------------
func add_log_tab_button(channel: String, button_text: String) -> void:
	var button: Button = Button.new()
	button.text = button_text
	button.toggle_mode = true
	button.focus_mode = Control.FOCUS_NONE
	button.custom_minimum_size = Vector2(82, 24)
	button.add_theme_font_size_override("font_size", 13)
	apply_button_style(button)
	button.pressed.connect(_on_log_tab_pressed.bind(channel))
	tabs_container.add_child(button)
	log_tab_buttons[channel] = button


func _on_log_tab_pressed(channel: String) -> void:
	set_log_channel(channel)


func set_log_channel(channel: String) -> void:
	selected_log_channel = channel
	update_log_tab_buttons()
	update_log_display()


func update_log_tab_buttons() -> void:
	for channel in log_tab_buttons.keys():
		var button: Button = log_tab_buttons[channel]
		if button != null:
			button.button_pressed = channel == selected_log_channel

# ------------------------------------------------------------
# AJOUT DE MESSAGES
# ------------------------------------------------------------
func add_system_message(message: String) -> void:
	add_log_message(LOG_SYSTEM, message)


func add_journal_message(message: String) -> void:
	add_log_message(LOG_JOURNAL, message)


func add_combat_message(message: String) -> void:
	add_log_message(LOG_COMBAT, message)


func add_log_message(channel: String, message: String) -> void:
	var clean_message: String = message.strip_edges()
	if clean_message == "":
		return

	if last_message_by_channel.has(channel):
		if last_message_by_channel[channel] == clean_message:
			return

	last_message_by_channel[channel] = clean_message

	log_entries.append({
		"channel": channel,
		"message": clean_message,
		"tone": detect_log_tone(channel, clean_message)
	})

	while log_entries.size() > 120:
		log_entries.remove_at(0)

	update_log_display()

# ------------------------------------------------------------
# AFFICHAGE
# ------------------------------------------------------------
func update_log_display() -> void:
	if log_text == null:
		return

	var text: String = build_visible_log_text()
	if text == "":
		text = "Aucun message."

	log_text.text = text


func build_visible_log_text() -> String:
	var result: String = ""
	var added_count: int = 0

	for entry in log_entries:
		var channel: String = str(entry.get("channel", LOG_JOURNAL))
		var message: String = str(entry.get("message", ""))
		var tone: String = str(entry.get("tone", detect_log_tone(channel, message)))

		if selected_log_channel != LOG_ALL:
			if channel != selected_log_channel:
				continue

		if added_count > 0:
			result += "\n\n"

		if selected_log_channel == LOG_ALL:
			result += format_log_prefix(channel) + " "

		result += format_log_message(message, tone, channel)
		added_count += 1

	return result


func format_log_prefix(channel: String) -> String:
	var prefix_text: String = get_log_prefix(channel)
	var prefix_color: String = "#9E8A68"

	if channel == LOG_JOURNAL:
		prefix_color = "#D8C28C"
	elif channel == LOG_COMBAT:
		prefix_color = "#E7A15B"
	elif channel == LOG_SYSTEM:
		prefix_color = "#9DB8E8"

	return "[color=" + prefix_color + "]" + escape_bbcode_text(prefix_text) + "[/color]"


func format_log_message(message: String, tone: String, channel: String = LOG_JOURNAL) -> String:
	# Le canal Combat peut contenir plusieurs lignes dans une seule entrée
	# héroïque + riposte ennemie. On colore donc ligne par ligne.
	if channel == LOG_COMBAT:
		return format_multiline_combat_message(message)

	return format_colored_log_line(message, tone)


func format_multiline_combat_message(message: String) -> String:
	var formatted_lines: Array[String] = []
	var raw_lines: PackedStringArray = message.split("\n", false)

	for raw_line in raw_lines:
		var line: String = str(raw_line).strip_edges()
		if line == "":
			continue

		var line_tone: String = detect_log_tone(LOG_COMBAT, line)
		formatted_lines.append(format_colored_log_line(line, line_tone))

	return "\n".join(formatted_lines)


func format_colored_log_line(message: String, tone: String) -> String:
	var color_hex: String = get_tone_color(tone)
	return "[color=" + color_hex + "]" + escape_bbcode_text(message) + "[/color]"


func get_log_prefix(channel: String) -> String:
	if channel == LOG_JOURNAL:
		return "Journal —"
	if channel == LOG_COMBAT:
		return "Combat —"
	if channel == LOG_SYSTEM:
		return "Système —"
	return "Info —"


func escape_bbcode_text(value: String) -> String:
	# Godot 4 ne fournit pas String.escape_bbcode().
	# On remplace les crochets par les balises littérales reconnues par RichTextLabel.
	var escaped_value: String = value
	escaped_value = escaped_value.replace("[", "__SAS_BBCODE_LEFT_BRACKET__")
	escaped_value = escaped_value.replace("]", "__SAS_BBCODE_RIGHT_BRACKET__")
	escaped_value = escaped_value.replace("__SAS_BBCODE_LEFT_BRACKET__", "[lb]")
	escaped_value = escaped_value.replace("__SAS_BBCODE_RIGHT_BRACKET__", "[rb]")
	return escaped_value

# ------------------------------------------------------------
# CANAUX ET COULEURS
# Détecte les messages importants sans créer de journal de quête.
# ------------------------------------------------------------
func detect_log_channel(message: String, default_channel: String) -> String:
	var lower_text: String = message.to_lower()

	if lower_text.contains("grimoire"):
		return LOG_JOURNAL
	if lower_text.contains("hors combat"):
		return LOG_JOURNAL

	if lower_text.contains("attaque"):
		return LOG_COMBAT
	if lower_text.contains("dégâts"):
		return LOG_COMBAT
	if lower_text.contains("combat"):
		return LOG_COMBAT
	if lower_text.contains("vaincu"):
		return LOG_COMBAT
	if lower_text.contains("exp"):
		return LOG_COMBAT
	if lower_text.contains("lance"):
		return LOG_COMBAT
	if lower_text.contains("soin"):
		return LOG_COMBAT
	if lower_text.contains("tour de"):
		return LOG_COMBAT
	if lower_text.contains("apparaît"):
		return LOG_COMBAT
	if lower_text.contains("découvre"):
		return LOG_JOURNAL
	if lower_text.contains("trouvez"):
		return LOG_JOURNAL
	if lower_text.contains("rune"):
		return LOG_JOURNAL
	if lower_text.contains("donjon"):
		return LOG_JOURNAL

	return default_channel


func detect_log_tone(channel: String, message: String) -> String:
	var lower_text: String = message.to_lower()

	if channel == LOG_SYSTEM:
		return TONE_SYSTEM

	if is_warning_message(lower_text):
		return TONE_WARNING

	if channel == LOG_COMBAT:
		if is_heal_message(lower_text):
			return TONE_HEAL
		if is_enemy_damage_message(lower_text):
			return TONE_ENEMY_DAMAGE
		return TONE_COMBAT

	if is_heal_message(lower_text):
		return TONE_HEAL

	if lower_text.contains("clé"):
		return TONE_IMPORTANT
	if lower_text.contains("déverrouille"):
		return TONE_IMPORTANT
	if lower_text.contains("gardien"):
		return TONE_IMPORTANT
	if lower_text.contains("passage"):
		return TONE_IMPORTANT
	if lower_text.contains("objet clé"):
		return TONE_IMPORTANT

	if lower_text.contains("inscription"):
		return TONE_MAGIC
	if lower_text.contains("voix"):
		return TONE_MAGIC
	if lower_text.contains("traces anciennes"):
		return TONE_MAGIC
	if lower_text.contains("présence puissante"):
		return TONE_MAGIC
	if lower_text.contains("rune"):
		return TONE_MAGIC
	if lower_text.contains("symbole sacré"):
		return TONE_MAGIC
	if lower_text.contains("découvre le sort"):
		return TONE_MAGIC

	return TONE_DEFAULT


func is_warning_message(lower_text: String) -> bool:
	if lower_text.contains("impossible"):
		return true
	if lower_text.contains("verrouillée"):
		return true
	if lower_text.contains("introuvable"):
		return true
	if lower_text.contains("plein"):
		return true
	if lower_text.contains("maximum de pv"):
		return true
	if lower_text.contains("pm insuffisants"):
		return true
	if lower_text.contains("n'a pas assez"):
		return true
	if lower_text.contains("ne connaît aucun"):
		return true
	if lower_text.contains("ne peut pas"):
		return true
	if lower_text.contains("aucun héros"):
		return true
	return false


func is_heal_message(lower_text: String) -> bool:
	if lower_text.contains("récupère") and (lower_text.contains(" pv") or lower_text.contains(" hp")):
		return true
	if lower_text.contains("lance") and lower_text.contains("soin"):
		return true
	if lower_text.contains("grimoire") and lower_text.contains("soin"):
		return true
	if lower_text.contains("se recueille au temple"):
		return true
	return false


func is_enemy_damage_message(lower_text: String) -> bool:
	if lower_text.contains(" frappe ") and lower_text.contains(" dégâts"):
		return true
	if lower_text.contains(" attaque ") and lower_text.contains(", mais") and lower_text.contains(" esquive"):
		return starts_with_known_enemy_name(lower_text)
	return false


func starts_with_known_enemy_name(lower_text: String) -> bool:
	for enemy_prefix in ENEMY_LOG_NAME_PREFIXES:
		if lower_text.begins_with(enemy_prefix + " "):
			return true
	return false


func get_tone_color(tone: String) -> String:
	if tone == TONE_SYSTEM:
		return "#AFC8FF"
	if tone == TONE_COMBAT:
		return "#FFB06A"
	if tone == TONE_ENEMY_DAMAGE:
		return "#FF6E5F"
	if tone == TONE_IMPORTANT:
		return "#FFD766"
	if tone == TONE_MAGIC:
		return "#9FD3FF"
	if tone == TONE_HEAL:
		return "#8FEA83"
	if tone == TONE_WARNING:
		return "#FF7C5F"
	return "#F0DCAD"

# ------------------------------------------------------------
# STYLE
# ------------------------------------------------------------
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


func apply_button_style(button: Button) -> void:
	button.add_theme_stylebox_override(
		"normal",
		UIFrameStyleScript.create_button_style(
			Color(0.11, 0.07, 0.04, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
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
		"hover",
		UIFrameStyleScript.create_button_style(
			Color(0.18, 0.10, 0.05, 1.0),
			Color(0.55, 0.34, 0.13, 1.0),
			1
		)
	)

	button.add_theme_color_override("font_color", Color(0.90, 0.80, 0.58))
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.92, 0.48))
