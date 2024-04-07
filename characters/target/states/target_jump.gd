extends State
class_name TargetJump

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var target: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"

func enter() -> void:
	transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
	Transitioned.emit('idle')

func physics_update(_delta: float) -> void:
	transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
	Transitioned.emit('idle')
