extends Node3D
class_name City

@export var city_name: String = ''
@export var size: int = 1

@onready var house_scene: PackedScene = preload ("res://cities/house/house.tscn")

var max_size: float = 5
var assigned_characters: Array[Character] = []
var amount_of_houses_per_size: Array[int] = [1, 3, 5, 8, 13]

func _ready() -> void:
	upgrade_city_size(0, size)

func upgrade_city_size(from: int, to: int) -> void:
	var diff: int = to - from

	if to > max_size:
		return

	for i in diff:
		var amount_of_houses: int = amount_of_houses_per_size[i + from]
		for j in amount_of_houses:
			var house: Node3D = house_scene.instantiate()

			Paths.get_structures(get_tree()).add_child(house)
			var shift: Vector3 = Vector3(max_size / 2, 0, max_size / 8)
			var random_shift: Vector3 = Vector3((randf() * shift.x) - shift.x / 2, 0, (randf() * shift.z) - shift.z / 2, )
			house.global_position = global_position + random_shift

	size = to

func assign_character(character: Character) -> void:
	assigned_characters.push_back(character)

func unassign_character(character: Character) -> void:
	assigned_characters = assigned_characters.filter(func(c: Character) -> bool:
		return character.get_instance_id() != c.get_instance_id()
	)

func _on_static_body_3d_body_entered(_body: Node3D) -> void:
	var city_preview: CityPreview = Paths.get_ui_city_preview(get_tree())
	if (city_preview is CityPreview):
		@warning_ignore("unsafe_method_access")
		city_preview.show()
		@warning_ignore("unsafe_method_access")
		city_preview.set_details(name)

func _on_static_body_3d_body_exited(_body: Node3D) -> void:
	var city_preview: CityPreview = Paths.get_ui_city_preview(get_tree())
	if (city_preview is CityPreview):
		@warning_ignore("unsafe_method_access")
		city_preview.hide()
