extends Control
class_name CombatMonsterDisplayUI

# ------------------------------------------------------------
# DÉPENDANCES VISUELLES
# Charge les sprites définitifs des monstres.
# ------------------------------------------------------------

const ZOMBIE_IDLE_01 = preload("res://assets/monsters/zombie/zombie_idle_01.png")
const ZOMBIE_IDLE_02 = preload("res://assets/monsters/zombie/zombie_idle_02.png")

const GOBELIN_IDLE_01 = preload("res://assets/monsters/gobelin/gobelin_idle_01.png")
const GOBELIN_IDLE_02 = preload("res://assets/monsters/gobelin/gobelin_idle_02.png")

const CHAUVE_SOURIS_IDLE_01 = preload("res://assets/monsters/chauve_souris/chauve_souris_idle_01.png")
const CHAUVE_SOURIS_IDLE_02 = preload("res://assets/monsters/chauve_souris/chauve_souris_idle_02.png")

const TROLL_IDLE_01 = preload("res://assets/monsters/troll/troll_idle_01.png")
const TROLL_IDLE_02 = preload("res://assets/monsters/troll/troll_idle_02.png")

const GARDIEN_IDLE_01 = preload("res://assets/monsters/gardien/gardien_idle_01.png")
const GARDIEN_IDLE_02 = preload("res://assets/monsters/gardien/gardien_idle_02.png")


# ------------------------------------------------------------
# PARAMÈTRES D’AFFICHAGE
# Contrôle la taille et la position du monstre dans la vue de combat.
# ------------------------------------------------------------

const DEFAULT_VISUAL_ID: String = "zombie"

const DEFAULT_MONSTER_TARGET_HEIGHT: float = 400.0
const BAT_TARGET_HEIGHT: float = 330.0
const LARGE_MONSTER_TARGET_HEIGHT: float = 430.0

const MONSTER_HORIZONTAL_OFFSET: float = 350.0
const MONSTER_VERTICAL_OFFSET: float = 220.0

const DEFAULT_FRAME_DURATION: float = 0.45
const BAT_FRAME_DURATION: float = 0.32


# ------------------------------------------------------------
# NŒUDS VISUELS
# Stocke le sprite principal et son matériau de flash.
# ------------------------------------------------------------

var monster_sprite: Sprite2D = null
var monster_material: ShaderMaterial = null


# ------------------------------------------------------------
# ÉTAT VISUEL DU MONSTRE
# Garde les frames, la variation visuelle et l’animation en cours.
# ------------------------------------------------------------

var current_visual_id: String = DEFAULT_VISUAL_ID

var idle_frames: Array[Texture2D] = []
var current_frame_index: int = 0
var frame_timer: float = 0.0
var frame_duration: float = DEFAULT_FRAME_DURATION

var idle_time: float = 0.0

var flash_timer: float = 0.0
var flash_duration: float = 0.14

var attack_timer: float = 0.0
var attack_duration: float = 0.24

var ui_built: bool = false


# ------------------------------------------------------------
# INITIALISATION
# Prépare l’interface au chargement du nœud.
# ------------------------------------------------------------

func _ready() -> void:
	build_ui()


func _process(delta: float) -> void:
	if not visible:
		return

	update_idle_animation(delta)
	update_attack_timer(delta)
	update_idle_motion(delta)
	update_flash(delta)


# ------------------------------------------------------------
# CONSTRUCTION UI
# Crée le sprite du monstre et prépare le matériau de flash.
# ------------------------------------------------------------

func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	idle_frames = get_idle_frames_for_visual_id(DEFAULT_VISUAL_ID)
	frame_duration = get_frame_duration_for_visual_id(DEFAULT_VISUAL_ID)

	monster_material = create_flash_material()

	monster_sprite = Sprite2D.new()
	monster_sprite.name = "MonsterSprite"
	monster_sprite.centered = true
	monster_sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	monster_sprite.material = monster_material
	add_child(monster_sprite)

	if not idle_frames.is_empty():
		monster_sprite.texture = idle_frames[0]

	visible = false


# Crée le shader utilisé pour le flash blanc quand un monstre est touché.
func create_flash_material() -> ShaderMaterial:
	var shader: Shader = Shader.new()

	shader.code = """
shader_type canvas_item;

uniform float flash_amount = 0.0;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV) * COLOR;
	vec4 white_color = vec4(1.0, 1.0, 1.0, tex_color.a);
	COLOR = mix(tex_color, white_color, flash_amount);
}
"""

	var material: ShaderMaterial = ShaderMaterial.new()
	material.shader = shader
	material.set_shader_parameter("flash_amount", 0.0)

	return material


# ------------------------------------------------------------
# AFFICHAGE DU MONSTRE
# Affiche un monstre selon son identité visuelle, avec fallback zombie.
# ------------------------------------------------------------

func show_monster(enemy = null) -> void:
	ensure_ui_ready()

	var visual_id: String = get_visual_id_from_enemy(enemy)
	set_monster_visual(visual_id)

	visible = true
	current_frame_index = 0
	frame_timer = 0.0
	idle_time = 0.0
	flash_timer = 0.0
	attack_timer = 0.0

	if monster_sprite != null:
		if not idle_frames.is_empty():
			monster_sprite.texture = idle_frames[0]

		monster_sprite.rotation = 0.0
		monster_sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

	if monster_material != null:
		monster_material.set_shader_parameter("flash_amount", 0.0)

	apply_sprite_transform(0.0, 0.0, 0.0, 1.0)


func hide_monster() -> void:
	visible = false
	attack_timer = 0.0
	flash_timer = 0.0

	if monster_material != null:
		monster_material.set_shader_parameter("flash_amount", 0.0)


# Change les frames utilisées par le monstre affiché.
func set_monster_visual(visual_id: String) -> void:
	if visual_id == "":
		visual_id = DEFAULT_VISUAL_ID

	if visual_id == current_visual_id and not idle_frames.is_empty():
		return

	current_visual_id = visual_id
	idle_frames = get_idle_frames_for_visual_id(current_visual_id)
	frame_duration = get_frame_duration_for_visual_id(current_visual_id)

	if idle_frames.is_empty():
		current_visual_id = DEFAULT_VISUAL_ID
		idle_frames = get_idle_frames_for_visual_id(DEFAULT_VISUAL_ID)
		frame_duration = get_frame_duration_for_visual_id(DEFAULT_VISUAL_ID)

	current_frame_index = 0


# ------------------------------------------------------------
# IDENTITÉ VISUELLE
# Déduit le visuel depuis visual_id, monster_id ou monster_name.
# ------------------------------------------------------------

func get_visual_id_from_enemy(enemy) -> String:
	if enemy == null:
		return DEFAULT_VISUAL_ID

	var visual_id: String = get_string_property(enemy, "visual_id", "")

	if visual_id != "":
		return normalize_visual_id(visual_id)

	var monster_id: String = get_string_property(enemy, "monster_id", "")

	if monster_id != "":
		return normalize_visual_id(monster_id)

	var monster_name: String = get_string_property(enemy, "monster_name", "")

	if monster_name != "":
		return normalize_monster_name_to_visual_id(monster_name)

	return DEFAULT_VISUAL_ID


func normalize_visual_id(text: String) -> String:
	var normalized: String = text.strip_edges().to_lower()

	normalized = normalized.replace(" ", "_")
	normalized = normalized.replace("-", "_")
	normalized = normalized.replace("é", "e")
	normalized = normalized.replace("è", "e")
	normalized = normalized.replace("ê", "e")
	normalized = normalized.replace("ë", "e")
	normalized = normalized.replace("à", "a")
	normalized = normalized.replace("â", "a")
	normalized = normalized.replace("ù", "u")
	normalized = normalized.replace("û", "u")
	normalized = normalized.replace("î", "i")
	normalized = normalized.replace("ï", "i")
	normalized = normalized.replace("ô", "o")
	normalized = normalized.replace("ö", "o")
	normalized = normalized.replace("ç", "c")

	return normalized


func normalize_monster_name_to_visual_id(monster_name: String) -> String:
	var normalized: String = normalize_visual_id(monster_name)

	if normalized.contains("chauve") or normalized.contains("souris"):
		return "chauve_souris"

	if normalized.contains("gobelin"):
		return "gobelin"

	if normalized.contains("troll"):
		return "troll"

	if normalized.contains("gardien"):
		return "gardien"

	if normalized.contains("zombie"):
		return "zombie"

	return DEFAULT_VISUAL_ID


# ------------------------------------------------------------
# FRAMES MONSTRES
# Associe chaque monstre à ses deux frames idle définitives.
# ------------------------------------------------------------

func get_idle_frames_for_visual_id(visual_id: String) -> Array[Texture2D]:
	if visual_id == "zombie":
		return get_zombie_idle_frames()

	if visual_id == "gobelin":
		return get_gobelin_idle_frames()

	if visual_id == "chauve_souris":
		return get_chauve_souris_idle_frames()

	if visual_id == "troll":
		return get_troll_idle_frames()

	if visual_id == "gardien":
		return get_gardien_idle_frames()

	return get_zombie_idle_frames()


func get_zombie_idle_frames() -> Array[Texture2D]:
	return [
		ZOMBIE_IDLE_01,
		ZOMBIE_IDLE_02
	]


func get_gobelin_idle_frames() -> Array[Texture2D]:
	return [
		GOBELIN_IDLE_01,
		GOBELIN_IDLE_02
	]


func get_chauve_souris_idle_frames() -> Array[Texture2D]:
	return [
		CHAUVE_SOURIS_IDLE_01,
		CHAUVE_SOURIS_IDLE_02
	]


func get_troll_idle_frames() -> Array[Texture2D]:
	return [
		TROLL_IDLE_01,
		TROLL_IDLE_02
	]


func get_gardien_idle_frames() -> Array[Texture2D]:
	return [
		GARDIEN_IDLE_01,
		GARDIEN_IDLE_02
	]


# ------------------------------------------------------------
# PARAMÈTRES PAR MONSTRE
# Ajuste légèrement le rythme et la taille selon la silhouette.
# ------------------------------------------------------------

func get_frame_duration_for_visual_id(visual_id: String) -> float:
	if visual_id == "chauve_souris":
		return BAT_FRAME_DURATION

	return DEFAULT_FRAME_DURATION


func get_target_height_for_visual_id(visual_id: String) -> float:
	if visual_id == "chauve_souris":
		return BAT_TARGET_HEIGHT

	if visual_id == "troll" or visual_id == "gardien":
		return LARGE_MONSTER_TARGET_HEIGHT

	return DEFAULT_MONSTER_TARGET_HEIGHT


# ------------------------------------------------------------
# FEEDBACK D’ACTION
# Déclenche le flash quand le monstre est touché ou son mouvement d’attaque.
# ------------------------------------------------------------

func play_hit_flash() -> void:
	ensure_ui_ready()

	flash_timer = flash_duration

	if monster_material != null:
		monster_material.set_shader_parameter("flash_amount", 1.0)


func play_attack_motion() -> void:
	ensure_ui_ready()

	if not visible:
		return

	attack_timer = attack_duration


# ------------------------------------------------------------
# ANIMATION IDLE
# Anime les frames du monstre pendant le combat.
# ------------------------------------------------------------

func update_idle_animation(delta: float) -> void:
	if idle_frames.is_empty():
		return

	frame_timer += delta

	if frame_timer >= frame_duration:
		frame_timer = 0.0
		current_frame_index += 1

		if current_frame_index >= idle_frames.size():
			current_frame_index = 0

		if monster_sprite != null:
			monster_sprite.texture = idle_frames[current_frame_index]


func update_attack_timer(delta: float) -> void:
	if attack_timer <= 0.0:
		return

	attack_timer -= delta

	if attack_timer < 0.0:
		attack_timer = 0.0


func update_idle_motion(delta: float) -> void:
	idle_time += delta

	var float_y: float = sin(idle_time * 2.2) * 4.0
	var sway_x: float = sin(idle_time * 1.3) * 3.0
	var rotation_amount: float = sin(idle_time * 1.4) * 0.018
	var scale_amount: float = 1.0 + sin(idle_time * 2.2) * 0.012

	if attack_timer > 0.0:
		var attack_progress: float = 1.0 - attack_timer / attack_duration
		var attack_curve: float = sin(attack_progress * PI)

		sway_x += sin(attack_progress * PI * 8.0) * 4.0
		float_y += attack_curve * 18.0
		scale_amount += attack_curve * 0.09
		rotation_amount += sin(attack_progress * PI * 6.0) * 0.018

	apply_sprite_transform(
		sway_x,
		float_y,
		rotation_amount,
		scale_amount
	)


# ------------------------------------------------------------
# FLASH VISUEL
# Gère la disparition progressive du flash blanc.
# ------------------------------------------------------------

func update_flash(delta: float) -> void:
	if monster_material == null:
		return

	if flash_timer <= 0.0:
		monster_material.set_shader_parameter("flash_amount", 0.0)
		return

	flash_timer -= delta

	var remaining_ratio: float = flash_timer / flash_duration
	var flash_amount: float = clamp(remaining_ratio, 0.0, 1.0)

	monster_material.set_shader_parameter("flash_amount", flash_amount)


# ------------------------------------------------------------
# TRANSFORMATION DU SPRITE
# Positionne, redimensionne et anime le sprite à l’écran.
# ------------------------------------------------------------

func apply_sprite_transform(
	extra_x: float,
	extra_y: float,
	rotation_amount: float,
	scale_amount: float
) -> void:
	var center_position: Vector2 = size * 0.5

	center_position.x += MONSTER_HORIZONTAL_OFFSET
	center_position.y += MONSTER_VERTICAL_OFFSET
	center_position.x += extra_x
	center_position.y += extra_y

	var final_scale_value: float = get_base_sprite_scale() * scale_amount
	var final_scale: Vector2 = Vector2(final_scale_value, final_scale_value)

	if monster_sprite != null:
		monster_sprite.position = center_position
		monster_sprite.rotation = rotation_amount
		monster_sprite.scale = final_scale


func get_base_sprite_scale() -> float:
	if idle_frames.is_empty():
		return 1.0

	var texture_size: Vector2 = idle_frames[0].get_size()

	if texture_size.y <= 0.0:
		return 1.0

	var target_height: float = get_target_height_for_visual_id(current_visual_id)

	return target_height / texture_size.y


# ------------------------------------------------------------
# HELPERS DE PROPRIÉTÉS
# Lit les champs sans dépendre d’une classe trop stricte.
# ------------------------------------------------------------

func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if target is Dictionary:
		if target.has(property_name):
			return str(target[property_name])

		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	if target is Dictionary:
		return target.has(property_name)

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false


# ------------------------------------------------------------
# SÉCURITÉ UI
# Construit l’interface si une méthode est appelée trop tôt.
# ------------------------------------------------------------

func ensure_ui_ready() -> void:
	if not ui_built:
		build_ui()
