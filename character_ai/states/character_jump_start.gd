extends State
class_name CharacterJumpStart

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

func enter() -> void:
	animated_sprite.play('jump_start')
	
func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('jump')
		
func exit() -> void:
	character.jump_velocity = character.jump_height
