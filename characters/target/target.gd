extends Node3D
class_name Target

@export var jump_speed: float = -3.0

@onready var animated_sprite: AnimatedSprite3D = $"TransformContainer/AnimatedSprite3D"
@onready var shadow: Shadow = $"Shadow"
@onready var transform_container: Area3D = $"TransformContainer"

@onready var player_controls: PackedScene = preload ("res://player_controls/player_controls.tscn")
@onready var character_ai: PackedScene = preload ("res://character_ai/character_ai.tscn")

var target_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector3 = Vector3.ZERO
var jump_velocity: float = 0.0
var velocity: Vector3 = Vector3.ZERO
#var was_in_air: bool = false
#var is_on_floor: bool = true
