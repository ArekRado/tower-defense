extends State
class_name CharacterHitShort

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var transform_container: Area2D = $"../../TransformContainer"
@onready var character: Character = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var hitbox: PackedScene = preload("res://hitbox/hitbox.tscn")

var hitboxInstance: Hitbox
var has_hitbox: bool = false

func enter() -> void:
	animation_player.play('hit_short')
