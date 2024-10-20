extends State
class_name CharacterHitShort

@onready var character: Character = $'../..'
@onready var animation_player: AnimationPlayer = $'../../AnimationPlayer'
@onready var hitbox: PackedScene = load('res://hitbox/hitbox.tscn')

var gravity: int = ProjectSettings.get_setting('physics/3d/default_gravity')

var hitboxInstance: Hitbox
var has_hitbox: bool = false

func enter() -> void:
	print('git short')
	character.velocity = Vector3.ZERO
	animation_player.play('hit_short')

func exit() -> void:
	print('adios')

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
