extends Node
class_name Structure

@export var city_name: String = ''

var assigned_characters: Array[Character] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.

func assign_character(character: Character) -> void:
	assigned_characters.push_back(character)

func unassign_character(character: Character) -> void:
	assigned_characters = assigned_characters.filter(func(c: Character) -> bool:
		return character.get_instance_id() != c.get_instance_id()
	)

func _on_static_body_3d_body_entered(body: Node3D) -> void:
	var city_preview: Node = get_tree().get_root().get_node('./Game/UI/CityPreview') # .find_child('CityPreview')
	if (city_preview is Control):
		@warning_ignore("unsafe_method_access")
		city_preview.show()

func _on_static_body_3d_body_exited(body: Node3D) -> void:
	var city_preview: Node = get_tree().get_root().get_node('./Game/UI/CityPreview') # .find_child('CityPreview')
	if (city_preview is Control):
		@warning_ignore("unsafe_method_access")
		city_preview.hide()
