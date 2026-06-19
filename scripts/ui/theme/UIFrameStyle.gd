extends RefCounted
class_name UIFrameStyle

# ------------------------------------------------------------
# CONSTANTES
# Centralise la texture NineSlice utilisée par les cadres UI.
# ------------------------------------------------------------

const FRAME_TEXTURE_PATH: String = "res://assets/ui/frames/texture_cadre_ui.png"

const PANEL_TEXTURE_MARGIN: int = 16
const BUTTON_TEXTURE_MARGIN: int = 8

const FALLBACK_CORNER_RADIUS: int = 2


# ------------------------------------------------------------
# PANNEAUX TEXTURÉS
# Utilise la texture 96x96 avec marges 16 px.
# ------------------------------------------------------------

static func create_panel_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBox:
	var texture: Texture2D = load_frame_texture()

	if texture == null:
		return create_flat_style(background_color, border_color, border_width)

	var style: StyleBoxTexture = StyleBoxTexture.new()
	style.texture = texture
	style.texture_margin_left = PANEL_TEXTURE_MARGIN
	style.texture_margin_top = PANEL_TEXTURE_MARGIN
	style.texture_margin_right = PANEL_TEXTURE_MARGIN
	style.texture_margin_bottom = PANEL_TEXTURE_MARGIN
	style.draw_center = true
	style.modulate_color = build_texture_tint(
		background_color,
		border_color,
		border_width
	)

	return style


# ------------------------------------------------------------
# BOUTONS TEXTURÉS
# Utilise le même asset, mais avec une marge réduite pour éviter
# d'écraser les coins sur les boutons bas.
# ------------------------------------------------------------

static func create_button_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBox:
	var texture: Texture2D = load_frame_texture()

	if texture == null:
		return create_flat_style(background_color, border_color, border_width)

	var style: StyleBoxTexture = StyleBoxTexture.new()
	style.texture = texture
	style.texture_margin_left = BUTTON_TEXTURE_MARGIN
	style.texture_margin_top = BUTTON_TEXTURE_MARGIN
	style.texture_margin_right = BUTTON_TEXTURE_MARGIN
	style.texture_margin_bottom = BUTTON_TEXTURE_MARGIN
	style.draw_center = true
	style.modulate_color = build_button_tint(
		background_color,
		border_color,
		border_width
	)

	return style


# ------------------------------------------------------------
# THÈME MENU
# Sert aux boutons créés directement dans les vues de menu.
# Les boutons explicitement stylés gardent leurs overrides.
# Les autres héritent de ce Theme depuis le panneau parent.
# ------------------------------------------------------------

static func create_menu_theme() -> Theme:
	var theme: Theme = Theme.new()

	theme.set_stylebox(
		"normal",
		"Button",
		create_button_style(
			Color(0.11, 0.07, 0.04, 1.0),
			Color(0.30, 0.18, 0.08, 1.0),
			1
		)
	)

	theme.set_stylebox(
		"hover",
		"Button",
		create_button_style(
			Color(0.18, 0.10, 0.05, 1.0),
			Color(0.55, 0.34, 0.13, 1.0),
			1
		)
	)

	theme.set_stylebox(
		"pressed",
		"Button",
		create_button_style(
			Color(0.28, 0.16, 0.06, 1.0),
			Color(0.95, 0.72, 0.28, 1.0),
			2
		)
	)

	theme.set_stylebox(
		"focus",
		"Button",
		create_button_style(
			Color(0.20, 0.12, 0.05, 1.0),
			Color(0.86, 0.62, 0.20, 1.0),
			2
		)
	)

	theme.set_stylebox(
		"disabled",
		"Button",
		create_button_style(
			Color(0.06, 0.04, 0.03, 0.80),
			Color(0.18, 0.12, 0.06, 1.0),
			1
		)
	)

	theme.set_color("font_color", "Button", Color(0.90, 0.80, 0.58))
	theme.set_color("font_hover_color", "Button", Color(1.0, 0.90, 0.55))
	theme.set_color("font_pressed_color", "Button", Color(1.0, 0.92, 0.48))
	theme.set_color("font_focus_color", "Button", Color(1.0, 0.90, 0.55))
	theme.set_color("font_disabled_color", "Button", Color(0.42, 0.36, 0.28))
	theme.set_font_size("font_size", "Button", 14)

	return theme


# ------------------------------------------------------------
# STYLE PLAT DE SECOURS
# Conserve un rendu utilisable si l'asset n'est pas encore importé.
# Sert aussi aux très petites cellules de l'automap.
# ------------------------------------------------------------

static func create_flat_style(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> StyleBoxFlat:
	var style: StyleBoxFlat = StyleBoxFlat.new()
	style.bg_color = background_color
	style.border_color = border_color
	style.set_border_width_all(border_width)
	style.corner_radius_top_left = FALLBACK_CORNER_RADIUS
	style.corner_radius_top_right = FALLBACK_CORNER_RADIUS
	style.corner_radius_bottom_left = FALLBACK_CORNER_RADIUS
	style.corner_radius_bottom_right = FALLBACK_CORNER_RADIUS
	return style


# ------------------------------------------------------------
# OUTILS INTERNES
# ------------------------------------------------------------

static func load_frame_texture() -> Texture2D:
	if not ResourceLoader.exists(FRAME_TEXTURE_PATH):
		return null

	return load(FRAME_TEXTURE_PATH) as Texture2D


static func build_texture_tint(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Color:
	var base_tint: Color = Color(0.92, 0.88, 0.78, max(0.78, background_color.a))
	var accent_strength: float = clamp(float(border_width) / 10.0, 0.10, 0.42)

	var tint: Color = mix_colors(base_tint, border_color, accent_strength)
	tint.a = max(0.78, background_color.a)

	return tint


static func build_button_tint(
	background_color: Color,
	border_color: Color,
	border_width: int
) -> Color:
	var base_tint: Color = Color(0.90, 0.84, 0.72, max(0.82, background_color.a))
	var accent_strength: float = clamp(float(border_width) / 8.0, 0.16, 0.50)

	var tint: Color = mix_colors(base_tint, border_color, accent_strength)
	tint.a = max(0.82, background_color.a)

	return tint


static func mix_colors(
	first_color: Color,
	second_color: Color,
	weight: float
) -> Color:
	var clamped_weight: float = clamp(weight, 0.0, 1.0)

	return Color(
		first_color.r + (second_color.r - first_color.r) * clamped_weight,
		first_color.g + (second_color.g - first_color.g) * clamped_weight,
		first_color.b + (second_color.b - first_color.b) * clamped_weight,
		first_color.a + (second_color.a - first_color.a) * clamped_weight
	)
