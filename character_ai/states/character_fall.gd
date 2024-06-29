extends State
class_name CharacterFall

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	character.jump_velocity = character.fall_direction.y
	character.global_position.y += - 1
	animated_sprite.play('fall_back') if character.fall_direction.x > 0 else animated_sprite.play('fall_front')

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = character.global_position.y > shadow.shadow_sprite.global_position.y
	
	character.move_and_slide()

	if shadow.is_above_ground&&will_touch_shadow:
		character.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		character.jump_velocity = 0
		Transitioned.emit('lie')
	else:
		character.global_position.y += character.jump_velocity
		
		character.jump_velocity += gravity * delta
	
	# if character.velocity.length() != 0:
		# character.move(character.fall_direction * delta * - 1)

func update(_delta: float) -> void:
	character.update_facing_direction()
