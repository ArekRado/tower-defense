extends State
class_name HitShort

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var player: Player = $"../.."

func enter() -> void:
	var animation:float = randi_range(0,1)
	
	if animation == 0:
		animated_sprite.play('hit_short_1')
	else:
		animated_sprite.play('hit_short_2')
	
func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit(self, 'idle')
