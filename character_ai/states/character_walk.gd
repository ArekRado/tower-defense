extends State
class_name Walk

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"

func enter() -> void:
	animated_sprite.play("walk")
	
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

func physics_update(delta: float) -> void:
	var target_position: Vector2 = get_target_position()
	
	character.direction = target_position - character.transform_container.global_position
	var distance: float = character.direction.length()
	var walk_speed: Vector2 = character.walk_speed * delta
	
	if distance != 0:
		character.move(walk_speed)
		
		if distance <= walk_speed.length() * 1.2:
			Transitioned.emit('idle')
			character.go_to_position = Vector2.ZERO
			character.go_to_character = null
	else: 
		Transitioned.emit('idle')
