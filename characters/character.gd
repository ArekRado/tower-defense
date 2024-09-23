extends CharacterBody3D
class_name Character

@export_category('general')
@export var is_player: bool = false
@export var player: Player

@export_category('movement')
@export var walk_speed: Vector3
@export var run_speed: Vector3

@export_category('jump')
@export var jump_move_speed: Vector3
@export var jump_fast_move_speed: Vector3
@export var jump_height: float
@export var jump_fast_height: float

@export_category('hit short')
@export var hit_short_range: float
@export var hit_short_damage: float
@export var hit_short_power: Vector3

@export_category('run hit short')
@export var run_hit_short_damage: float
@export var run_hit_short_power: Vector3

@export_category('jump fast hit short')
@export var jump_fast_hit_short_damage: float
@export var jump_fast_hit_short_power: Vector3

@onready var animated_sprite: AnimatedSprite3D = $"AnimatedSprite3D"
@onready var shadow: Shadow = $"Shadow"
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player_marker: PlayerMarker = $PlayerMarker

@onready var player_controls: PackedScene = load("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = load("res://character_ai/character_ai.tscn")
@onready var hitbox: PackedScene = load("res://hitbox/hitbox.tscn")

# true - right; false - left
var direction: bool = true
var height: float = 0.0
var go_to_position: Vector3
var go_to_character: Character
var jump_velocity: float = 0.0
var is_movement_blocked: bool = false
# Used to display shake and fall animations
var fall_direction: Vector3 = Vector3.ZERO
var assigned_city_name: String
var assigned_structure_name: String

var hitbox_instance: Hitbox

func _ready() -> void:
	initialize_data()

func initialize_data() -> void:
	if !player:
		return
		
	player_marker.set_color(player.color)
	
	if is_player:
		var player_controls_instance: PlayerControls = player_controls.instantiate()
		add_child(player_controls_instance)
		set_collision_layer_value(7, true)
	else:
		var character_ai_instance: CharacterAI = character_ai.instantiate()
		add_child(character_ai_instance)

func _process(_delta: float) -> void:
	if velocity.x > 0:
		direction = true
	elif velocity.x < 0:
		direction = false
	
func update_facing_direction() -> void:
	if velocity.x < 0: animated_sprite.flip_h = true
	elif velocity.x > 0: animated_sprite.flip_h = false

func on_hit(damage: float, power: Vector3) -> void:
	fall_direction = power
	animation_player.stop()
	
	if damage > 1 || state_machine.current_state_name == 'fall' || state_machine.current_state_name == 'shake':
		fall_direction += power
		state_machine.on_child_transition('fall')
	else:
		state_machine.on_child_transition('shake')

func create_hitbox(lifetime: float = 0.2, hitbox_scale: Vector3 = Vector3.ONE, hitbox_position: Vector3 = Vector3.ZERO, power: Vector3 = Vector3.ZERO, damage: float = 0.0) -> void:
	hitbox_instance = hitbox.instantiate()
	add_child(hitbox_instance)
	hitbox_instance.lifetime = lifetime
	hitbox_instance.collision_shape_3d.scale = hitbox_scale
	hitbox_instance.collision_shape_3d.position = Vector3(-1 * hitbox_position.x if animated_sprite.is_flipped_h() else hitbox_position.x, hitbox_position.y, 0)
	hitbox_instance.power = Vector3(power.x if animated_sprite.is_flipped_h() else -1 * power.x, hit_short_power.y * -1, 0)
	hitbox_instance.damage = damage

func get_direction_to_target() -> Vector3:
	var direction_to_target: Vector3
	if is_player:
		if go_to_position.length() > 0:
			direction_to_target = go_to_position - global_position
	else:
		if go_to_position.length() > 0:
			navigation_agent_3d.target_position = go_to_position
			var next_path_target: Vector3 = global_position.direction_to(navigation_agent_3d.get_next_path_position())
			direction_to_target = next_path_target
		elif go_to_character:
			navigation_agent_3d.target_position = go_to_character.global_position
			var next_path_target: Vector3 = global_position.direction_to(navigation_agent_3d.get_next_path_position())
			direction_to_target = next_path_target
		else:
			push_warning("Character needs go_to_position or go_to_character to be defined")

	direction_to_target = direction_to_target.normalized()
	return direction_to_target

# block
# fall_back
# fall_front
# forward_roll
# hit_short_1
# hit_short_2
# idle
# jump
# jump_end
# jump_fast
# jump_fast_hit_short
# jump_hit_short_1
# jump_hit_short_2
# jump_start
# lie_back
# lie_front
# run
# run_hit_short
# shake_back
# shake_front
# walk
