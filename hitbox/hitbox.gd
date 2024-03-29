extends Area2D
class_name Hitbox

@export var lifetime: float = 0.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitEffect: PackedScene = preload("res://hitEffect/hitEffect.tscn")

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime < 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	var state_machine: StateMachine = area.get_parent().find_child('StateMachine')
	
	if state_machine:
		state_machine.on_child_transition('shake')
	
	var hitEffectInstance: AnimatedSprite2D = hitEffect.instantiate()
	self.add_child(hitEffectInstance)
	hitEffectInstance.position = collision_shape_2d.position
