extends Node2D
class_name Character

@export var is_player: bool = false
@export var walk_speed: Vector2 = Vector2(70, 60)
@export var run_speed: Vector2 = Vector2(150, 90)
@export var jump_speed: float = -3.0
@export var short_hit_range: float = 5

@onready var animated_sprite: AnimatedSprite2D = $"TransformContainer/AnimatedSprite2D"
@onready var shadow: Shadow = $"Shadow"
@onready var transform_container: Area2D = $"TransformContainer"

@onready var player_controls: PackedScene = preload("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = preload("res://character_ai/character_ai.tscn")

var go_to_position: Vector2
var go_to_character: Character
var character_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var jump_velocity: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var was_in_air: bool = false
var is_on_floor: bool = true

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
	
	update_facing_direction()
