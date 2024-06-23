extends RayCast3D

signal collided(last_collider: Object, found_collider: Object)

var last_collider: Object

@onready var shadow: Shadow = $".."
@onready var shadow_sprite: Sprite3D = $"../Sprite3D"

func _physics_process(_delta: float) -> void:
	if is_colliding():
		shadow_sprite.show()
		shadow.is_above_ground = true
		shadow_sprite.global_position = get_collision_point()
	else:
		shadow_sprite.hide()
		shadow.is_above_ground = false

	#if shadow_raycast.is_colliding():
		#shadow_sprite.show()
		#
		#var collision_position: Vector3 = shadow_raycast.get_collision_point()
		## var collider: StaticBody3D = shadow_raycast.get_collider()
#
		#is_above_ground = true
			## var ground: Ground = collider.get_parent()
			## emit_signal("switch_ground", ground_height, ground.height)
			## ground_height = ground.height
		#
	#else:
		#is_above_ground = false
		#shadow_sprite.hide()
