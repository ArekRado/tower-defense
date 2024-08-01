class_name Paths

# 
# Cities
# 
static func get_cities(tree: SceneTree) -> Node3D:
	return tree.get_root().get_node('./Game/Map/Cities') as Node3D

static func get_city(tree: SceneTree, city_name: String) -> City:
	return get_cities(tree).get_node(city_name) as City
# 
# Players
# 
static func get_players(tree: SceneTree) -> Node3D:
	return tree.get_root().get_node('./Game/Map/Players') as Node3D

static func get_player(tree: SceneTree, player_name: String) -> Player:
	return get_players(tree).get_node(player_name) as Player
	
# 
# Structures
# 
static func get_structures(tree: SceneTree) -> Node3D:
	return tree.get_root().get_node('./Game/Map/Structures') as Node3D

static func get_structure(tree: SceneTree, structure_name: String) -> City:
	return get_structures(tree).get_node(structure_name) as City

# 
# Character
# 
static func get_characters(tree: SceneTree) -> Node3D:
	return tree.get_root().get_node('./Game/Map/Characters') as Node3D

static func get_character(tree: SceneTree, character_name: String) -> Character:
	return get_characters(tree).get_node(character_name) as Character

static func get_character_ai(tree: SceneTree, character_name: String) -> CharacterAI:
	return get_character(tree, character_name).get_node('./CharacterAI') as CharacterAI
# 
# UI
# 
static func get_ui_city_preview(tree: SceneTree) -> CityPreview:
	return tree.get_root().get_node('./Game/UI/CityPreview') as CityPreview
