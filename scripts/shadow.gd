extends Node2D
class_name Shadow

@export var shift_y: float = 0.0

@onready var shadow_raycast: RayCast2D = $Raycast2D
@onready var shadow_sprite: Sprite2D = $Sprite2D

#var global_position: Vector2 = Vector2.ZERO
#var position: Vector2 = Vector2.ZERO
var is_above_ground: bool = true

#func _ready() -> void:
	#global_position = shadow_sprite.global_position
	#position = shadow_sprite.position
	
func _physics_process(_delta: float) -> void:
	is_above_ground = shadow_raycast.is_colliding()
	
	if is_above_ground:
		shadow_sprite.show()
		var collision_position: Vector2 = shadow_raycast.get_collision_point()

		#shadow_sprite.global_position.x = collision_position.x
		shadow_sprite.global_position.y = collision_position.y + shift_y
	else :
		shadow_sprite.hide()
