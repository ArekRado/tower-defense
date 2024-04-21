extends State
class_name CharacterJumpHitShort

@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	animation_player.play('jump_hit_short')

func get_hitbox_position() -> Vector2:
	var shift_x: float = 7 if character.velocity.x > 0 else -7
	return Vector2(shift_x, -15)

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
		character.move(character.jump_move_speed * delta)