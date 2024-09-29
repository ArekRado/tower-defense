extends Node3D
class_name Structure

@export var structure_name: String
@export var player: Player
@export var city: City

@onready var health: Health = $Health

var assigned_characters_names: Array[String] = []

func assign_character(character_name: String) -> void:
	assigned_characters_names.push_back(character_name)

func unassign_character(character_name: String) -> void:
	assigned_characters_names = assigned_characters_names.filter(func(cn: String) -> bool:
		return character_name != cn
	)
