extends Node2D
class_name Character

@export var walk_speed: Vector2 = Vector2(70, 60)
@export var run_speed: Vector2 = Vector2(150, 90)
@export var jump_speed: float = -3.0
@export var short_hit_range: float = 5

@onready var animated_sprite: AnimatedSprite2D = $"../TransformContainer/AnimatedSprite2D"
@onready var shadow: Shadow = $"../Shadow"
@onready var main_container: Node2D = $".."
@onready var transform_container: Area2D = $"../TransformContainer"

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
	
func update_facing_direction() -> void:
	animated_sprite.flip_h = direction.x < 0

func move(speed: Vector2) -> void: 
	velocity = (direction.normalized() * speed) 
	main_container.position += velocity
	shadow.shift_y += velocity.y

	shadow.shadow_sprite.global_position.x = global_position.x
	shadow.shadow_raycast.global_position.x = global_position.x
	
	update_facing_direction()