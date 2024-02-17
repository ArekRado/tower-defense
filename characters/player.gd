extends Area2D

@export var speed: float = 200.0
@export var jump_velocity: float = -150.0
@export var double_jump_velocity: float = -100.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shadow_sprite: Sprite2D = $Shadow

# Get the gravity from the project settings to be synced with RigidBody nodes.
var player_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var shadow_position_y: float = 0.0
var has_double_jump: bool = false
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var was_in_air: bool = false
var is_on_floor: bool = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if is_on_floor == false:
		player_gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
		velocity.y += player_gravity * delta
		was_in_air= true
	else: 
		has_double_jump = false
		
		if was_in_air == true:
			land()
			
		was_in_air = false

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor == true:
			jump()
		elif not has_double_jump:
			velocity.y = double_jump_velocity
			has_double_jump = true

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if position.y <= shadow_position_y:
		velocity.y = 0
		is_on_floor = true
		
	move()
	
	#update_animation()
	update_facing_direction()
	
func _input(event: InputEvent) -> void:
	if animated_sprite.animation == 'run':
		shadow_sprite.position = position
	elif animated_sprite.animation == 'jump_start' || animated_sprite.animation == 'jump_end':
		shadow_sprite.position.x = position.x
		
func move() -> void:
	position += velocity / Engine.physics_ticks_per_second
	
func _on_body_entered(body:Node) -> void:
	print("_on_body_entered", body.name)
		
func update_animation() -> void:
	if not animation_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else: 
			animated_sprite.play("idle")
	
func update_facing_direction() -> void:
	if direction.x > 0:
		animated_sprite.flip_h = false
	elif direction.x < 0:
		animated_sprite.flip_h = true
		
func jump() -> void:
	is_on_floor = false
	velocity.y = jump_velocity
	shadow_position_y = position.y
	animated_sprite.play('jump_start')
	animation_locked = true
	
func land() -> void:
	animated_sprite.play('jump_end')
	animation_locked = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'jump_end':
		animation_locked = false
