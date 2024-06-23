extends State
class_name TargetJump

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var target: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"

func enter() -> void:
	target.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
	Transitioned.emit('idle')

func physics_update(_delta: float) -> void:
	target.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
	Transitioned.emit('idle')
