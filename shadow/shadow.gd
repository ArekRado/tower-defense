extends Node2D
class_name Shadow

signal switch_ground(current_ground_height: float, new_ground_height: float)

@export var shift_y: float = 0.0

@onready var shadow_raycast: RayCast2D = $Raycast2D
@onready var shadow_sprite: Sprite2D = $Sprite2D

var is_above_ground: bool = true
var ground_height: float = 0.0

func _on_raycast_2d_collided(last_collider: Object, found_collider: Object) -> void:
	if shadow_raycast.is_colliding():
		shadow_sprite.show()
		
		var collision_position: Vector2 = shadow_raycast.get_collision_point()
		var collider: StaticBody2D = shadow_raycast.get_collider()

		if collider.name == 'TopEdges':
			is_above_ground = false
			shadow_sprite.hide()
			return
		else:
			is_above_ground = true
			var ground: Ground = collider.get_parent()
			emit_signal("switch_ground", ground_height, ground.height)
			ground_height = ground.height
		
		#shadow_raycast.global_position.y = collision_position.y + shift_y
		#shadow_sprite.global_position.y = collision_position.y + shift_y
	else:
		is_above_ground = false
		shadow_sprite.hide()
