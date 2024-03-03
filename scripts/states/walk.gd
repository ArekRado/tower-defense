extends State
class_name Walk

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var player: Player = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	animated_sprite.play("walk")

func physics_update(delta: float) -> void:
	player.direction = Input.get_vector("left", "right", "up", "down")
	if player.direction.length() != 0:
		player.move(player.walk_speed * delta)
		player.update_facing_direction()
	else: 
		Transitioned.emit(self, 'idle')
		
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'jump')

	if shadow.shadow_sprite.global_position.y - player.transform_container.global_position.y > 0.2:
		Transitioned.emit(self, 'jump')
