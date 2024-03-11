extends Area2D
class_name Hitbox

@export var lifetime: float = 0.0

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitEffect: PackedScene = preload("res://hitEffect/hitEffect.tscn")

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime < 0:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	print("_on_body_entered", body)
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	var hitEffectInstance:AnimatedSprite2D = hitEffect.instantiate()
	self.add_child(hitEffectInstance)
	hitEffectInstance.position = collision_shape_2d.position
	pass # Replace with function body.
