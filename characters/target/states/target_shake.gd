extends State
class_name TargetShake

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func enter() -> void:
	animation_player.play('shake')

