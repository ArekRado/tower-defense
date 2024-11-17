extends State
class_name CharacterRunHitShort

@onready var animated_sprite: AnimatedSprite3D = $"../../AnimatedSprite3D"
@onready var character: Character = $"../.."

func enter() -> void:
	character.velocity = Vector3.ZERO
	animated_sprite.play('run_hit_short')
	await Wait.seconds(get_tree(), 0.3)
	Transitioned.emit('idle')


func physics_update(_delta: float) -> void:
	character.move_and_slide()

func update(_delta: float) -> void:
	character.update_facing_direction()
