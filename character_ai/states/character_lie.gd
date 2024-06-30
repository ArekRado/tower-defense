extends State
class_name CharacterLie

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape3D = $"../../CollisionShape3D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animation_player.play('lie')
	animated_sprite.play('lie_back') if character.fall_direction.x > 0 else animated_sprite.play('lie_front')
	character.fall_direction = Vector3.ZERO
	collision_shape.disabled = true
	
func exit() -> void:
	collision_shape.disabled = false

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
