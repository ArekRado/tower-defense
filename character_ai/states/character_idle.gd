extends State
class_name CharacterIdle

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"

func enter() -> void:
	animated_sprite.play('idle')
