extends Node3D
class_name City

@export var city_name: String = ''
@export var size: int = 1
@export var player: Player

@onready var player_marker: PlayerMarker = $PlayerMarker
@onready var house_scene: PackedScene = preload("res://cities/house/house.tscn")
@onready var lumberjack_hut_scene: PackedScene = preload("res://cities/lumberjack_hut/lumberjack_hut.tscn")
@onready var baracks_scene: PackedScene = preload("res://cities/baracks/baracks.tscn")

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
			build_house()

	size = to

func build_house() -> void:
	var house: House = house_scene.instantiate()

	house.player = player
	house.city_name = name

	house.transform.origin = global_position + RandomShift.get_3(Vector3(max_size / 2, 0, max_size / 8))
	Paths.get_structures(get_tree()).add_child(house)
	assign_structure(house.name)

func build_lumberjack_hut() -> void:
	var lumberjack_hut: LumberjackHut = lumberjack_hut_scene.instantiate()

	lumberjack_hut.player = player
	lumberjack_hut.city_name = name

	lumberjack_hut.transform.origin = global_position + RandomShift.get_3(Vector3(max_size / 2, 0, max_size / 8))
	Paths.get_structures(get_tree()).add_child(lumberjack_hut)
	assign_structure(lumberjack_hut.name)
	
func build_baracks() -> void:
	var baracks: Baracks = baracks_scene.instantiate()

	baracks.player = player
	baracks.city_name = name

	baracks.transform.origin = global_position + RandomShift.get_3(Vector3(max_size / 2, 0, max_size / 8))
	Paths.get_structures(get_tree()).add_child(baracks)
	assign_structure(baracks.name)

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
