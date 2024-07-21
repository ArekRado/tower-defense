extends State
class_name CharacterJumpFast

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

func enter() -> void:
	character.jump_velocity = character.jump_fast_height
	animated_sprite.play('jump_fast')

func update(_delta: float) -> void:
	character.update_facing_direction()
	
func physics_update(delta: float) -> void:
	var target_direction: Vector3 = character.get_direction_to_target()
	var jump_fast_move_speed: Vector3 = character.jump_fast_move_speed * delta

	var velocity: Vector3 = target_direction * jump_fast_move_speed
	character.velocity.y = character.jump_velocity
	character.velocity.z = velocity.z

	character.move_and_slide()

	if character.is_on_floor():
		character.velocity = Vector3.ZERO
		Transitioned.emit('jumpEnd')
	else:
		character.jump_velocity -= gravity * delta
