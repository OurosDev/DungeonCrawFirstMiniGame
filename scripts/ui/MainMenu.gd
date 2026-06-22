extends Control
class_name MainMenu

# =============================================================================
# MAIN MENU
# -----------------------------------------------------------------------------
# Menu principal construit par script.
# Cette version ajoute un fond illustré et rend le placement des éléments du menu
# réglable depuis les constantes ci-dessous.
#
# Repère utilisé : résolution de référence du projet, 1152 x 648.
# Le projet utilise le stretch canvas_items / keep, donc ces coordonnées restent
# stables et se mettent à l'échelle avec la fenêtre.
# =============================================================================

# SCÈNES
const PARTY_CREATION_SCENE_PATH: String = "res://scenes/PartyCreation.tscn"
const DUNGEON_SCENE_PATH: String = "res://scenes/Dungeon.tscn"

# STYLES
const UIFrameStyleScript = preload("res://scripts/ui/theme/UIFrameStyle.gd")

# CONFIGURATION — FOND DU MENU
# Chemin attendu pour l'image de fond. Le chargement est volontairement robuste :
# il essaye d'abord le chargement Godot classique, puis un chargement direct du
# PNG si l'image vient d'être copiée et n'a pas encore été importée par l'éditeur.
const MENU_BACKGROUND_TEXTURE_PATH: String = "res://assets/ui/backgrounds/main_menu_background.png"
const FALLBACK_BACKGROUND_COLOR: Color = Color(0.025, 0.018, 0.014, 1.0)

# CONFIGURATION — POLICES
# Ces fichiers OpenType doivent être ajoutés localement dans assets/fonts/.
# Ils ne sont pas inclus dans ce pack.
const GAME_THEME_PATH: String = "res://assets/ui/themes/game_theme.tres"
const APPLY_GAME_THEME_LOCALLY_ON_MAIN_MENU: bool = true

const TITLE_FONT_PATH: String = "res://assets/fonts/title_medieval.otf"
const TITLE_FONT_OUTLINE_SIZE: int = 2
const TITLE_FONT_OUTLINE_COLOR: Color = Color(0.06, 0.035, 0.018, 1.0)
const TITLE_FONT_COLOR: Color = Color(1.0, 0.82, 0.35)

# CONFIGURATION — PLACEMENT DU MENU PRINCIPAL
# Le fond contient déjà le grand cadre noir. Par défaut, le script ne dessine
# donc aucun cadre supplémentaire autour du menu.
# Ajuster seulement ces rectangles pour caler l'interface sur l'image.
const TITLE_RECT: Rect2 = Rect2(402, 128, 258, 36)
const SUBTITLE_RECT: Rect2 = Rect2(398, 160, 238, 22)
const BUTTON_GROUP_RECT: Rect2 = Rect2(406, 186, 250, 220)
const INFO_RECT: Rect2 = Rect2(402, 386, 258, 28)

# CONFIGURATION — CONTENU DU MENU PRINCIPAL
const TITLE_FONT_SIZE: int = 18
const SUBTITLE_FONT_SIZE: int = 12
const SUBTITLE_VISIBLE: bool = false
const BUTTON_HEIGHT: int = 44
const BUTTON_FONT_SIZE: int = 14
const BUTTON_SPACING: int = 8
const INFO_FONT_SIZE: int = 11

# CONFIGURATION — OPTIONS
# Les options réutilisent le cadre déjà dessiné dans l'image.
# OPTIONS_DRAW_PANEL_BACKGROUND reste à false pour éviter de créer un grand cadre
# visible par-dessus l'illustration.
const OPTIONS_PANEL_RECT: Rect2 = Rect2(392, 116, 278, 310)
const OPTIONS_CONTENT_MARGIN: int = 14
const OPTIONS_TITLE_FONT_SIZE: int = 18
const OPTIONS_LABEL_FONT_SIZE: int = 12
const OPTIONS_BUTTON_HEIGHT: int = 28
const OPTIONS_BUTTON_FONT_SIZE: int = 12
const OPTIONS_SLIDER_HEIGHT: int = 22
const OPTIONS_SPACING: int = 7
const OPTIONS_DRAW_PANEL_BACKGROUND: bool = false

# CONFIGURATION — DEBUG DE PLACEMENT
# Aucun guide n'est affiché par défaut.
# Passer à true temporairement pour afficher les rectangles de placement.
const SHOW_MENU_LAYOUT_GUIDES: bool = false

# RÉFÉRENCES UI
var main_layer: Control = null
var title_label: Label = null
var subtitle_label: Label = null
var info_label: Label = null
var button_box: VBoxContainer = null
var new_game_button: Button = null
var load_button: Button = null
var options_button: Button = null
var quit_button: Button = null

var options_panel: Panel = null
var music_volume_label: Label = null
var music_volume_slider: HSlider = null
var sfx_volume_label: Label = null
var sfx_volume_slider: HSlider = null


# =============================================================================
# INITIALISATION
# =============================================================================

func _ready() -> void:
	AudioManager.play_title_music()
	apply_game_theme_locally()
	build_ui()
	update_load_button()


# =============================================================================
# CONSTRUCTION UI
# =============================================================================

func build_ui() -> void:
	apply_full_rect(self)
	mouse_filter = Control.MOUSE_FILTER_STOP

	build_background()
	build_main_layer()
	build_options_panel()
	build_layout_guides()


func build_background() -> void:
	var fallback_background: ColorRect = ColorRect.new()
	fallback_background.name = "FallbackBackground"
	fallback_background.color = FALLBACK_BACKGROUND_COLOR
	fallback_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	fallback_background.z_index = -20
	apply_full_rect(fallback_background)
	add_child(fallback_background)

	var background_texture: Texture2D = load_background_texture()
	if background_texture == null:
		push_warning("MainMenu : image de fond introuvable ou non lisible : " + MENU_BACKGROUND_TEXTURE_PATH)
		return

	var background_rect: TextureRect = TextureRect.new()
	background_rect.name = "MainMenuBackground"
	background_rect.texture = background_texture
	background_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	background_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	background_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	background_rect.z_index = -10
	apply_full_rect(background_rect)
	add_child(background_rect)


func build_main_layer() -> void:
	main_layer = Control.new()
	main_layer.name = "MainLayer"
	main_layer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	apply_full_rect(main_layer)
	add_child(main_layer)

	title_label = create_label(
		"DONJON DES SERPENTS",
		TITLE_FONT_SIZE,
		TITLE_FONT_COLOR
	)
	title_label.name = "TitleLabel"
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.clip_text = true
	apply_title_font(title_label)
	apply_absolute_rect(title_label, TITLE_RECT)
	main_layer.add_child(title_label)

	subtitle_label = create_label(
		"Exploration • Magie • Survie",
		SUBTITLE_FONT_SIZE,
		Color(0.70, 0.62, 0.48)
	)
	subtitle_label.name = "SubtitleLabel"
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	subtitle_label.visible = SUBTITLE_VISIBLE
	apply_absolute_rect(subtitle_label, SUBTITLE_RECT)
	main_layer.add_child(subtitle_label)

	button_box = VBoxContainer.new()
	button_box.name = "ButtonBox"
	button_box.alignment = BoxContainer.ALIGNMENT_CENTER
	button_box.add_theme_constant_override("separation", BUTTON_SPACING)
	apply_absolute_rect(button_box, BUTTON_GROUP_RECT)
	main_layer.add_child(button_box)

	new_game_button = create_menu_button("Nouvelle partie", BUTTON_HEIGHT, BUTTON_FONT_SIZE)
	new_game_button.pressed.connect(on_new_game_pressed)
	button_box.add_child(new_game_button)

	load_button = create_menu_button("Charger", BUTTON_HEIGHT, BUTTON_FONT_SIZE)
	load_button.pressed.connect(on_load_pressed)
	button_box.add_child(load_button)

	options_button = create_menu_button("Options", BUTTON_HEIGHT, BUTTON_FONT_SIZE)
	options_button.pressed.connect(on_options_pressed)
	button_box.add_child(options_button)

	quit_button = create_menu_button("Quitter", BUTTON_HEIGHT, BUTTON_FONT_SIZE)
	quit_button.pressed.connect(on_quit_pressed)
	button_box.add_child(quit_button)

	info_label = create_label("", INFO_FONT_SIZE, Color(0.74, 0.66, 0.50))
	info_label.name = "InfoLabel"
	info_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	info_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	info_label.clip_text = false
	apply_absolute_rect(info_label, INFO_RECT)
	main_layer.add_child(info_label)


func build_options_panel() -> void:
	options_panel = create_panel(
		Color(0.045, 0.030, 0.022, 0.96),
		Color(0.50, 0.34, 0.16, 1.0),
		3
	)
	options_panel.name = "OptionsPanel"
	options_panel.visible = false
	apply_absolute_rect(options_panel, OPTIONS_PANEL_RECT)

	if not OPTIONS_DRAW_PANEL_BACKGROUND:
		options_panel.add_theme_stylebox_override("panel", StyleBoxEmpty.new())

	add_child(options_panel)

	var options_box: VBoxContainer = VBoxContainer.new()
	options_box.name = "OptionsBox"
	apply_full_rect(options_box)
	options_box.offset_left = OPTIONS_CONTENT_MARGIN
	options_box.offset_top = OPTIONS_CONTENT_MARGIN
	options_box.offset_right = -OPTIONS_CONTENT_MARGIN
	options_box.offset_bottom = -OPTIONS_CONTENT_MARGIN
	options_box.alignment = BoxContainer.ALIGNMENT_CENTER
	options_box.add_theme_constant_override("separation", OPTIONS_SPACING)
	options_panel.add_child(options_box)

	var options_title: Label = create_label(
		"OPTIONS",
		OPTIONS_TITLE_FONT_SIZE,
		Color(1.0, 0.82, 0.35)
	)
	options_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	options_title.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	options_box.add_child(options_title)

	var music_section: VBoxContainer = VBoxContainer.new()
	music_section.add_theme_constant_override("separation", 3)
	options_box.add_child(music_section)

	music_volume_label = create_label("", OPTIONS_LABEL_FONT_SIZE, Color(0.82, 0.76, 0.62))
	music_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	music_volume_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	music_section.add_child(music_volume_label)

	music_volume_slider = HSlider.new()
	music_volume_slider.min_value = 0
	music_volume_slider.max_value = 100
	music_volume_slider.step = 1
	music_volume_slider.value = AudioManager.get_music_volume_percent()
	music_volume_slider.custom_minimum_size = Vector2(0, OPTIONS_SLIDER_HEIGHT)
	music_volume_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	music_volume_slider.value_changed.connect(on_music_volume_changed)
	music_section.add_child(music_volume_slider)

	var sfx_section: VBoxContainer = VBoxContainer.new()
	sfx_section.add_theme_constant_override("separation", 3)
	options_box.add_child(sfx_section)

	sfx_volume_label = create_label("", OPTIONS_LABEL_FONT_SIZE, Color(0.82, 0.76, 0.62))
	sfx_volume_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	sfx_volume_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	sfx_section.add_child(sfx_volume_label)

	sfx_volume_slider = HSlider.new()
	sfx_volume_slider.min_value = 0
	sfx_volume_slider.max_value = 100
	sfx_volume_slider.step = 1
	sfx_volume_slider.value = AudioManager.get_sfx_volume_percent()
	sfx_volume_slider.custom_minimum_size = Vector2(0, OPTIONS_SLIDER_HEIGHT)
	sfx_volume_slider.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	sfx_volume_slider.value_changed.connect(on_sfx_volume_changed)
	sfx_section.add_child(sfx_volume_slider)

	update_music_volume_label()
	update_sfx_volume_label()

	var test_sfx_button: Button = create_menu_button(
		"Tester effet sonore",
		OPTIONS_BUTTON_HEIGHT,
		OPTIONS_BUTTON_FONT_SIZE
	)
	test_sfx_button.pressed.connect(on_test_sfx_pressed)
	options_box.add_child(test_sfx_button)

	var back_button: Button = create_menu_button(
		"Retour",
		OPTIONS_BUTTON_HEIGHT,
		OPTIONS_BUTTON_FONT_SIZE
	)
	back_button.pressed.connect(on_options_back_pressed)
	options_box.add_child(back_button)


func build_layout_guides() -> void:
	if not SHOW_MENU_LAYOUT_GUIDES:
		return

	add_layout_guide(TITLE_RECT, Color(1.0, 0.82, 0.10, 0.80), "TitleGuide")
	add_layout_guide(BUTTON_GROUP_RECT, Color(0.20, 0.75, 1.0, 0.80), "ButtonGuide")
	add_layout_guide(OPTIONS_PANEL_RECT, Color(1.0, 0.15, 0.05, 0.80), "OptionsGuide")


# =============================================================================
# ACTIONS DU MENU
# =============================================================================

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
	main_layer.visible = false

	if music_volume_slider != null:
		music_volume_slider.value = AudioManager.get_music_volume_percent()

	if sfx_volume_slider != null:
		sfx_volume_slider.value = AudioManager.get_sfx_volume_percent()

	update_music_volume_label()
	update_sfx_volume_label()


func on_options_back_pressed() -> void:
	options_panel.visible = false
	main_layer.visible = true


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


# =============================================================================
# HELPERS UI
# =============================================================================


func apply_game_theme_locally() -> void:
	# Applique le thème global au menu principal même si le réglage Projet n'a
	# pas encore été activé. Pour le reste du jeu, utiliser le réglage
	# Project Settings > GUI > Theme > Custom.
	if not APPLY_GAME_THEME_LOCALLY_ON_MAIN_MENU:
		return

	if not ResourceLoader.exists(GAME_THEME_PATH):
		push_warning("MainMenu : thème UI introuvable : " + GAME_THEME_PATH)
		return

	var loaded_theme: Resource = ResourceLoader.load(GAME_THEME_PATH)
	if loaded_theme is Theme:
		theme = loaded_theme as Theme
	else:
		push_warning("MainMenu : le fichier indiqué n'est pas un Theme : " + GAME_THEME_PATH)


func apply_title_font(label: Label) -> void:
	# Police spéciale du titre principal uniquement.
	if not ResourceLoader.exists(TITLE_FONT_PATH):
		push_warning("MainMenu : police du titre introuvable : " + TITLE_FONT_PATH)
		return

	var loaded_font: Resource = ResourceLoader.load(TITLE_FONT_PATH)
	if loaded_font is Font:
		label.add_theme_font_override("font", loaded_font as Font)
		label.add_theme_constant_override("outline_size", TITLE_FONT_OUTLINE_SIZE)
		label.add_theme_color_override("font_outline_color", TITLE_FONT_OUTLINE_COLOR)
	else:
		push_warning("MainMenu : le fichier indiqué n'est pas une police : " + TITLE_FONT_PATH)


func load_background_texture() -> Texture2D:
	if ResourceLoader.exists(MENU_BACKGROUND_TEXTURE_PATH):
		var resource: Resource = ResourceLoader.load(MENU_BACKGROUND_TEXTURE_PATH)
		if resource is Texture2D:
			return resource as Texture2D

	if FileAccess.file_exists(MENU_BACKGROUND_TEXTURE_PATH):
		var image: Image = Image.new()
		var error: Error = image.load(MENU_BACKGROUND_TEXTURE_PATH)
		if error == OK:
			return ImageTexture.create_from_image(image)

	return null


func apply_full_rect(control: Control) -> void:
	control.anchor_left = 0.0
	control.anchor_top = 0.0
	control.anchor_right = 1.0
	control.anchor_bottom = 1.0
	control.offset_left = 0.0
	control.offset_top = 0.0
	control.offset_right = 0.0
	control.offset_bottom = 0.0


func apply_absolute_rect(control: Control, rect: Rect2) -> void:
	control.anchor_left = 0.0
	control.anchor_top = 0.0
	control.anchor_right = 0.0
	control.anchor_bottom = 0.0
	control.offset_left = rect.position.x
	control.offset_top = rect.position.y
	control.offset_right = rect.position.x + rect.size.x
	control.offset_bottom = rect.position.y + rect.size.y


func create_menu_button(text: String, button_height: int, font_size: int) -> Button:
	var button: Button = Button.new()
	button.text = text
	button.custom_minimum_size = Vector2(0, button_height)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.focus_mode = Control.FOCUS_NONE
	button.add_theme_font_size_override("font_size", font_size)
	apply_textured_button_style(button)
	return button


func create_label(text: String, font_size: int, font_color: Color) -> Label:
	var label: Label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", font_size)
	label.add_theme_color_override("font_color", font_color)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	return label


func create_panel(background_color: Color, border_color: Color, border_width: int) -> Panel:
	var panel: Panel = Panel.new()
	panel.theme = UIFrameStyleScript.create_menu_theme()
	panel.add_theme_stylebox_override(
		"panel",
		UIFrameStyleScript.create_panel_style(background_color, border_color, border_width)
	)
	return panel


func add_layout_guide(rect: Rect2, border_color: Color, guide_name: String) -> void:
	var guide: Panel = Panel.new()
	guide.name = guide_name
	guide.mouse_filter = Control.MOUSE_FILTER_IGNORE
	apply_absolute_rect(guide, rect)

	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = Color(border_color.r, border_color.g, border_color.b, 0.06)
	style.border_color = border_color
	style.set_border_width_all(2)
	guide.add_theme_stylebox_override("panel", style)

	add_child(guide)


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
