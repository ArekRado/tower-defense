extends State
class_name CharacterRun

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

func enter() -> void:
	animated_sprite.play("run")

func update(_delta: float) -> void:
	character.update_facing_direction()
	
func physics_update(delta: float) -> void:
	var target_direction: Vector3 = character.get_direction_to_target()
	var run_speed: Vector3 = character.run_speed * delta
	
	var velocity: Vector3 = target_direction * run_speed
	character.velocity.x = velocity.x
	character.velocity.z = velocity.z
	
	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

	character.move_and_slide()
	
	if character.velocity.length() == 0||character.navigation_agent_3d.is_navigation_finished():
		Transitioned.emit('idle')
		character.go_to_character = null
