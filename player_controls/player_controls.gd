extends Node2D
class_name PlayerControls

@export var walk_speed: Vector2 = Vector2(70, 60)
@export var run_speed: Vector2 = Vector2(150, 90)
@export var jump_speed: float = -3.0
@export var double_press_max_time: float = 0.3

@onready var transform_container: Area2D = $"../TransformContainer"
@onready var animated_sprite: AnimatedSprite2D = $"../TransformContainer/AnimatedSprite2D"
@onready var shadow: Shadow = $"../Shadow"
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var character: Character = $".."
@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D

var double_press_time: float = double_press_max_time
var last_action: String = ''
var last_delta: float = 0

func _ready() -> void:
	remote_transform_2d.remote_path = '../../../MainCamera'

func _process(delta: float) -> void:
	double_press_time -= delta
	last_delta = delta
	
	forward_roll()
	block()
	hit_short()
	walk()
	run()
	jump()
	
func walk() -> void:
	if state_machine.current_state_name == 'run':
		return
		
	if state_machine.current_state_name == 'idle' || state_machine.current_state_name == 'walk':
		var shift: Vector2 = Vector2.ZERO
		if Input.is_action_pressed('left'): shift += Vector2.LEFT
		if Input.is_action_pressed('right'): shift += Vector2.RIGHT
		if Input.is_action_pressed('up'): shift += Vector2.UP
		if Input.is_action_pressed('down'): shift += Vector2.DOWN
		
		shift = shift.normalized()
		
		if shift.length() != 0:
			character.go_to_position = transform_container.global_position + (shift * character.walk_speed)
			
			if state_machine.current_state_name != 'jump':
				state_machine.on_child_transition('walk')
		elif state_machine.current_state_name != 'jump' && state_machine.current_state_name != 'idle':
			state_machine.on_child_transition('idle')

func block() -> void:
	if Input.is_action_just_pressed("block") && (state_machine.current_state_name == 'idle' || state_machine.current_state_name == 'walk' || state_machine.current_state_name == 'run') :
		state_machine.on_child_transition('block')

func hit_short() -> void:
	if Input.is_action_just_pressed("hit_short") && (state_machine.current_state_name == 'idle' || state_machine.current_state_name == 'walk' || state_machine.current_state_name == 'run') :
		state_machine.on_child_transition('hitShort')

func jump() -> void:
	var csn: String = state_machine.current_state_name

	if Input.is_action_just_pressed("jump") && (csn == 'run' || csn == 'walk' || csn == 'idle' || csn == 'forwardRoll'):
		character.direction = Vector2.ZERO
		state_machine.on_child_transition('jumpStart')

	if csn == 'jump' || csn == 'jumpHitShort':
		if Input.is_action_just_pressed("hit_short"):
			state_machine.on_child_transition('jumphitShort')
			
		var shift: Vector2 = Vector2.ZERO
		if Input.is_action_pressed('left'): shift += Vector2.LEFT
		if Input.is_action_pressed('right'): shift += Vector2.RIGHT
		if Input.is_action_pressed('up'): shift += Vector2.UP
		if Input.is_action_pressed('down'): shift += Vector2.DOWN
		
		shift = shift.normalized()
		if shift.length() != 0:
			character.direction = character.jump_move_speed * last_delta * shift
		
func run() -> void:
	if state_machine.current_state_name == 'idle' || state_machine.current_state_name == 'walk' && double_press_time >= 0:
		if Input.is_action_just_pressed('left'):
			state_machine.on_child_transition('run')
			character.go_to_position = transform_container.global_position + Vector2.LEFT
		elif Input.is_action_just_pressed('right'):
			state_machine.on_child_transition('run')
			character.go_to_position = transform_container.global_position + Vector2.RIGHT
	else:
		if Input.is_action_just_pressed('left'):
			last_action = 'left'
			double_press_time = double_press_max_time
		elif Input.is_action_just_pressed('right'):
			last_action = 'right'
			double_press_time = double_press_max_time
		else:
			double_press_time = 0
			
	if state_machine.current_state_name == 'run':
		if Input.is_action_just_pressed("jump"):
			state_machine.on_child_transition('jumpFast')
			
		character.go_to_position = character.transform_container.global_position + character.direction
		
		if Input.is_action_just_pressed('left') && character.direction.x > 0:
			state_machine.on_child_transition('idle')
			return
		if Input.is_action_just_pressed('right') && character.direction.x < 0:
			state_machine.on_child_transition('idle')
			return
		
		var shift_y: float = 0
		if Input.is_action_pressed('up'): shift_y = -1
		if Input.is_action_pressed('down'): shift_y = 1
		
		var clamped_shift_y: float = clamp(shift_y * character.run_speed.y, character.run_speed.y * -1, character.run_speed.y)
		character.go_to_position.y = character.transform_container.global_position.y + clamped_shift_y
			
func forward_roll() -> void:
	if state_machine.current_state_name == 'run' && Input.is_action_just_pressed('block'):
		state_machine.on_child_transition('forwardRoll')
