extends State
class_name CharacterJumpFast

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"

func enter() -> void:
	character.jump_velocity = character.jump_fast_height
	animated_sprite.play('jump')

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = transform_container.global_position.y > shadow.shadow_sprite.global_position.y
	
	if shadow.is_above_ground && will_touch_shadow:
		transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		character.jump_velocity = 0
		Transitioned.emit('jumpEnd')
	else:
		transform_container.global_position.y += character.jump_velocity
		character.jump_velocity += (character.character_gravity * delta) / Engine.physics_ticks_per_second
	
	if character.direction.length() != 0:
		character.move(character.jump_fast_move_speed * delta)
	
