extends State
class_name CharacterForwardRoll

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."
@onready var collision_shape: CollisionShape3D = $"../../CollisionShape3D"

var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")

func enter() -> void:
	animated_sprite.play("forward_roll")
	collision_shape.disabled = true
	
func exit() -> void:
	collision_shape.disabled = false
	
func update(_delta: float) -> void:
	character.update_facing_direction()
	if animated_sprite.is_playing() == false:
		character.velocity = Vector3.ZERO
		Transitioned.emit('idle')

func physics_update(delta: float) -> void:
	var target_direction: Vector3 = character.get_direction_to_target()
	var run_speed: Vector3 = character.run_speed * delta
	
	var velocity: Vector3 = target_direction * run_speed
	
	character.move_and_slide()
	
	if character.velocity.length() == 0||character.navigation_agent_3d.is_navigation_finished():
		Transitioned.emit('idle')
		character.go_to_character = null
