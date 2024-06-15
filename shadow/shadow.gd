extends Node2D
class_name Shadow

@export var shift_y: float = 0.0

@onready var shadow_raycast: RayCast2D = $Raycast2D
@onready var shadow_sprite: Sprite2D = $Sprite2D

var is_above_ground: bool = true

func _on_raycast_2d_collided(last_collider: Object, found_collider: Object) -> void:
	is_above_ground = shadow_raycast.is_colliding()
	
	if is_above_ground:
		shadow_sprite.show()

		var collision_position: Vector2 = shadow_raycast.get_collision_point()
		shadow_raycast.global_position.y = collision_position.y + shift_y
		shadow_sprite.global_position.y = collision_position.y + shift_y
		
		var collider: Object = shadow_raycast.get_collider()
		if "get_parent" in collider:
			@warning_ignore("unsafe_method_access")
			var ground: Object = collider.get_parent()
			#var ground_collider: Object = shadow_raycast.get_collider()
				
			if "height" in ground:
				@warning_ignore("unsafe_property_access")
				print(ground.height)
			
	else:
		shadow_sprite.hide()
