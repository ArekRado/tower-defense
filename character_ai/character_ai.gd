extends Node
class_name CharacterAI

@onready var state_machine: StateMachine = $"../StateMachine"

func _ready() -> void:
	state_machine.on_child_transition('walk')


#func _process(delta: float) -> void:
	#pass
