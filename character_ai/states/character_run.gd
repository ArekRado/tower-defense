extends State
class_name CharacterRun

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play("run")
	
func get_target_position() -> Vector3:
	var target_position: Vector3
	if character.go_to_position.length() > 0:
		target_position = character.go_to_position
	elif character.go_to_character:
		var target_character_position: Vector3 = character.go_to_character.global_position
		var character_position: Vector3 = character.global_position
		var shift_x: float = character.hit_short_range if character_position.x > target_character_position.x else character.hit_short_range * - 1
		
		target_position = target_character_position + Vector3(shift_x, 0, 0)
	else:
		push_warning("Character needs go_to_position or go_to_character to be defined")
	
	return target_position

func physics_update(delta: float) -> void:
	var target_position: Vector3 = get_target_position()
	
	var velocity: Vector3 = Vector3(target_position - character.global_position).normalized() * character.run_speed
	character.velocity.x = velocity.x
	character.velocity.z = velocity.z
	
	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

	var distance: float = character.velocity.length()
	var run_speed: Vector3 = character.run_speed * delta
	
	character.move_and_slide()
	
	if distance <= run_speed.length() * 1.2:
		Transitioned.emit('idle')
		character.go_to_position = Vector3.ZERO
		character.go_to_character = null

func update(_delta: float) -> void:
	character.update_facing_direction()