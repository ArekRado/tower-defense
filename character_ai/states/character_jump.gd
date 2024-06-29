extends State
class_name CharacterJump

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var collision_shape_3d: CollisionShape3D = $"../../CollisionShape3D"

func enter() -> void:
	animated_sprite.play('jump')

func physics_update(delta: float) -> void:
	character.velocity.y += character.jump_velocity

	print(character.velocity)
	character.move_and_slide()

	if character.is_on_floor():
		character.velocity.y = 0
		Transitioned.emit('jumpEnd')
	else:
		character.jump_velocity -= (gravity * delta) / 100
		
	# if character.direction.length() != 0:
	# 	character.move(character.jump_move_speed * delta)

func update(_delta: float) -> void:
	character.update_facing_direction()
