extends Node3D
class_name PlayerControls

@export var walk_speed: Vector3 = Vector3(0.7, 0, 0.6)
@export var run_speed: Vector3 = Vector3(1.5, 0, 0.9)
@export var jump_speed: float = -3.0
@export var double_press_max_time: float = 0.3

@onready var animated_sprite: AnimatedSprite3D = $"../AnimatedSprite3D"
@onready var shadow: Shadow = $"../Shadow"
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var character: Character = $".."
@onready var remote_transform_3d: RemoteTransform3D = $RemoteTransform3D

var double_press_time: float = double_press_max_time
var last_action: String = ''
var last_delta: float = 0

func _ready() -> void:
	remote_transform_3d.remote_path = '../../../MainCamera'

func _process(delta: float) -> void:
	print('state ', state_machine.current_state_name)
	double_press_time -= delta
	last_delta = delta
	
	# forward_roll()
	# block()
	# hit_short()
	# run_hit_short()
	# jump_fast_hit_short()
	walk()
	# run()
	# jump()
	# fall()
	
func walk() -> void:
	if state_machine.current_state_name == 'run':
		return
		
	if state_machine.current_state_name == 'idle'||state_machine.current_state_name == 'walk':
		var shift: Vector3 = Vector3.ZERO
		if Input.is_action_pressed('left'): shift += Vector3.LEFT
		if Input.is_action_pressed('right'): shift += Vector3.RIGHT
		if Input.is_action_pressed('up'): shift += Vector3.FORWARD
		if Input.is_action_pressed('down'): shift += Vector3.BACK
		
		shift = shift.normalized()

		# character.velocity = shift
		
		if shift.length() != 0:
			character.go_to_position = character.global_position + (shift * character.walk_speed)
			if state_machine.current_state_name != 'jump':
				print('1')
				state_machine.on_child_transition('walk')
		elif state_machine.current_state_name != 'jump'&&state_machine.current_state_name != 'idle':
			print('2')
			state_machine.on_child_transition('idle')

func block() -> void:
	var csn: String = state_machine.current_state_name
	
	if Input.is_action_just_pressed("block")&&(csn == 'idle'||csn == 'walk'||csn == 'run'):
			state_machine.on_child_transition('block')

func hit_short() -> void:
	if Input.is_action_just_pressed("hit_short")&&(state_machine.current_state_name == 'idle'||state_machine.current_state_name == 'walk'):
		state_machine.on_child_transition('hitShort')
		
func run_hit_short() -> void:
	if Input.is_action_just_pressed("hit_short")&&state_machine.current_state_name == 'run':
		state_machine.on_child_transition('runHitShort')

func jump_fast_hit_short() -> void:
	if Input.is_action_just_pressed("hit_short")&&state_machine.current_state_name == 'jumpFast':
		state_machine.on_child_transition('jumpFastHitShort')
		
func jump() -> void:
	var csn: String = state_machine.current_state_name

	if Input.is_action_just_pressed("jump")&&(csn == 'run'||csn == 'walk'||csn == 'idle'||csn == 'forwardRoll'):
		character.velocity = Vector3.ZERO
		state_machine.on_child_transition('jumpStart')

	if csn == 'jump'||csn == 'jumpHitShort':
		if Input.is_action_just_pressed("hit_short"):
			state_machine.on_child_transition('jumphitShort')
			
		var shift: Vector3 = Vector3.ZERO
		if Input.is_action_pressed('left'): shift += Vector3.LEFT
		if Input.is_action_pressed('right'): shift += Vector3.RIGHT
		if Input.is_action_pressed('up'): shift += Vector3.UP
		if Input.is_action_pressed('down'): shift += Vector3.DOWN
		
		shift = shift.normalized()
		if shift.length() != 0:
			character.velocity = character.jump_move_speed * last_delta * shift
		
func run() -> void:
	if state_machine.current_state_name == 'idle'||state_machine.current_state_name == 'walk'&&double_press_time >= 0:
		if Input.is_action_just_pressed('left'):
			state_machine.on_child_transition('run')
			character.go_to_position = character.global_position + Vector3.LEFT
		elif Input.is_action_just_pressed('right'):
			state_machine.on_child_transition('run')
			character.go_to_position = character.global_position + Vector3.RIGHT
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
			
		character.go_to_position = character.global_position + character.velocity
		
		if Input.is_action_just_pressed('left')&&character.velocity.x > 0:
			state_machine.on_child_transition('idle')
			return
		if Input.is_action_just_pressed('right')&&character.velocity.x < 0:
			state_machine.on_child_transition('idle')
			return
		
		var shift_z: float = 0
		if Input.is_action_pressed('up'): shift_z = -1
		if Input.is_action_pressed('down'): shift_z = 1
		
		var clamped_shift_z: float = clamp(shift_z * character.run_speed.y, character.run_speed.y * - 1, character.run_speed.y)
		character.go_to_position.z = character.global_position.z + clamped_shift_z
			
func forward_roll() -> void:
	var csn: String = state_machine.current_state_name
	
	if Input.is_action_just_pressed('block')&&(csn == 'run'||csn == 'jumpEnd'):
		state_machine.on_child_transition('forwardRoll')
		
	if csn == 'forwardRoll':
		var shift: Vector3 = Vector3.LEFT if character.velocity.x < 0 else Vector3.RIGHT
		character.go_to_position = character.global_position + (shift * character.run_speed)
		state_machine.on_child_transition('forwardRoll')
			
func fall() -> void:
	var csn: String = state_machine.current_state_name
	
	if csn == 'jump'||csn == 'jumpFastHitShort'||csn == 'jumpHitShort'||csn == 'jumpFast':
		return
		
	if shadow.is_above_ground == false:
		character.jump_velocity = 0
		state_machine.on_child_transition('jump')
