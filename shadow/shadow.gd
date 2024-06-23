extends Node3D
class_name Shadow

@onready var shadow_raycast: RayCast3D = $Raycast3D
@onready var shadow_sprite: Sprite3D = $Sprite3D

var is_above_ground: bool = true
