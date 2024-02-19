extends Area2D

@export var speed: float = 200.0
@export var jump_speed: float = -3.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shadow_sprite: Sprite2D = $Shadow
@onready var shadow_raycast: RayCast2D = $ShadowRaycast2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var player_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked: bool = false
var direction: Vector2 = Vector2.ZERO
var jump_velocity: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var was_in_air: bool = false
var is_on_floor: bool = true
var shadow_shift_y: float = 0.0

func _process(delta: float) -> void:
	if shadow_raycast.is_colliding:
		shadow_sprite.position = to_local(shadow_raycast.get_collision_point())
		shadow_sprite.position.y += shadow_shift_y

func _physics_process(delta: float) -> void:
	if is_on_floor == false:
		jump_velocity += (player_gravity * delta) / Engine.physics_ticks_per_second
		was_in_air = true
	elif was_in_air == true:
		land()
		was_in_air = false

	if Input.is_action_just_pressed("jump") && is_on_floor == true:
		jump_start()

	direction = Input.get_vector("left", "right", "up", "down")
	if direction.length() != 0:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
		
	if is_on_floor == false && global_position.y >  shadow_sprite.global_position.y:
		global_position.y =  shadow_sprite.global_position.y
		jump_velocity = 0.0
		is_on_floor = true
		
	jump()
	move()
	
	#update_animation()
	update_facing_direction()
	
#func _input(event: InputEvent) -> void:
	#if animated_sprite.animation == 'run':
		#shadow_sprite.position = position
	#elif animated_sprite.animation == 'jump_start' || animated_sprite.animation == 'jump_end':
		#shadow_sprite.position.x = position.x
		
func move() -> void:
	position += velocity / Engine.physics_ticks_per_second
	shadow_shift_y += velocity.y / Engine.physics_ticks_per_second
	shadow_sprite.position.x = position.x
	
#func _on_body_entered(body:Node) -> void:
	#if body.name == 'Ground':
		#is_on_floor = true
		#velocity = Vector2.ZERO
		
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
		
func jump_start() -> void:
	is_on_floor = false
	jump_velocity = jump_speed
	shadow_sprite.position.y = position.y
	animated_sprite.play('jump_start')
	animation_locked = true
	
func jump() -> void:
	position.y += jump_velocity
	
func land() -> void:
	animated_sprite.play('jump_end')
	animation_locked = true

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == 'jump_end':
		animation_locked = false
