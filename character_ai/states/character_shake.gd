extends State
class_name CharacterShake

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play('shake_front')

func update(delta: float) -> void:
	character.update_facing_direction()
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
	
	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func physics_update(_delta: float) -> void:
	character.update_facing_direction()
	character.move_and_slide()