extends State
class_name CharacterRunHitShort

@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

func enter() -> void:
	animation_player.play('run_hit_short')
