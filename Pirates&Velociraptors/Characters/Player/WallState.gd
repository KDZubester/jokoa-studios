extends State

class_name WallState
################################################################################
## WallState Script
##
## WallState can travel to GroundState and AirState
## This script manages wall jumps
## TODO: make the player slowly slide down wall when the user tries to grab onto it
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to GroundState
@export var ground_state : State
# Pointer to AirState
@export var air_state : State
# Pointer to the label to debug user input
@export var debug_label : Label
# Wall jump velocity
@export var jump_velocity : float = -400

################################################################################
## Functions
################################################################################

# If the player lands on the ground, travel to the GroundState
func state_process(delta):
	if character.is_on_floor():
		next_state = ground_state
	if not character.is_on_wall():
		next_state = air_state
		
	#wall_slide_down()

# Jump if "jump" button is pressed
func state_input(event : InputEvent):
	if Input.is_action_pressed("jump") or InputBuffer.is_action_press_buffered("jump"):
		debug_label.text = "pressed: jump"
		wall_jump()
		
# Set the character's Y velocity and travel to AirState
func wall_jump():
	if Input.is_action_pressed("left"):
		character.velocity.y = jump_velocity
		character.velocity.x = 1000
		next_state = air_state
	if Input.is_action_pressed("right"):
		character.velocity.y = jump_velocity
		character.velocity.x = 1000
		next_state = air_state
	
func wall_slide_down():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		character.velocity.y = min(character.velocity.y, 1)
