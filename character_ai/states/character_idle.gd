extends State
class_name CharacterIdle

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('idle')
	var frames_count: int = animated_sprite.sprite_frames.get_frame_count('idle')
	var frame_index: int = randi_range(0, frames_count)

	animated_sprite.frame = frame_index
