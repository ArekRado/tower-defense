extends Area2D
class_name Hitbox

@export var lifetime: float = 0.0

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime < 0:
		queue_free()
