extends Node3D
class_name House

@onready var porter: PackedScene = load("res://characters/recruit/recruit.tscn")
@onready var structure: Structure = $".."
@onready var baracks_scene: PackedScene = load("res://cities/baracks/baracks.tscn")

var assigned_character_name: String

func _ready() -> void:
	if assigned_character_name:
		return
	create_new_character()

func create_new_character() -> void:
	var character: Character = porter.instantiate()

	character.player = structure.player

	character.assigned_city_name = structure.city.name
	character.assigned_structure_name = name
	assigned_character_name = character.name

	var city: City = Paths.get_city(get_tree(), structure.city.name)
	city.assign_character(character.name)

	Paths.get_characters(get_tree()).add_child(character)
	character.global_position = global_position + Vector3(0, 0.1, 0)
