extends State
class_name CharacterJumpEnd

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('jump_end')
	
func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
