extends Node
class_name Structure

var assigned_characters: Array[Character] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func assign_character(character:Character) -> void:
	assigned_characters.push_back(character)

func unassign_character(character:Character) -> void:
	assigned_characters = assigned_characters.filter(func (c:Character) -> bool: 
		return character.get_instance_id() != c.get_instance_id()
	)
