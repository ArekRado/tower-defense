extends Sprite3D
class_name PlayerMarker

func set_color(player_color: String) -> void:
	match player_color:
		'gray':
			texture = load("res://player_marker/player_marker_gray.png")
		'blue':
			texture = load("res://player_marker/player_marker_blue.png")
		'green':
			texture = load("res://player_marker/player_marker_green.png")
		'red':
			texture = load("res://player_marker/player_marker_red.png")
		'yellow':
			texture = load("res://player_marker/player_marker_yellow.png")
		_:
			push_warning("Invalid marker color: " + player_color)
