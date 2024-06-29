extends State
class_name CharacterBlock

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

func enter() -> void:
	animated_sprite.play('block')

func update(_delta: float) -> void:
	character.update_facing_direction()
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')

func physics_update(_delta: float) -> void:
	character.move_and_slide()