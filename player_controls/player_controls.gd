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

var double_press_time: float = double_press_max_time
var last_action: String = ''

@onready var remote_transform_2d: RemoteTransform2D = $RemoteTransform2D


func _ready() -> void:
	remote_transform_2d.remote_path = '../../../MainCamera'

func _process(delta: float) -> void:
	double_press_time -= delta

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		#
		# WALK
		#
		if state_machine.current_state_name == 'idle' || state_machine.current_state_name == 'walk' || state_machine.current_state_name == 'jump':
			var shift: Vector2 = Vector2.ZERO
			if Input.is_action_pressed('left'): shift += Vector2.LEFT
			if Input.is_action_pressed('right'): shift += Vector2.RIGHT
			if Input.is_action_pressed('up'): shift += Vector2.UP
			if Input.is_action_pressed('down'): shift += Vector2.DOWN
			
			shift = shift.normalized()
			
			if shift.length() != 0:
				character.go_to_position = transform_container.global_position + (shift * character.walk_speed * 10)
				state_machine.on_child_transition('walk')
			else:
				state_machine.on_child_transition('idle')
		
		if state_machine.current_state_name != 'idle':
			return
		#
		# HIT SHORT
		#
		if Input.is_action_just_pressed("hit_short"):
			state_machine.on_child_transition('hitShort')
			return
			
		#
		# Jump
		#
		if Input.is_action_just_pressed("jump"):
			state_machine.on_child_transition('jump')
			return
			
		#
		# RUN
		#
		if double_press_time >= 0:
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
		


#func update_facing_direction() -> void:
	#animated_sprite.flip_h = direction.x < 0

#func get_sprite_size() -> Vector2:
	#return animated_sprite.sprite_frames.get_frame_texture("idle", 0).get_size() * animated_sprite.get_scale()
		
#func get_speed() -> Vector2:
	#if animated_sprite.animation == 'run':
		#return run_speed
	#else:
		#return walk_speed

#func move(speed: Vector2) -> void: 
	#velocity = (direction * speed) 
	#position += velocity
	#shadow.shift_y += velocity.y
#
	#shadow.shadow_sprite.global_position.x = global_position.x
	#shadow.shadow_raycast.global_position.x = global_position.x
