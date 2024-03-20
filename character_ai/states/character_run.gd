extends State
class_name CharacterRun

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../../Character"

func enter() -> void:
	animated_sprite.play("run")
	
func get_target_position() -> Vector2:
	var target_position: Vector2
	if character.go_to_position.length() > 0:
		target_position = character.go_to_position
	elif character.go_to_character:
		var target_character_position: Vector2 = character.go_to_character.transform_container.global_position
		var character_position: Vector2 = character.transform_container.global_position
		var shift_x: float = character.short_hit_range if character_position.x > target_character_position.x else character.short_hit_range * -1
		
		target_position = target_character_position + Vector2(shift_x, 0)
	else:
		push_warning("Character needs go_to_position or go_to_character to be defined")
	
	return target_position

#func physics_update(delta: float) -> void:
	#var run_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	#
	#if run_direction.x != 0:
		#if character.direction.x != 0 && run_direction.x != character.direction.x:
			#Transitioned.emit('idle')
		#else:
			#character.direction.x = run_direction.x
	#
	#character.direction.y = run_direction.y
	#character.move(character.run_speed * delta)
	#
	#if Input.is_action_just_pressed("jump"):
		#Transitioned.emit('jump')

func physics_update(delta: float) -> void:
	var target_position: Vector2 = get_target_position()
	
	character.direction = target_position - character.transform_container.global_position
	var distance: float = character.direction.length()
	var run_speed: Vector2 = character.run_speed * delta
	
	if distance != 0:
		character.move(run_speed)
		
		if distance <= run_speed.length() * 1.2:
			Transitioned.emit('idle')
			character.go_to_position = Vector2.ZERO
			character.go_to_character = null
	else: 
		Transitioned.emit('idle')
