extends Node2D
class_name Shadow

@export var shift_y: float = 0.0

@onready var shadow_raycast: RayCast2D = $Raycast2D
@onready var shadow_sprite: Sprite2D = $Sprite2D

var is_above_ground: bool = true

func _process(_delta: float) -> void:
	is_above_ground = shadow_raycast.is_colliding()
	
	if is_above_ground:
		shadow_sprite.show()
		var collision_position: Vector2 = shadow_raycast.get_collision_point()
		
		shadow_raycast.global_position.y = collision_position.y + shift_y
		shadow_sprite.global_position.y = collision_position.y + shift_y
	else:
		shadow_sprite.hide()
