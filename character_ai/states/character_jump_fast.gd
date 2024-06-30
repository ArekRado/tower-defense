extends State
class_name CharacterJumpFast

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	character.jump_velocity = character.jump_fast_height
	animated_sprite.play('jump_fast')

func physics_update(delta: float) -> void:
	character.velocity.y = character.jump_velocity

	character.move_and_slide()

	if character.is_on_floor():
		character.velocity = Vector3.ZERO
		Transitioned.emit('jumpEnd')
	else:
		character.jump_velocity -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()