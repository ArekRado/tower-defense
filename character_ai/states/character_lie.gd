extends State
class_name CharacterLie

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape2D = $"../../TransformContainer/CollisionShape2D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	animation_player.play('lie')
	animated_sprite.play('lie_back') if character.fall_direction.x > 0 else animated_sprite.play('lie_front')
	character.fall_direction = Vector2.ZERO
	collision_shape.disabled = true
	
func exit() -> void:
	collision_shape.disabled = false
