extends State
class_name CharacterHitShort

@onready var character: Character = $'../..'
@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var hitbox: Hitbox = $"../../Hitbox"

var gravity: int = ProjectSettings.get_setting('physics/3d/default_gravity')

func enter() -> void:
	character.velocity = Vector3.ZERO
	hitbox.collision_shape_3d.disabled = false

	if randi_range(0, 1) == 0:
		animated_sprite.play('hit_short_1')
	else:
		animated_sprite.play('hit_short_2')

func exit() -> void:
	hitbox.collision_shape_3d.disabled = true

func physics_update(delta: float) -> void:
	character.move_and_slide()

	if character.is_on_floor() == false:
		character.velocity.y -= gravity * delta

func update(_delta: float) -> void:
	character.update_facing_direction()

	if animated_sprite.is_playing() == false:
		character.velocity = Vector3.ZERO
		Transitioned.emit('idle')
