extends State
class_name CharacterHitShort

@onready var character: Character = $"../.."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

@onready var hitbox: PackedScene = preload ("res://hitbox/hitbox.tscn")

var hitboxInstance: Hitbox
var has_hitbox: bool = false

func enter() -> void:
	animation_player.play('hit_short')

func physics_update(_delta: float) -> void:
	character.move_and_slide()

func update(_delta: float) -> void:
	character.update_facing_direction()
