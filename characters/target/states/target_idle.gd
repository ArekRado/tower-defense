extends State
class_name TargetIdle

@onready var animated_sprite: AnimatedSprite3D = $"../../TransformContainer/AnimatedSprite3D"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	animated_sprite.play('idle')
	animation_player.stop()
