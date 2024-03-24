extends State
class_name PlayerJump

#@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
#@onready var player: Player = $"../.."
#@onready var shadow: Shadow = $"../../Shadow"
#
#func enter() -> void:
	#player.jump_velocity = player.jump_speed
	#animated_sprite.play('jump_start')
#
#func physics_update(delta: float) -> void:
	#var will_touch_shadow: bool = player.transform_container.global_position.y > shadow.shadow_sprite.global_position.y
	#
	#if shadow.is_above_ground && will_touch_shadow:
		#player.transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		#player.jump_velocity = 0
		#Transitioned.emit('idle')
	#else:
		#player.transform_container.global_position.y += player.jump_velocity
		#player.jump_velocity += (player.player_gravity * delta) / Engine.physics_ticks_per_second
	#
	#player.direction = Input.get_vector("left", "right", "up", "down")
	#if player.direction.length() != 0:
		#player.move(player.walk_speed * delta)
	#
