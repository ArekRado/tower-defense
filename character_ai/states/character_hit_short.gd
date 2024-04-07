extends State
class_name CharacterHitShort

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var transform_container: Area2D = $"../../TransformContainer"
@onready var character: Character = $"../.."

@onready var hitbox: PackedScene = preload("res://hitbox/hitbox.tscn")

var hitboxInstance: Hitbox
var has_hitbox: bool = false

func enter() -> void:
	var animation: float = randi_range(0,1)
	
	if animation == 0:
		animated_sprite.play('hit_short_1')
	else:
		animated_sprite.play('hit_short_2')

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('idle')
	elif animated_sprite.frame == 1 && hitboxInstance == null:
		hitboxInstance = hitbox.instantiate()
		transform_container.add_child(hitboxInstance)
		hitboxInstance.lifetime = 0.2
		hitboxInstance.collision_shape_2d.scale = Vector2(0.1, 0.1)
		hitboxInstance.collision_shape_2d.position = Vector2( 7 if character.velocity.x > 0 else -7, -15)
		hitboxInstance.power = Vector2(0 if character.velocity.x > 0 else -0, -1)
