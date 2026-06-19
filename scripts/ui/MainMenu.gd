extends Control
class_name MainMenu

const PARTY_CREATION_SCENE_PATH: String = "res://scenes/PartyCreation.tscn"
const DUNGEON_SCENE_PATH: String = "res://scenes/Dungeon.tscn"
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

var root_panel: Panel = null
var main_box: VBoxContainer = null

var title_label: Label = null
var subtitle_label: Label = null
var info_label: Label = null

var new_game_button: Button = null
var load_button: Button = null
var options_button: Button = null
var quit_button: Button = null

var options_panel: Panel = null

var music_volume_label: Label = null
var music_volume_slider: HSlider = null

var sfx_volume_label: Label = null
var sfx_volume_slider: HSlider = null


func _ready() -> void:
	AudioManager.play_title_music()
	build_ui()
	update_load_button()


func build_ui() -> void:
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_STOP

	var background: ColorRect = ColorRect.new()
	background.name = "Background"
	background.color = Color(0.025, 0.018, 0.014, 1.0)
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	root_panel = create_panel(
		Color(0.055, 0.035, 0.025, 1.0),
		Color(0.42, 0.27, 0.12, 1.0),
		4
	)
	root_panel.name = "MainPanel"
	# Le menu principal n'a plus besoin d'un grand cadre autour du titre :
	# les boutons texturés suffisent à porter l'identité visuelle.
	root_panel.add_theme_stylebox_override("panel", StyleBoxEmpty.new())
	root_panel.anchor_left = 0.5
	root_panel.anchor_top = 0.5
	root_panel.anchor_right = 0.5
	root_panel.anchor_bottom = 0.5
	root_panel.offset_left = -260
	root_panel.offset_top = -230
	root_panel.offset_right = 260
	root_panel.offset_bottom = 230
	add_child(root_panel)

	main_box = VBoxContainer.new()
	main_box.name = "MainBox"
	main_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	main_box.offset_left = 32
	main_box.offset_top = 28
	main_box.offset_right = -32
	main_box.offset_bottom = -28
	main_box.alignment = BoxContainer.ALIGNMENT_CENTER
	main_box.add_theme_constant_override("separation", 14)
	root_panel.add_child(main_box)

	title_label = create_label(
		"DONJON DES SERPENTS",
		30,
		Color(1.0, 0.82, 0.35)
	)
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(title_label)

	subtitle_label = create_label(
		"Exploration • Magie • Survie",
		15,
		Color(0.70, 0.62, 0.48)
	)
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(subtitle_label)

	var spacer_1: Control = Control.new()
	spacer_1.custom_minimum_size = Vector2(0, 24)
	main_box.add_child(spacer_1)

	new_game_button = create_menu_button("Nouvelle partie")
	new_game_button.pressed.connect(on_new_game_pressed)
	main_box.add_child(new_game_button)

	load_button = create_menu_button("Charger")
	load_button.pressed.connect(on_load_pressed)
	main_box.add_child(load_button)

	options_button = create_menu_button("Options")
	options_button.pressed.connect(on_options_pressed)
	main_box.add_child(options_button)

	quit_button = create_menu_button("Quitter")
	quit_button.pressed.connect(on_quit_pressed)
	main_box.add_child(quit_button)

	var spacer_2: Control = Control.new()
	spacer_2.custom_minimum_size = Vector2(0, 16)
	main_box.add_child(spacer_2)

	info_label = create_label(
		"",
		14,
		Color(0.74, 0.66, 0.50)
	)
	info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	main_box.add_child(info_label)

	build_options_panel()


func build_options_panel() -> void:
	options_panel = create_panel(
		Color(0.045, 0.030, 0.022, 1.0),
		Color(0.50, 0.34, 0.16, 1.0),
		3
	)
	options_panel.name = "OptionsPanel"
	options_panel.anchor_left = 0.5
	options_panel.anchor_top = 0.5
	options_panel.anchor_right = 0.5
	options_panel.anchor_bottom = 0.5
	options_panel.offset_left = -280
	options_panel.offset_top = -220
	options_panel.offset_right = 280
	options_panel.offset_bottom = 220
	options_panel.visible = false
	add_child(options_panel)

	var options_box: VBoxContainer = VBoxContainer.new()
	options_box.set_anchors_preset(Control.PRESET_FULL_RECT)
	options_box.offset_left = 28
	options_box.offset_top = 24
	options_box.offset_right = -28
	options_box.offset_bottom = -24
	options_box.alignment = BoxContainer.ALIGNMENT_CENTER
	options_box.add_theme_constant_override("separation", 14)
	options_panel.add_child(options_box)

	var options_title: Label = create_label(
		"OPTIONS",
		24,
		Color(1.0, 0.82, 0.35)
	)
	options_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	options_box.add_child(options_title)

	var music_section: VBoxContainer = VBoxContainer.new()
	music_section.add_theme_constant_override("separation", 6)
	options_box.add_child(music_section)

	music_volume_label = create_label(
		"",
		16,
		Color(0.82, 0.76, 0.62)
	)
	music_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	music_section.add_child(music_volume_label)

	music_volume_slider = HSlider.new()
	music_volume_slider.min_value = 0
	music_volume_slider.max_value = 100
	music_volume_slider.step = 1
	music_volume_slider.value = AudioManager.get_music_volume_percent()
	music_volume_slider.custom_minimum_size = Vector2(340, 32)
	music_volume_slider.value_changed.connect(on_music_volume_changed)
	music_section.add_child(music_volume_slider)

	var sfx_section: VBoxContainer = VBoxContainer.new()
	sfx_section.add_theme_constant_override("separation", 6)
	options_box.add_child(sfx_section)

	sfx_volume_label = create_label(
		"",
		16,
		Color(0.82, 0.76, 0.62)
	)
	sfx_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sfx_section.add_child(sfx_volume_label)

	sfx_volume_slider = HSlider.new()
	sfx_volume_slider.min_value = 0
	sfx_volume_slider.max_value = 100
	sfx_volume_slider.step = 1
	sfx_volume_slider.value = AudioManager.get_sfx_volume_percent()
	sfx_volume_slider.custom_minimum_size = Vector2(340, 32)
	sfx_volume_slider.value_changed.connect(on_sfx_volume_changed)
	sfx_section.add_child(sfx_volume_slider)

	update_music_volume_label()
	update_sfx_volume_label()

	var test_sfx_button: Button = create_menu_button("Tester effet sonore")
	test_sfx_button.pressed.connect(on_test_sfx_pressed)
	options_box.add_child(test_sfx_button)

	var back_button: Button = create_menu_button("Retour")
	back_button.pressed.connect(on_options_back_pressed)
	options_box.add_child(back_button)


func update_load_button() -> void:
	if SaveManager.has_save_file():
		load_button.disabled = false
		info_label.text = ""
	else:
		load_button.disabled = true
		info_label.text = "Aucune sauvegarde disponible."


func on_new_game_pressed() -> void:
	GameSession.prepare_new_game()
	get_tree().change_scene_to_file(PARTY_CREATION_SCENE_PATH)


func on_load_pressed() -> void:
	if not SaveManager.load_game_to_session():
		info_label.text = SaveManager.last_error
		return

	get_tree().change_scene_to_file(DUNGEON_SCENE_PATH)


func on_options_pressed() -> void:
	options_panel.visible = true
	root_panel.visible = false

	if music_volume_slider != null:
		music_volume_slider.value = AudioManager.get_music_volume_percent()

	if sfx_volume_slider != null:
		sfx_volume_slider.value = AudioManager.get_sfx_volume_percent()

	update_music_volume_label()
	update_sfx_volume_label()


func on_options_back_pressed() -> void:
	options_panel.visible = false
	root_panel.visible = true


func on_music_volume_changed(value: float) -> void:
	var percent: int = int(round(value))
	AudioManager.set_music_volume_percent(percent)
	update_music_volume_label()


func on_sfx_volume_changed(value: float) -> void:
	var percent: int = int(round(value))
	AudioManager.set_sfx_volume_percent(percent)
	update_sfx_volume_label()


func on_test_sfx_pressed() -> void:
	AudioManager.play_sfx("save")


func update_music_volume_label() -> void:
	if music_volume_label == null:
		return

	music_volume_label.text = "Volume musique : " + str(AudioManager.get_music_volume_percent()) + " %"


func update_sfx_volume_label() -> void:
	if sfx_volume_label == null:
		return

	sfx_volume_label.text = "Volume effets : " + str(AudioManager.get_sfx_volume_percent()) + " %"


func on_quit_pressed() -> void:
	get_tree().quit()


func create_menu_button(text: String) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(260, 42)
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", 17)

	apply_textured_button_style(button)

	return button


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


func create_panel(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Panel:
	var panel: Panel = Panel.new()

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


func apply_textured_button_style(button: Button) -> void:
	button.add_theme_color_override("font_color", Color(0.90, 0.80, 0.58))
	button.add_theme_color_override("font_hover_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_pressed_color", Color(1.0, 0.92, 0.48))
	button.add_theme_color_override("font_focus_color", Color(1.0, 0.90, 0.55))
	button.add_theme_color_override("font_disabled_color", Color(0.42, 0.36, 0.28))

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
