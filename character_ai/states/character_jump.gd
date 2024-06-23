extends State
class_name CharacterJump

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var collision_shape_3d: CollisionShape3D = $"../../CollisionShape3D"

func enter() -> void:
	animated_sprite.play('jump')

func physics_update(delta: float) -> void:
	if character.is_colliding:
		character.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		character.jump_velocity = 0
		character.velocity.y = 0
		Transitioned.emit('jumpEnd')
	else:
		character.velocity.y += character.jump_velocity
		character.jump_velocity -= (character.character_gravity * delta) / Engine.physics_ticks_per_second
		
	# if character.direction.length() != 0:
	# 	character.move(character.jump_move_speed * delta)
