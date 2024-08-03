extends StaticBody3D
class_name House

@export var character_to_spawn: PackedScene = preload("res://characters/recruit/recruit.tscn")

var assigned_character_name: String
var player: Player
var city_name: String

func _ready() -> void:
	if assigned_character_name:
		return

	create_new_character()

func create_new_character() -> void:
	var character: Character = character_to_spawn.instantiate()
	character.player = player
	character.global_position = global_position + Vector3(0, 0.1, 0)

	character.assigned_city_name = city_name
	character.assigned_structure_name = name
	assigned_character_name = character.name

	var city: City = Paths.get_city(get_tree(), city_name)
	city.assign_character(character.name)

	Paths.get_characters(get_tree()).add_child(character)
