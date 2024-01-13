extends State

class_name AirState
################################################################################
## AirState Script
##
## The Air State can travel to: the GroundState and WallState
## The script manages the directions in which the Player can gun jump/dash and
## it manages the amount of times the player can gun jump/dash
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the ground state
@export var ground_state : State
#Pointer to the wall state
@export var wall_state : State
#@export var landing_state : State
# Pointer to the debug label to debug user input
@export var debug_label : Label

# The play'ers base jumping speed
@export var jump_velocity = -400.0
# User editable variables to fine-tune the jumping movement
@export var gun_jump_velocity : Vector2 = Vector2(0,-2000.0)
@export var gun_dash_right_velocity : Vector2 = Vector2(2500.0,0)
@export var gun_dash_left_velocity : Vector2 = Vector2(-2500.0,0)
@export var gun_dash_diag_left_velocity : Vector2 = Vector2(-1500.0,-500.0)
@export var gun_dash_diag_right_velocity : Vector2 = Vector2(1500.0,-500.0)
@export var gun_dash_jump_duration : float = 0.1

# Maximum number of shots/jumps the player can make
@export var max_number_of_shots : int = 1

################################################################################
## On-Ready Variables
################################################################################

# The duration of the jump/dash
@onready var dash_jump_duration_timer : Timer = $Dash

################################################################################
## Local Variables
################################################################################

# Variables to manage how many times the gun has been shot
var has_gun_jumped_or_dashed : int = 0
var shot_gun : bool = false

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# The player cannot move until their gun is done shooting
# The state changes to ground if the player is on the ground
# The state changes to the wall state if the player has jumped next to a wall
func state_process(delta):
	if dash_jump_duration_timer.is_stopped():
		can_move = true
	if character.is_on_floor():
		#next_state = landing_state
		next_state = ground_state
	if character.is_on_wall():
		next_state = wall_state
	
	
# Manages the direction in which the player can move with a gunshot depending
# on user input
func state_input(event : InputEvent):
	#if not character.has_jumped:
		#if event.is_action_pressed("jump"):
			#jump()
	# Once the gun is done being shot, set shot_gun to false. This makes it so 
	# there is only one gun shot per button press
	if event.is_action_released("shoot"):
		shot_gun = false
	# The player can't shoot again until the dash/jump timer has finished
	if dash_jump_duration_timer.is_stopped():
		# If the shoot button has been pressed once
		if (Input.is_action_pressed("shoot") or InputBuffer.is_action_press_buffered("shoot")) and not shot_gun:
			shot_gun = true
			debug_label.text = "pressed: shoot"
			# Check if the up button has been pressed
			if Input.is_action_pressed("up") or InputBuffer.is_action_press_buffered("up"):
				# Check if the right or left buttons have been pressed. Otherwise
				# perform default up jump
				if Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
					gun_jump_dash(gun_dash_diag_right_velocity)
				elif Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
					gun_jump_dash(gun_dash_diag_left_velocity)
				else:
					debug_label.text = "pressed: shoot & up"
					gun_jump_dash(gun_jump_velocity)
			# Check if only right button has been pressed to perform gun dash to the right
			elif Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
				debug_label.text = "pressed: shoot & right"
				gun_jump_dash(gun_dash_right_velocity)
			# Check if only left button has been pressed to perform gun dash to the left
			elif Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
				debug_label.text = "pressed: shoot & left"
				gun_jump_dash(gun_dash_left_velocity)
	
# Upon exiting the function to enter the ground state, reset variables
func on_exit():
	if next_state == ground_state:
		#playback.travel(landing_animation)
		has_gun_jumped_or_dashed = 0
		can_move = true
		shot_gun = false
	
# Sets the character's Y velocity
#func jump():
	#character.velocity.y = jump_velocity
	#character.has_jumped = true

# Perform the gun dash or jump.
func gun_jump_dash(velocity : Vector2):
	# Limit the number of times the player can shoot in air to specified amount
	if has_gun_jumped_or_dashed < max_number_of_shots:
		character.velocity = velocity
		has_gun_jumped_or_dashed += 1
		
		can_move = false
		dash_jump_duration_timer.wait_time = gun_dash_jump_duration
		dash_jump_duration_timer.start()
		
		# Shake the camera
		Globals.camera.shake(10,0.2)

