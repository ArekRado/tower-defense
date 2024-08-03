extends Control
class_name CityPreview

var selected_city_name: String

@onready var city_name_label: Label = $CityNameLabel
@onready var city_size_label: Label = $Size
@onready var recruit_button: Button = $RecruitButton
@onready var characters_list: VBoxContainer = $CharactersList
@onready var structures_list: VBoxContainer = $StructuresList
@onready var amount_of_structures_label: Label = $AmountOfStructures
@onready var amount_of_characters_label: Label = $AmountOfCharacters

@onready var recruit_scene: PackedScene = preload("res://characters/recruit/recruit.tscn")

func set_details(show_ui: bool, city_name: String) -> void:
	if show_ui:
		show()
	else:
		hide()

	selected_city_name = city_name
	var city: City = Paths.get_city(get_tree(), selected_city_name)
		
	city_name_label.text = city.city_name
	city_size_label.text = str(city.size)

	amount_of_characters_label.text = "Infinity/" + str(city.assigned_characters_names.size())
	amount_of_structures_label.text = "Infinity/" + str(city.assigned_structures_names.size())
	
	# characters_list
	for n in characters_list.get_children(): characters_list.remove_child(n)
	
	for character_name in city.assigned_characters_names:
		var label: Label = Label.new()
		label.text = character_name
		characters_list.add_child(label)
			
	# structures_list
	for n in structures_list.get_children(): structures_list.remove_child(n)
	
	for structure_name in city.assigned_structures_names:
		var label: Label = Label.new()
		label.text = structure_name
		structures_list.add_child(label)
		
func _on_recruit_button_button_up() -> void:
	var recruit: Character = recruit_scene.instantiate()
	
	Paths.get_characters(get_tree()).add_child(recruit)
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	recruit.player = city.player
	recruit.global_position = city.global_position + Vector3(0, 0.1, 0)

	var character: Character = Paths.get_character(get_tree(), recruit.name)
	character.assigned_city_name = city.name
	city.assign_character(recruit.name)

	recruit.initialize_data()
	set_details(true, selected_city_name)

func _on_upgrade_button_button_up() -> void:
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	if (city is City):
		city.upgrade_city_size(city.size, city.size + 1)
		set_details(true, selected_city_name)

func _on_build_lumberjack_hut_button_button_up() -> void:
	var city: City = Paths.get_city(get_tree(), selected_city_name)
	if (city is City):
		city.build_lumberjack_hut()
		set_details(true, selected_city_name)
