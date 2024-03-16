extends State
class_name CharacterShake

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"

func enter() -> void:
	animated_sprite.play('shake')

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
