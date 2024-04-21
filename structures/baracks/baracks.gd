extends Node
class_name Baracks

@export var unit_creation_max_time: float = 1.0
var unit_creation_time: float = 0.0

@onready var recruit: PackedScene = preload("res://characters/recruit/recruit.tscn")
var recruitInstance: Character

func _ready() -> void:
	unit_creation_time = unit_creation_max_time

func _process(delta: float) -> void:
	unit_creation_time -= delta 
	if unit_creation_time < 0:
		unit_creation_time = unit_creation_max_time
		recruitInstance = recruit.instantiate()
		get_tree().get_root().add_child(recruitInstance)
