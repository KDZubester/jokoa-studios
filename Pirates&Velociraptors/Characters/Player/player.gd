extends CharacterBody2D

class_name Player
################################################################################
## Player Script
## Manages the basic movement of the player. Does not include jumping or anything
## outside of moving left, right, up, or down (including gravity)
################################################################################

################################################################################
## Export Variables
################################################################################

# The player's base walking speed
@export var player_speed = 300.0
# The player's base jumping speed
@export var jump_velocity = -400.0
# The speed the player slides down a wall they're holding onto
@export var wall_slide_velocity = 10
# Pointer to the state machine managing the players actions
@export var state_machine : CharacterStateMachine
# Pointer to the player's sprite
@export var character_sprite : Sprite2D
# Pointer to the gun area2D
@export var gun : Area2D
# Pointer to the gun's sprite2D
@export var gun_sprite : Sprite2D
# Players grapple area2D
@export var grapple_area : Area2D
# Grapple Area's Collision Polygon2D
@export var grapple_area_collision_polygon : CollisionPolygon2D
# Pointer to know if aiming or not
@export var ground_state : State

################################################################################
## On-Read Variables
################################################################################

#@onready var rotating_gun : CollisionShape2D = $RotatingGun/RotatingGunPerimeter
#@onready var gun_sprite : Sprite2D = $RotatingGun/RotatingGunPerimeter/RotatingGunBody/GunSprite

################################################################################
## Local Variables
################################################################################

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# Used while managing the physics and speed of player
var direction : Vector2
var facing_right : bool = true
# Variable to keep track if has jumped
var has_jumped : bool = false
# Keep track of closest enemy in x direction
var closest_enemy_horizontal : CharacterBody2D
# Keep track of closest enemy in y direction
var closest_enemy_vertical : CharacterBody2D
# Enemy to grapple when in grapple area
var enemy_to_grapple : CharacterBody2D = null
# Keeps track of how many enemies can be seen by player
var enemies_in_grapple_area : int = 0
var horizontal_distance_to_player : float = 1000.0
var vertical_distance_to_player : float = 0.0
var temp_horizontal_distance : float = 0
var temp_vertical_distance : float = 0.0

################################################################################
## Functions
################################################################################

# Manages the basic movement of player, including gravity
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():# and state_machine.check_if_can_move():
		velocity.y += gravity * delta

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
	
	update_facing_direction()
	update_grapple()
	update_wall_slide()
	
func _input(event):
	# Handle jump.
	if event.is_action_pressed("jump"):
		if not has_jumped:
			jump()
	if event.is_action_released("jump"):
		has_jumped = false
			
func update_wall_slide():
	if state_machine != null:
		if state_machine.current_state is WallState:
			if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
				velocity.y = min(velocity.y, wall_slide_velocity)
				
				
# Sets the character's Y velocity and travels to the AirState
func jump():
	velocity.y = jump_velocity
	has_jumped = true

func update_facing_direction():
	#emit_signal("facing_direction_changed", not sprite.flip_h)
	if not Input.is_action_pressed("aim"):
		flip_player()
	else:
		if enemy_to_grapple:
			var distance_to_target = global_position.x - enemy_to_grapple.global_position.x
			if distance_to_target < 0:
				facing_right = false
				character_sprite.flip_h = true
				grapple_area_collision_polygon.rotation = 0
			else:
				facing_right = true
				character_sprite.flip_h = false
				grapple_area_collision_polygon.rotation = PI

func flip_player():
	if direction.x > 0:
		facing_right = true
		character_sprite.flip_h = false
		grapple_area_collision_polygon.rotation = 0
		if not (state_machine.current_state is AimState):
			gun.rotation = 0
			gun_sprite.flip_v = false
	elif direction.x < 0:
		facing_right = false
		character_sprite.flip_h = true
		grapple_area_collision_polygon.rotation = PI
		if not (state_machine.current_state is AimState):
			gun.rotation = PI
			gun_sprite.flip_v = true

#func update_gun():
	#rotating_gun.look_at(get_global_mouse_position())
	#var theta = abs(fmod(rotating_gun.rotation, 2*PI))
	#if (theta < PI/2 and theta > 0) or (theta < 2*PI and theta > 3*PI/2):
		#gun_sprite.flip_v = false
	#else:
		#gun_sprite.flip_v = true
	

func _on_grapple_body_entered(body):
	# Set indicator onto new body
	if (body is CharacterBody2D) and not (body is Player):
		enemies_in_grapple_area += 1
		#distance_to_player = abs(body.global_position - global_position)
		#enemy_vertical_position = absf(body.global_position.y)
		#temp_distance = 0
		#temp_vertical_position = 0

func update_grapple():
	check_grapple_area()
	
	pick_enemy_to_grapple()
	
	check_to_reset_grapple_values()
	
func check_grapple_area():
	enemy_to_grapple = null
	horizontal_distance_to_player = 1000.0
	vertical_distance_to_player = 0.0
	
	for enemy in grapple_area.get_overlapping_bodies():
		if not (enemy is Player) and enemy is CharacterBody2D:
			temp_horizontal_distance = absf(enemy.global_position.x - global_position.x)
			temp_vertical_distance = absf(enemy.global_position.y - global_position.y)
			if temp_horizontal_distance <= horizontal_distance_to_player:
				closest_enemy_horizontal = enemy
				horizontal_distance_to_player = temp_horizontal_distance
			elif temp_vertical_distance >= vertical_distance_to_player:
				closest_enemy_vertical = enemy
				vertical_distance_to_player = temp_vertical_distance

func pick_enemy_to_grapple():
	if closest_enemy_horizontal or closest_enemy_vertical:
		if closest_enemy_horizontal and not closest_enemy_vertical:
			enemy_to_grapple = closest_enemy_horizontal
		elif not closest_enemy_horizontal and closest_enemy_vertical:
			enemy_to_grapple = closest_enemy_vertical
		else:
			var player_to_horizontal_enemy_distance = absf(closest_enemy_horizontal.global_position.x - global_position.x)
			var player_to_vertical_enemy_distance = absf(closest_enemy_vertical.global_position.x - global_position.x)
			if player_to_horizontal_enemy_distance < player_to_vertical_enemy_distance:
				enemy_to_grapple = closest_enemy_horizontal
			else:
				enemy_to_grapple = closest_enemy_vertical

func check_to_reset_grapple_values():
	if enemies_in_grapple_area <= 0:
		reset_grapple_values()

func _on_grapple_body_exited(body):
	if (body is CharacterBody2D) and not (body is Player):
		enemies_in_grapple_area -= 1
		reset_grapple_values()
		
func reset_grapple_values():
	enemy_to_grapple = null
	closest_enemy_horizontal = null
	closest_enemy_vertical = null
	horizontal_distance_to_player = 1000.0
	vertical_distance_to_player = 0.0
	temp_horizontal_distance = 0.0
	temp_vertical_distance = 0
