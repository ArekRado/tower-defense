extends State
class_name CharacterFall

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	character.position.y += 0.2
	character.jump_velocity = character.fall_direction.y
	character.velocity.x = character.fall_direction.x

	if character.fall_direction.x > 0:
		animated_sprite.play('fall_back')
	else:
		animated_sprite.play('fall_front')

func physics_update(delta: float) -> void:
	character.velocity.y = character.jump_velocity

	character.move_and_slide()

	if character.is_on_floor():
		character.velocity = Vector3.ZERO
		Transitioned.emit('lie')
	else:
		character.jump_velocity -= gravity * delta
	
func update(_delta: float) -> void:
	character.update_facing_direction()
