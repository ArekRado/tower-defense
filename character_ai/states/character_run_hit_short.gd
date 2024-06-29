extends State
class_name CharacterRunHitShort

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var character: Character = $"../.."

func enter() -> void:
	animation_player.play('run_hit_short')

func physics_update(_delta: float) -> void:
	character.move_and_slide()

func update(_delta: float) -> void:
	character.update_facing_direction()