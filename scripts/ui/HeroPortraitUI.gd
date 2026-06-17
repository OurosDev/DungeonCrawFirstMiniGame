extends Control
class_name HeroPortraitUI

const PortraitVisualDatabaseScript = preload("res://scripts/characters/PortraitVisualDatabase.gd")

const IDLE_FRAME_DURATION: float = 0.75

const PORTRAIT_SCALE_MULTIPLIER: float = 1.00
const PORTRAIT_HORIZONTAL_OFFSET: float = 0.0
const PORTRAIT_VERTICAL_OFFSET: float = 0.0
const PORTRAIT_AVAILABLE_WIDTH_RATIO: float = 0.94
const PORTRAIT_AVAILABLE_HEIGHT_RATIO: float = 0.94

var sprite: Sprite2D = null

var current_hero = null
var current_job_name: String = ""

var idle_frames: Array[Texture2D] = []
var damage_frame: Texture2D = null

var idle_frame_index: int = 0
var idle_timer: float = 0.0

var damage_is_held: bool = false
var motion_time: float = 0.0

var ui_built: bool = false
var layout_update_pending: bool = false

var base_sprite_scale: Vector2 = Vector2.ONE
var last_control_size: Vector2 = Vector2.ZERO


func _ready() -> void:
	build_ui()
	set_process(true)
	request_layout_update()


func _notification(what: int) -> void:
	if what == NOTIFICATION_RESIZED:
		request_layout_update()


func build_ui() -> void:
	if ui_built:
		return

	ui_built = true

	clip_contents = true
	texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

	sprite = Sprite2D.new()
	sprite.name = "PortraitSprite"
	sprite.centered = true
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	sprite.z_index = 1
	sprite.visible = false
	add_child(sprite)


func setup_for_hero(hero, should_show_damage: bool = false) -> void:
	if sprite == null:
		build_ui()

	current_hero = hero

	if hero == null:
		clear_portrait()
		return

	var job_name: String = get_string_property(hero, "job", "")

	if job_name != current_job_name:
		current_job_name = job_name
		load_portrait_for_job(current_job_name)

	if should_show_damage:
		show_damage_frame()
	else:
		if damage_is_held:
			clear_damage_frame()
		else:
			update_idle_texture()

	request_layout_update()


func load_portrait_for_job(job_name: String) -> void:
	idle_frames.clear()
	damage_frame = null
	idle_frame_index = 0
	idle_timer = 0.0
	damage_is_held = false

	var portrait_data = PortraitVisualDatabaseScript.get_portrait_for_class(job_name)

	if portrait_data == null:
		return

	var raw_idle_frames = get_property_value(portrait_data, "idle_frames", [])

	if raw_idle_frames is Array:
		for frame in raw_idle_frames:
			if frame is Texture2D:
				idle_frames.append(frame)

	var raw_damage_frame = get_property_value(portrait_data, "damage_frame", null)

	if raw_damage_frame is Texture2D:
		damage_frame = raw_damage_frame

	update_idle_texture()


func clear_portrait() -> void:
	current_job_name = ""
	idle_frames.clear()
	damage_frame = null
	idle_frame_index = 0
	idle_timer = 0.0
	damage_is_held = false
	base_sprite_scale = Vector2.ONE
	last_control_size = Vector2.ZERO

	if sprite != null:
		sprite.texture = null
		sprite.visible = false


func show_damage_frame() -> void:
	damage_is_held = true
	motion_time = 0.0

	if sprite == null:
		return

	if damage_frame != null:
		sprite.texture = damage_frame
	elif not idle_frames.is_empty():
		sprite.texture = idle_frames[0]
	else:
		sprite.texture = null

	request_layout_update()


func clear_damage_frame() -> void:
	damage_is_held = false
	idle_frame_index = 0
	idle_timer = 0.0
	update_idle_texture()


func update_idle_texture() -> void:
	if sprite == null:
		return

	if idle_frames.is_empty():
		sprite.texture = null
		sprite.visible = false
		return

	if idle_frame_index < 0:
		idle_frame_index = 0

	if idle_frame_index >= idle_frames.size():
		idle_frame_index = 0

	sprite.texture = idle_frames[idle_frame_index]
	request_layout_update()


func _process(delta: float) -> void:
	if sprite == null:
		return

	if size != last_control_size:
		update_sprite_layout()

	motion_time += delta

	if not damage_is_held:
		update_idle_animation(delta)

	update_sprite_motion()


func update_idle_animation(delta: float) -> void:
	if idle_frames.size() <= 1:
		return

	idle_timer += delta

	if idle_timer < IDLE_FRAME_DURATION:
		return

	idle_timer = 0.0
	idle_frame_index += 1

	if idle_frame_index >= idle_frames.size():
		idle_frame_index = 0

	update_idle_texture()


func request_layout_update() -> void:
	if layout_update_pending:
		return

	layout_update_pending = true
	call_deferred("perform_deferred_layout_update")


func perform_deferred_layout_update() -> void:
	layout_update_pending = false
	update_sprite_layout()


func update_sprite_layout() -> void:
	if sprite == null:
		return

	last_control_size = size

	if sprite.texture == null:
		sprite.visible = false
		return

	var control_size: Vector2 = size

	if control_size.x <= 0.0 or control_size.y <= 0.0:
		sprite.visible = false
		return

	var texture_size: Vector2 = sprite.texture.get_size()

	if texture_size.x <= 0.0 or texture_size.y <= 0.0:
		sprite.visible = false
		return

	var available_width: float = control_size.x * PORTRAIT_AVAILABLE_WIDTH_RATIO
	var available_height: float = control_size.y * PORTRAIT_AVAILABLE_HEIGHT_RATIO

	var scale_x: float = available_width / texture_size.x
	var scale_y: float = available_height / texture_size.y
	var scale_value: float = min(scale_x, scale_y) * PORTRAIT_SCALE_MULTIPLIER

	base_sprite_scale = Vector2(scale_value, scale_value)

	sprite.scale = base_sprite_scale
	sprite.position = get_base_sprite_position()
	sprite.visible = true


func update_sprite_motion() -> void:
	if sprite == null:
		return

	if sprite.texture == null:
		return

	if not sprite.visible:
		return

	var base_position: Vector2 = get_base_sprite_position()

	if damage_is_held:
		var shake_x: float = sin(motion_time * 34.0) * 1.5
		var shake_y: float = sin(motion_time * 27.0) * 0.8

		sprite.position = base_position + Vector2(shake_x, shake_y)
		sprite.rotation = sin(motion_time * 28.0) * 0.018
		sprite.scale = base_sprite_scale
		sprite.modulate = Color(1.0, 0.90, 0.90, 1.0)
	else:
		var idle_y: float = sin(motion_time * 1.8) * 0.8

		sprite.position = base_position + Vector2(0.0, idle_y)
		sprite.rotation = 0.0
		sprite.scale = base_sprite_scale
		sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)


func get_base_sprite_position() -> Vector2:
	return Vector2(
		size.x * 0.5 + PORTRAIT_HORIZONTAL_OFFSET,
		size.y * 0.5 + PORTRAIT_VERTICAL_OFFSET
	)


func get_string_property(target, property_name: String, default_value: String = "") -> String:
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return str(target.get(property_name))


func get_property_value(target, property_name: String, default_value = null):
	if target == null:
		return default_value

	if not object_has_property(target, property_name):
		return default_value

	return target.get(property_name)


func object_has_property(target, property_name: String) -> bool:
	if target == null:
		return false

	var property_list: Array = target.get_property_list()

	for property_data in property_list:
		if not property_data.has("name"):
			continue

		if str(property_data["name"]) == property_name:
			return true

	return false
