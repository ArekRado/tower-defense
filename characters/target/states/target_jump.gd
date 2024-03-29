extends State
class_name TargetJump

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var target: Target = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"

func enter() -> void:
	target.jump_velocity = target.jump_speed
	animated_sprite.play('jump_start')

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = transform_container.global_position.y > shadow.shadow_sprite.global_position.y
	
	if shadow.is_above_ground && will_touch_shadow:
		transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		target.jump_velocity = 0
		Transitioned.emit('idle')
	else:
		transform_container.global_position.y += target.jump_velocity
		target.jump_velocity += (target.target_gravity * delta) / Engine.physics_ticks_per_second
	
