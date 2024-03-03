extends State
class_name Idle

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var player: Player = $"../.."

func enter() -> void:
	animated_sprite.play('idle')

func update(_delta: float) -> void:
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction.length() != 0:
		Transitioned.emit(self, 'walk')
	
	if Input.is_action_just_pressed("jump") && player.is_on_floor == true:
		Transitioned.emit(self, 'jump')
		
	if Input.is_action_just_pressed("hit_short"):
		Transitioned.emit(self, 'hit_short')