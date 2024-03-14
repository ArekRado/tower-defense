extends State
class_name Run

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var player: Player = $"../.."

func enter() -> void:
	animated_sprite.play("run")

func physics_update(delta: float) -> void:
	var run_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if run_direction.x != 0:
		if player.direction.x != 0 && run_direction.x != player.direction.x:
			Transitioned.emit(self, 'idle')
		else:
			player.direction.x = run_direction.x
	
	player.direction.y = run_direction.y
	player.move(player.run_speed * delta)
	
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit(self, 'jump')
