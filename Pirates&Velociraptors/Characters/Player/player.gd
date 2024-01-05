extends CharacterBody2D

class_name Player

@export var player_speed = 300.0
@export var jump_velocity = -400.0
@export var state_machine : CharacterStateMachine

#@onready var rotating_gun : CollisionShape2D = $RotatingGun/RotatingGunPerimeter
#@onready var gun_sprite : Sprite2D = $RotatingGun/RotatingGunPerimeter/RotatingGunBody/GunSprite

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():# and state_machine.check_if_can_move():
		velocity.y += gravity * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x and state_machine.check_if_can_move():
		velocity.x = direction.x * player_speed
	else:
		velocity.x = move_toward(velocity.x, 0, player_speed)
	
	#update_gun()
	move_and_slide()
	
#func update_gun():
	#rotating_gun.look_at(get_global_mouse_position())
	#var theta = abs(fmod(rotating_gun.rotation, 2*PI))
	#if (theta < PI/2 and theta > 0) or (theta < 2*PI and theta > 3*PI/2):
		#gun_sprite.flip_v = false
	#else:
		#gun_sprite.flip_v = true
	
