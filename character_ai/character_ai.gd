extends Node
class_name CharacterAI

@onready var state_machine: StateMachine = $"../StateMachine"
@onready var character: Character = $"../Character"

var wait_delay: float = 0

#func _ready() -> void:
	#state_machine.on_child_transition('walk')

func _process(delta: float) -> void:
	if state_machine.current_state_name == 'idle':
		if wait_delay > 0:
			wait_delay -= delta 
			return 
		
		do_something()

func go_to_random_point() -> void:
	var shift: Vector2 = Vector2(100, 10)
	var random_shift: Vector2 = Vector2((randf() * shift.x) - shift.x/2, (randf() * shift.y) - shift.y/2)

	character.go_to_position = character.main_container.position + random_shift
	
	var random_value: float = randf()
	if random_value < 0.5:
		state_machine.on_child_transition('walk')
	else:
		state_machine.on_child_transition('run')
	
func attack() -> void:
	var targets: Array[Character] = get_target_to_attack()
	targets.shuffle()
	var target: Character = targets[0]
	
	if target == null:
		return
	
	var distance_to_target: float = (character.transform_container.global_position - target.transform_container.global_position).length()
	
	if distance_to_target <= character.short_hit_range:
		state_machine.on_child_transition('hitShort')
	else:
		character.go_to_character = target
		
		if distance_to_target > 100:
			state_machine.on_child_transition('run')
		else:
			state_machine.on_child_transition('walk')
	
	wait_delay = 0.1

func do_something() -> void:
	var random_value: float = randf()
	wait_delay = 1
	
	if random_value < 0.1:
		go_to_random_point()
	elif random_value < 0.2: 
		state_machine.on_child_transition('jump')
	elif random_value < 0.9:
		attack()
	else:
		wait_delay = randf() * 3

func get_target_to_attack() -> Array[Character]:
	var characters: Array[Node] = get_parent().get_parent().find_children('', 'Character').filter(func (node: Node) -> bool: 
		if node.get_instance_id() == character.get_instance_id():
			return false
		
		return true
	)
	
	if characters[0] is Character:
		return [characters[0]]
	
	return [null]
