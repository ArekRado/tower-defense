extends State
class_name CharacterRun

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../../Character"

func enter() -> void:
	animated_sprite.play("run")

func physics_update(delta: float) -> void:
	var run_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	
	if run_direction.x != 0:
		if character.direction.x != 0 && run_direction.x != character.direction.x:
			Transitioned.emit('idle')
		else:
			character.direction.x = run_direction.x
	
	character.direction.y = run_direction.y
	character.move(character.run_speed * delta)
	
	if Input.is_action_just_pressed("jump"):
		Transitioned.emit('jump')
