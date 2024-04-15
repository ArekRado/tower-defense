extends State
class_name CharacterLie

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape2D =$"../../TransformContainer/CollisionShape2D"

func enter() -> void:
	animated_sprite.play('lie_back') if character.fall_direction.x > 0 else animated_sprite.play('lie_front')
	character.fall_direction = Vector2.ZERO
	collision_shape.disabled = true
	
func exit() -> void:
	collision_shape.disabled = false

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
