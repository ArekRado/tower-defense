extends State
class_name TargetIdle

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('idle')
