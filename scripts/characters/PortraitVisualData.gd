extends Resource
class_name PortraitVisualData

var idle_frames: Array[Texture2D] = []
var damage_frame: Texture2D = null


func _init(
	p_idle_frames: Array[Texture2D] = [],
	p_damage_frame: Texture2D = null
) -> void:
	idle_frames = p_idle_frames.duplicate()
	damage_frame = p_damage_frame
