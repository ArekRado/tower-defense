extends Control
class_name CityPreview

var selected_city_name: String

@onready var city_name_label: Label = $"./CityNameLabel"
@onready var city_size_label: Label = $"./Size"
@onready var recruit_button: Button = $"./RecruitButton"
@onready var recruit_scene: PackedScene = preload ("res://characters/recruit/recruit.tscn")

func set_details(city_name: String) -> void:
	selected_city_name = city_name
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	if (city is City):
		city_name_label.text = city.city_name
		city_size_label.text = str(city.size)

func _on_recruit_button_button_up() -> void:
	var recruit: Node3D = recruit_scene.instantiate()

	get_tree().get_root().get_node('./Game/Units').add_child(recruit)
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	recruit.global_position = city.global_position + Vector3(0, 0, 0)

	set_details(selected_city_name)

func _on_upgrade_button_button_up() -> void:
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	if (city is City):
		city.upgrade_city_size(city.size, city.size + 1)
		set_details(selected_city_name)
