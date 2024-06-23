extends Area2D
class_name Hitbox

@export var lifetime: float = 0.0
@export var damage: float = 1
@export var power: Vector3 = Vector3.ZERO

@onready var collision_shape_2d: CollisionShape3D = $CollisionShape2D
@onready var hitEffect: PackedScene = preload ("res://hitEffect/hitEffect.tscn")

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime < 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	var character: Character = area.get_parent()
	var state_machine: StateMachine = area.get_parent().find_child('StateMachine')
	
	if state_machine&&character:
		character.on_hit(damage, power)
	
	var hitEffectInstance: AnimatedSprite3D = hitEffect.instantiate()
	self.add_child(hitEffectInstance)
	hitEffectInstance.position = collision_shape_2d.position
