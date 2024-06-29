extends State
class_name CharacterJumpFast

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	character.jump_velocity = character.jump_fast_height
	animated_sprite.play('jump_fast')

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = character.global_position.y > shadow.shadow_sprite.global_position.y
	
	if shadow.is_above_ground&&will_touch_shadow:
		character.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		character.jump_velocity = 0
		Transitioned.emit('jumpEnd')
	else:
		character.global_position.y += character.jump_velocity
		character.jump_velocity += gravity * delta
	
	if character.velocity.length() != 0:
		character.move_and_slide()
		# character.move(character.jump_fast_move_speed * delta)

func update(_delta: float) -> void:
	character.update_facing_direction()