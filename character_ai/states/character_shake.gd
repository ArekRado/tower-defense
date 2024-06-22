extends State
class_name CharacterShake

@onready var animated_sprite: AnimatedSprite3D = $"../../TransformContainer/AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('shake_front')

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
