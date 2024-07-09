extends State
class_name CharacterIdle

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play('idle')
	character.velocity = Vector3.ZERO
	var frames_count: int = animated_sprite.sprite_frames.get_frame_count('idle')
	var frame_index: int = randi_range(0, frames_count)

	animated_sprite.frame = frame_index

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()