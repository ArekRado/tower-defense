extends State
class_name CharacterBlock

@onready var animated_sprite: AnimatedSprite3D = $"../../TransformContainer/AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('block')

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
