extends Node3D
class_name City

@export var city_name: String = ''
@export var size: int = 1
@export var player: Player

@onready var player_marker: PlayerMarker = $PlayerMarker
@onready var house_scene: PackedScene = preload("res://cities/house/house.tscn")
@onready var lumberjack_hut_scene: PackedScene = preload("res://cities/lumberjack_hut/lumberjack_hut.tscn")

var max_size: float = 5
var assigned_characters_names: Array[String] = []
var assigned_structures_names: Array[String] = []
var amount_of_houses_per_size: Array[int] = [1, 3, 5, 8, 13]

func _ready() -> void:
	upgrade_city_size(0, size)
	player_marker.set_color(player.color)

func upgrade_city_size(from: int, to: int) -> void:
	var diff: int = to - from

	if to > max_size:
		return

	for i in diff:
		var amount_of_houses: int = amount_of_houses_per_size[i + from]
		for j in amount_of_houses:
			var house: House = house_scene.instantiate()

			var shift: Vector3 = Vector3(max_size / 2, 0, max_size / 8)
			var random_shift: Vector3 = Vector3((randf() * shift.x) - shift.x / 2, 0, (randf() * shift.z) - shift.z / 2)
			house.global_position = global_position + random_shift
			house.player = player
			house.city_name = name
			assign_structure(house.name)
			Paths.get_structures(get_tree()).add_child(house)

	size = to

func build_lumberjack_hut() -> void:
	var lumberjack_hut: Node3D = lumberjack_hut_scene.instantiate()

	Paths.get_structures(get_tree()).add_child(lumberjack_hut)
	var shift: Vector3 = Vector3(max_size / 2, 0, max_size / 8)
	var random_shift: Vector3 = Vector3((randf() * shift.x) - shift.x / 2, 0, (randf() * shift.z) - shift.z / 2)
	lumberjack_hut.global_position = global_position + random_shift
	assign_structure(lumberjack_hut.name)

func assign_character(character_name: String) -> void:
	assigned_characters_names.push_back(character_name)

func unassign_character(character_name: String) -> void:
	assigned_characters_names = assigned_characters_names.filter(func(cn: String) -> bool:
		return character_name != cn
	)

func assign_structure(structure_name: String) -> void:
	assigned_structures_names.push_back(structure_name)

func unassign_structure(structure_name: String) -> void:
	assigned_structures_names = assigned_structures_names.filter(func(sn: String) -> bool:
		return structure_name != sn
	)

func _on_static_body_3d_body_entered(_body: Node3D) -> void:
	var city_preview: CityPreview = Paths.get_ui_city_preview(get_tree())
	if (city_preview is CityPreview):
		city_preview.set_details(true, name)

func _on_static_body_3d_body_exited(_body: Node3D) -> void:
	var city_preview: CityPreview = Paths.get_ui_city_preview(get_tree())
	if (city_preview is CityPreview):
		city_preview.hide()
