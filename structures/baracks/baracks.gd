extends Node2D
class_name Baracks

@export var character_amount_max: int = 0
@export var character_creation_max_time: float = 1.0
var character_creation_time: float = 0.0

@onready var structure: Structure = $".."
@onready var recruit: PackedScene = preload ("res://characters/recruit/recruit.tscn")
var recruitInstance: Character

func _ready() -> void:
	character_creation_time = character_creation_max_time

func _process(delta: float) -> void:
	if structure.assigned_characters.size() >= character_amount_max:
		return
		
	character_creation_time -= delta
	if character_creation_time < 0:
		character_creation_time = character_creation_max_time
		recruitInstance = recruit.instantiate()
		get_tree().get_root().add_child(recruitInstance)
		recruitInstance.global_position = global_position
		
		structure.assign_character(recruitInstance)
