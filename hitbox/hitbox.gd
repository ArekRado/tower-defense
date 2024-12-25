extends Area3D
class_name Hitbox

@export var damage: float = 1
@export var power: Vector3 = Vector3.ZERO
@export var collider_dimensions: Vector3 = Vector3.ONE

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var hitEffect: PackedScene = preload("res://hitEffect/hitEffect.tscn")

func _ready() -> void:
	collision_shape_3d.scale = collider_dimensions

func on_collision(collide: Character) -> void:
	var state_machine: StateMachine = collide.find_child('StateMachine')
	if state_machine && collide:
		collide.on_hit(damage, power)
	
	var hitEffectInstance: AnimatedSprite3D = hitEffect.instantiate()
	self.add_child(hitEffectInstance)
	# hitEffectInstance.position = collide.position + collision_shape_3d.position
	hitEffectInstance.global_position = collide.global_position

func _on_area_entered(collide: Character) -> void:
	if collide is Character && get_parent().get_parent() != collide:
		on_collision(collide)

func _on_body_entered(collide: Character) -> void:
	if collide is Character && get_parent().get_parent() != collide:
		on_collision(collide)

func adjust_position_to_character_direction(character: Character) -> void:
	if (character.direction == 'left' && position.x > 0) || (character.direction == 'right' && position.x < 0):
		position.x *= -1
