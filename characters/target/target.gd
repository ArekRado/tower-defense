extends Node2D
class_name Target

@export var jump_speed: float = -3.0

@onready var animated_sprite: AnimatedSprite2D = $"TransformContainer/AnimatedSprite2D"
@onready var shadow: Shadow = $"Shadow"
@onready var transform_container: Area2D = $"TransformContainer"

@onready var player_controls: PackedScene = preload("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = preload("res://character_ai/character_ai.tscn")

var target_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var jump_velocity: float = 0.0
var velocity: Vector2 = Vector2.ZERO
#var was_in_air: bool = false
#var is_on_floor: bool = true
