extends State
class_name CharacterLie

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape3D = $"../../CollisionShape3D"

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play('lie')

	if character.fall_direction.x > 0:
		animated_sprite.play('lie_back')
	else:
		animated_sprite.play('lie_front')

	character.fall_direction = Vector3.ZERO
	character.disable_collision_with_hitboxes = true
	await Wait.seconds(get_tree(), 3)
	Transitioned.emit('idle')
	
func exit() -> void:
	character.disable_collision_with_hitboxes = false

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
