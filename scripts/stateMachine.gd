extends Node
class_name StateMachine

@export var initial_state: State

var current_state: State
var current_state_name: String = 'idle'
var previous_state_name: String
var states: Dictionary = {}

func _ready() -> void:
	var children: Array[Node] = get_children()
	for child in children:
		states[child.name.to_lower()] = child
		@warning_ignore("unsafe_method_access")
		@warning_ignore("unsafe_property_access")
		child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		
func on_child_transition(new_state_name: String) -> void:
	var normalized_state_name: String = new_state_name.to_lower()

	if normalized_state_name == current_state_name:
		return

	var new_state: State = states.get(normalized_state_name)

	if !new_state:
		push_warning("State with the name " + new_state_name.to_lower() + " doesnt exist")
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	previous_state_name = current_state_name
	current_state_name = new_state_name
	current_state = new_state
