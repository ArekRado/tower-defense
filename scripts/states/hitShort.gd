extends State
class_name HitShort

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var player: Player = $"../.."

@onready var hitbox: PackedScene = preload("res://hitbox/hitbox.tscn")

var hitboxInstance: Hitbox

func enter() -> void:
	var animation: float = randi_range(0,1)
	
	if animation == 0:
		animated_sprite.play('hit_short_1')
	else:
		animated_sprite.play('hit_short_2')

func update(_delta: float) -> void:
	print(hitboxInstance)
	
	if animated_sprite.is_playing() == false:
		Transitioned.emit(self, 'idle')
	elif animated_sprite.frame == 1:
		hitboxInstance = hitbox.instantiate()
		owner.add_child(hitboxInstance)
		hitboxInstance.lifetime = 0.2
