extends State
class_name CharacterJumpHitShort

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var character: Character = $"../.."
@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var hitbox_jump_hit_short: Hitbox = $"../../Hitbox/JumpHitShort"

func enter() -> void:
	hitbox_jump_hit_short.collision_shape_3d.disabled = false;
	hitbox_jump_hit_short.adjust_position_to_character_direction(character)

	if randi_range(0, 1) == 0:
		animated_sprite.play('jump_hit_short_1')
	else:
		animated_sprite.play('jump_hit_short_2')

func exit() -> void:
	hitbox_jump_hit_short.collision_shape_3d.disabled = true;

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
