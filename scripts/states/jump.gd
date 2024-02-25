extends State
class_name Jump

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var player: Player = $"../.."

func enter() -> void:
	player.jump_velocity = player.jump_speed
	
	animated_sprite.play('jump_start')
	player.animation_locked = true
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = player.global_position.y + player.jump_velocity > player.shadow_sprite.global_position.y
	if player.shadow_raycast.is_colliding() && will_touch_shadow:
		player.global_position.y = player.shadow_sprite.global_position.y
		player.jump_velocity = 0.0
		Transitioned.emit(self, 'idle')
		
	player.direction = Input.get_vector("left", "right", "up", "down")
	if player.direction.length() != 0:
		player.move(player.walk_speed * delta)
	
	player.position.y += player.jump_velocity
	player.jump_velocity += (player.player_gravity * delta) / Engine.physics_ticks_per_second
