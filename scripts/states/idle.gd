extends State
class_name Idle

@onready var animated_sprite: AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var player: Player = $"../.."

func enter() -> void:
	animated_sprite.play('idle')
	pass
	
func exit() -> void:
	pass
	
func update(delta: float) -> void:
	var direction:Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction.length() != 0:
		Transitioned.emit(self, 'walk')
	
	if Input.is_action_just_pressed("jump") && player.is_on_floor == true:
		Transitioned.emit(self, 'jump')

func physics_update(delta: float) -> void:
	pass
