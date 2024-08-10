class_name RandomShift

static func get_2(shift: Vector2) -> Vector2:
	var random_shift: Vector2 = Vector2(
		(randf() * shift.x) - shift.x / 2,
		(randf() * shift.y) - shift.y / 2
	)
	return random_shift

static func get_3(shift: Vector3) -> Vector3:
	var random_shift: Vector3 = Vector3(
		(randf() * shift.x) - shift.x / 2,
		(randf() * shift.y) - shift.y / 2,
		(randf() * shift.z) - shift.z / 2
	)
	return random_shift