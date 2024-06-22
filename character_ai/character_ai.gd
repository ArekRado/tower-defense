extends Node
class_name CharacterAI

@onready var state_machine: StateMachine = $"../StateMachine"
@onready var character: Character = $".."

var wait_delay: float = 0

func _process(delta: float) -> void:
	if state_machine.current_state_name == 'idle':
		if wait_delay > 0:
			wait_delay -= delta
			return
		
		do_something()

func go_to_random_point() -> void:
	var shift: Vector3 = Vector3(100, 10, 0)
	var random_shift: Vector3 = Vector3((randf() * shift.x) - shift.x / 2, (randf() * shift.y) - shift.y / 2, 0)

	character.go_to_position = character.position + random_shift
	
	var random_value: float = randf()
	if random_value < 0.5:
		state_machine.on_child_transition('walk')
	else:
		state_machine.on_child_transition('run')
	
func attack() -> void:
	var target: Character = get_target_to_attack()
	
	if target == null:
		return
	
	var distance_to_target: float = (character.transform_container.global_position - target.transform_container.global_position).length()
	
	if distance_to_target <= character.hit_short_range:
		state_machine.on_child_transition('hitShort')
	else:
		character.go_to_character = target
		
		if distance_to_target > 100:
			state_machine.on_child_transition('run')
		else:
			state_machine.on_child_transition('walk')
	
	wait_delay = 0.1

func do_something() -> void:
	#var random_value: float = randf()
	wait_delay = 1
	return
	
	#if character.walk_speed.length() == 0:
		#wait_delay = 10
		#return
	#
	#if random_value < 0.1:
		#go_to_random_point()
	#elif random_value < 0.2: 
		#state_machine.on_child_transition('jump')
	#elif random_value < 0.9:
		#attack()
	#else:
		#wait_delay = randf() * 3

func get_target_to_attack() -> Character:
	var characters: Array[Node] = get_parent().get_parent().find_children('', 'Character').filter(func(node: Node) -> bool:
		if node.get_instance_id() == character.get_instance_id():
			return false
			
		return true
	)
	
	if characters.size() == 0:
		return null
	
	characters.shuffle()
	
	return characters[0]
