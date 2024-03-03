extends Node2D
class_name Player

@export var walk_speed: Vector2 = Vector2(70, 60)
@export var run_speed: Vector2 = Vector2(150, 90)
@export var jump_speed: float = -3.0
@export var double_press_max_time: float = 0.3

@onready var transform_container: Area2D = $TransformContainer
@onready var animated_sprite: AnimatedSprite2D = $TransformContainer/AnimatedSprite2D
@onready var shadow: Shadow = $Shadow
@onready var state_machine: StateMachine = $StateMachine

var player_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var jump_velocity: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var was_in_air: bool = false
var is_on_floor: bool = true

var double_press_time:float = double_press_max_time
var last_action: String = ''

func _ready() -> void:
	shadow.shift_y = randf_range(-0.1, -30)

func _process(delta: float) -> void:
	double_press_time -= delta

func _input(event: InputEvent) -> void:
	if event is InputEventKey && event.is_pressed():
		if double_press_time >= 0 && state_machine.current_state_name == 'idle':
			if Input.is_action_just_pressed('left') || Input.is_action_just_pressed('right'):
				state_machine.on_child_transition(state_machine.current_state, 'run')
		else:
			if Input.is_action_just_pressed('left'):
				last_action = 'left'
				double_press_time = double_press_max_time
			elif Input.is_action_just_pressed('right'):
				last_action = 'right'
				double_press_time = double_press_max_time
			else:
				double_press_time = 0

func update_facing_direction() -> void:
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true

func get_sprite_size() -> Vector2:
	return animated_sprite.sprite_frames.get_frame_texture("idle", 0).get_size() * animated_sprite.get_scale()
		
func get_speed() -> Vector2:
	if animated_sprite.animation == 'run':
		return run_speed
	else:
		return walk_speed

func move(speed: Vector2) -> void: 
	velocity = (direction * speed) 
	transform_container.position += velocity
	shadow.shift_y += velocity.y

	shadow.shadow_sprite.global_position.x = transform_container.global_position.x
	shadow.shadow_raycast.global_position.x = transform_container.global_position.x
