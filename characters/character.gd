extends Node2D
class_name Character

@export var is_player: bool = false

@export var walk_speed: Vector2 = Vector2(70, 60)
@export var run_speed: Vector2 = Vector2(150, 90)
@export var jump_move_speed: Vector2 = Vector2(70, 60)
@export var jump_fast_move_speed: Vector2 = Vector2(170, 100)
@export var jump_height: float = -3.0
@export var jump_fast_height: float = -2.2

@export var hit_short_range: float = 5
@export var hit_short_damage: float = 1
@export var hit_short_power: Vector2 = Vector2(20, 1)

@export var run_hit_short_damage: float = 2
@export var run_hit_short_power: Vector2 = Vector2(20, 1)

@export var jump_fast_hit_short_damage: float = 2
@export var jump_fast_hit_short_power: Vector2 = Vector2(20, 1)

@onready var animated_sprite: AnimatedSprite2D = $"TransformContainer/AnimatedSprite2D"
@onready var shadow: Shadow = $"Shadow"
@onready var transform_container: Area2D = $"TransformContainer"
@onready var state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var player_controls: PackedScene = preload("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = preload("res://character_ai/character_ai.tscn")
@onready var hitbox: PackedScene = preload("res://hitbox/hitbox.tscn")

var go_to_position: Vector2
var go_to_character: Character
var character_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.RIGHT
var jump_velocity: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var was_in_air: bool = false
var is_on_floor: bool = true
# Used to display shake and fall animations
var fall_direction: Vector2 = Vector2.ZERO

var hitboxInstance: Hitbox

func _ready() -> void:
	shadow.shift_y = randf_range(-0.1, -30)
	
	if is_player:
		var player_controls_instance: PlayerControls = player_controls.instantiate()
		add_child(player_controls_instance)
	else:
		var character_ai_instance: CharacterAI = character_ai.instantiate()
		add_child(character_ai_instance)
	
func update_facing_direction() -> void:
	animated_sprite.flip_h = direction.x < 0

func move(speed: Vector2) -> void:
	velocity = (direction.normalized() * speed) 
	position += velocity
	shadow.shift_y += velocity.y

	shadow.shadow_sprite.global_position.x = global_position.x
	shadow.shadow_raycast.global_position.x = global_position.x
	
	if direction.x != 0:
		update_facing_direction()
	
func on_hit(damage: float, power: Vector2) -> void:
	fall_direction = power
	animation_player.stop()
	
	if damage > 1 || state_machine.current_state_name == 'fall' || state_machine.current_state_name == 'shake':
		fall_direction += power
		state_machine.on_child_transition('fall')
	else:
		state_machine.on_child_transition('shake')

func create_hitbox(lifetime: float = 0.2, hitbox_scale: Vector2 = Vector2.ONE, hitbox_position: Vector2 = Vector2.ZERO, power: Vector2 = Vector2.ZERO, damage: float = 0.0) -> void:
	hitboxInstance = hitbox.instantiate()
	transform_container.add_child(hitboxInstance)
	hitboxInstance.lifetime = lifetime
	hitboxInstance.collision_shape_2d.scale = hitbox_scale
	hitboxInstance.collision_shape_2d.position = Vector2(-1 * hitbox_position.x if animated_sprite.is_flipped_h() else hitbox_position.x, hitbox_position.y)
	hitboxInstance.power = Vector2(power.x if animated_sprite.is_flipped_h() else -1 * power.x, hit_short_power.y * -1)
	hitboxInstance.damage = damage
	hitboxInstance.shadow_shift_y = shadow.shift_y
