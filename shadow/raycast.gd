extends RayCast2D

signal collided(last_collider: Object, found_collider: Object)

var last_collider: Object

func _physics_process(_delta: float) -> void:
	if not is_colliding():
		if last_collider != null:
			emit_signal("collided", last_collider, null)
			last_collider = null
		return

	var found_collider: Object = get_collider()
	if found_collider != last_collider:
		emit_signal("collided", last_collider, found_collider)
		last_collider = found_collider
