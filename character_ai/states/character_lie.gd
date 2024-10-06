extends State
class_name CharacterLie

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape3D = $"../../CollisionShape3D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animation_player.play('lie')

	if character.fall_direction.x > 0:
		animated_sprite.play('lie_back')
	else:
		animated_sprite.play('lie_front')

	character.fall_direction = Vector3.ZERO
	character.disable_collision_with_hitboxes = true
	character.disable_collision_with_hitboxes_timer = 125.0
	
func exit() -> void:
	character.disable_collision_with_hitboxes = false
	character.disable_collision_with_hitboxes_timer = 0.0

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
