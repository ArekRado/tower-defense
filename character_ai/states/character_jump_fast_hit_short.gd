extends State
class_name CharacterJumpFastHitShort

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	animation_player.play('jump_fast_hit_short')

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
