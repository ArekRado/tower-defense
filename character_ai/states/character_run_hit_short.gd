extends State
class_name CharacterRunHitShort

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character
@onready var hitbox_run_hit_short: Hitbox = $"../../Hitbox/RunHitShort"

func enter() -> void:
	hitbox_run_hit_short.collision_shape_3d.disabled = false;
	hitbox_run_hit_short.adjust_position_to_character_direction(character)

	character.velocity = Vector3.ZERO
	animated_sprite.play('run_hit_short')
	await Wait.seconds(get_tree(), 0.3)
	Transitioned.emit('idle')

func exit() -> void:
	hitbox_run_hit_short.collision_shape_3d.disabled = true;

func physics_update(_delta: float) -> void:
	character.move_and_slide()

func update(_delta: float) -> void:
	character.update_facing_direction()
