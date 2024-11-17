extends State
class_name CharacterJumpFastHitShort

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"

func enter() -> void:
	animated_sprite.play('jump_fast_hit_short')

func physics_update(delta: float) -> void:
	character.velocity.y = character.jump_velocity

	character.move_and_slide()

	if character.is_on_floor():
		character.velocity = Vector3.ZERO
		Transitioned.emit('jumpEnd')
	else:
		character.jump_velocity -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
