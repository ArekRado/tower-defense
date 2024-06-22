extends Node3D
class_name Character

@export_category('general')
@export var is_player: bool = false

@export_category('movement')
@export var walk_speed: Vector3 = Vector3(70, 60, 0)
@export var run_speed: Vector3 = Vector3(150, 90, 0)

@export_category('jump')
@export var jump_move_speed: Vector3 = Vector3(70, 60, 0)
@export var jump_fast_move_speed: Vector3 = Vector3(170, 100, 0)
@export var jump_height: float = -3.0
@export var jump_fast_height: float = -2.2

@export_category('hit short')
@export var hit_short_range: float = 5
@export var hit_short_damage: float = 1
@export var hit_short_power: Vector3 = Vector3(20, 1, 0)

@export_category('run hit short')
@export var run_hit_short_damage: float = 2
@export var run_hit_short_power: Vector3 = Vector3(20, 1, 0)

@export_category('jump fast hit short')
@export var jump_fast_hit_short_damage: float = 2
@export var jump_fast_hit_short_power: Vector3 = Vector3(20, 1, 0)

@onready var animated_sprite: AnimatedSprite3D = $"TransformContainer/AnimatedSprite3D"
@onready var shadow: Shadow = $"Shadow"
@onready var transform_container: Area3D = $"TransformContainer"
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var player_controls: PackedScene = preload ("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = preload ("res://character_ai/character_ai.tscn")
@onready var hitbox: PackedScene = preload ("res://hitbox/hitbox.tscn")

var height: float = 0.0
var go_to_position: Vector3
var go_to_character: Character
var character_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector3 = Vector3.RIGHT
var jump_velocity: float = 0.0
var velocity: Vector3 = Vector3.ZERO
var is_movement_blocked: bool = false
# Used to display shake and fall animations
var fall_direction: Vector3 = Vector3.ZERO

var hitbox_instance: Hitbox

func _ready() -> void:
	shadow.shift_y = randf_range( - 0.1, -30)
	
	if is_player:
		var player_controls_instance: PlayerControls = player_controls.instantiate()
		add_child(player_controls_instance)
	else:
		var character_ai_instance: CharacterAI = character_ai.instantiate()
		add_child(character_ai_instance)
	
func update_facing_direction() -> void:
	animated_sprite.flip_h = direction.x < 0

func move(speed: Vector3) -> void:
	if is_movement_blocked == true:
		return

	velocity = (direction.normalized() * speed)
	position += velocity
	shadow.shift_y += velocity.y

	shadow.shadow_sprite.global_position.x = global_position.x
	shadow.shadow_raycast.global_position.x = global_position.x
	
	# z_index = global_position.y - shadow.shift_y
	
	if direction.x != 0:
		update_facing_direction()
	
func on_hit(damage: float, power: Vector3) -> void:
	fall_direction = power
	animation_player.stop()
	
	if damage > 1||state_machine.current_state_name == 'fall'||state_machine.current_state_name == 'shake':
		fall_direction += power
		state_machine.on_child_transition('fall')
	else:
		state_machine.on_child_transition('shake')

func create_hitbox(lifetime: float=0.2, hitbox_scale: Vector3=Vector3.ONE, hitbox_position: Vector3=Vector3.ZERO, power: Vector3=Vector3.ZERO, damage: float=0.0) -> void:
	hitbox_instance = hitbox.instantiate()
	transform_container.add_child(hitbox_instance)
	hitbox_instance.lifetime = lifetime
	hitbox_instance.collision_shape_2d.scale = hitbox_scale
	hitbox_instance.collision_shape_2d.position = Vector3( - 1 * hitbox_position.x if animated_sprite.is_flipped_h() else hitbox_position.x, hitbox_position.y, 0)
	hitbox_instance.power = Vector3(power.x if animated_sprite.is_flipped_h() else - 1 * power.x, hit_short_power.y * - 1, 0)
	hitbox_instance.damage = damage
	hitbox_instance.shadow_shift_y = shadow.shift_y

func _on_shadow_switch_ground(current_ground_height: float, new_ground_height: float) -> void:
	var diff: float = current_ground_height - new_ground_height

	if diff > 0:
		state_machine.on_child_transition('jump')
	else:
		state_machine.on_child_transition('idle')
		# is_movement_blocked = true
		# transform_container.global_position.y += diff

	shadow.shadow_sprite.global_position.y += diff
	shadow.shadow_raycast.global_position.y += diff
