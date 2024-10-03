extends Area3D
class_name Hitbox

@export var lifetime: float = 0.0
@export var damage: float = 1
@export var power: Vector3 = Vector3.ZERO

@onready var collision_shape_3d: CollisionShape3D = $CollisionShape3D
@onready var hitEffect: PackedScene = preload("res://hitEffect/hitEffect.tscn")

func _process(delta: float) -> void:
	lifetime -= delta
	
	if lifetime < 0:
		queue_free()

func on_collision(character: Character) -> void:
	var state_machine: StateMachine = character.find_child('StateMachine')
	
	print(
		"_on_area_entered ",
		character,
		state_machine
	)

	if state_machine && character:
		character.on_hit(damage, power)
	
	var hitEffectInstance: AnimatedSprite3D = hitEffect.instantiate()
	self.add_child(hitEffectInstance)
	hitEffectInstance.position = collision_shape_3d.position

func _on_area_entered(collide: Character) -> void:
	if collide is Character:
		on_collision(collide)

func _on_body_entered(collide: Character) -> void:
	if collide is Character:
		on_collision(collide)


# func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
# 	print("_on_body_shape_entered")
