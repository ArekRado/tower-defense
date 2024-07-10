extends State
class_name CharacterHitShort

@onready var character: Character = $'../..'
@onready var animation_player: AnimationPlayer = $'../../AnimationPlayer'
@onready var hitbox: PackedScene = preload ('res://hitbox/hitbox.tscn')

var gravity: int = ProjectSettings.get_setting('physics/3d/default_gravity')

var hitboxInstance: Hitbox
var has_hitbox: bool = false
var tween: Tween

func enter() -> void:
	var shift_x: float = 0.05 if character.direction else - 0.05
	tween = create_tween()
	tween.tween_property(character, 'position', character.position + Vector3(shift_x, 0, 0), 0.2).set_delay(0.2)
	animation_player.play('hit_short')

func exit() -> void:
	tween.kill()

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()
