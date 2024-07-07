extends State
class_name CharacterWalk

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play("walk")

func exit() -> void:
	character.velocity = Vector3.ZERO
	
func update(_delta: float) -> void:
	character.update_facing_direction()

func physics_update(delta: float) -> void:
	var target_direction: Vector3 = character.get_direction_to_target()
	var walk_speed: Vector3 = character.walk_speed * delta

	var velocity: Vector3 = target_direction * walk_speed
	character.velocity.x = velocity.x
	character.velocity.z = velocity.z
			
	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta
		
	character.move_and_slide()

	if character.velocity.length() == 0||character.navigation_agent_3d.is_navigation_finished():
		Transitioned.emit('idle')
		character.go_to_character = null