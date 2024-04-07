extends State
class_name CharacterJumpHitShort

@onready var animated_sprite: AnimatedSprite2D = $"../../TransformContainer/AnimatedSprite2D"
@onready var character: Character = $"../.."
@onready var shadow: Shadow = $"../../Shadow"
@onready var transform_container: Area2D = $"../../TransformContainer"

@onready var hitbox: PackedScene = preload("res://hitbox/hitbox.tscn")

var hitboxInstance: Hitbox
var has_hitbox: bool = false

func enter() -> void:
	var animation: float = randi_range(0,1)
	
	if animation == 0:
		animated_sprite.play('jump_hit_short_1')
	else:
		animated_sprite.play('jump_hit_short_2')
		
func get_hitbox_position() -> Vector2:
	var shift_x: float = 7 if character.velocity.x > 0 else -7
	return Vector2(shift_x, -15)

func update(_delta: float) -> void:
	if animated_sprite.is_playing() == false:
		Transitioned.emit('jump')
	elif animated_sprite.frame == 1 && hitboxInstance == null:
		hitboxInstance = hitbox.instantiate()
		transform_container.add_child(hitboxInstance)
		hitboxInstance.lifetime = 0.2
		hitboxInstance.collision_shape_2d.scale = Vector2(0.1, 0.1)
		hitboxInstance.collision_shape_2d.position = get_hitbox_position()

func physics_update(delta: float) -> void:
	var will_touch_shadow: bool = transform_container.global_position.y > shadow.shadow_sprite.global_position.y
	
	if shadow.is_above_ground && will_touch_shadow:
		transform_container.global_position.y = shadow.shadow_sprite.global_position.y - 0.1
		character.jump_velocity = 0
		Transitioned.emit('jumpEnd')
	else:
		transform_container.global_position.y += character.jump_velocity
		character.jump_velocity += (character.character_gravity * delta) / Engine.physics_ticks_per_second
	
	if character.direction.length() != 0:
		character.move(character.jump_move_speed * delta)
	
