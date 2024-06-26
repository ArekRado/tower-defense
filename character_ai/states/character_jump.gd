extends State
class_name CharacterJump

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var collision_shape_3d: CollisionShape3D = $"../../CollisionShape3D"

func enter() -> void:
	animated_sprite.play('jump')

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
