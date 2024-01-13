extends Node

class_name State
################################################################################
## State Script
##
## This is the base class upon all states in every state machine is based upon
## It defines any characteristics and functionalities that all states should 
## have.
################################################################################

################################################################################
## Export Variables
################################################################################

# Every state should have the option to allow character movement or not
@export var can_move : bool = true

################################################################################
## Local Variables
################################################################################

# Every state should be tied to a character's CharacterBody2D
var character : CharacterBody2D
# We use an Animation Node State Machine to animate the characters
var playback : AnimationNodeStateMachinePlayback
# Every state should know what the next state should be. This is null by default
var next_state : State

################################################################################
## Signals
################################################################################

# This signal allows any state to interrupt it's functions and exit to another state
signal interrupt_state(new_state : State)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# This function replaces the _process function so only one state is performing
# its process at a time
func state_process(delta):
	pass
	
# This function replaces the _input function so only one state is checking for
# inputs at a time
func state_input(event : InputEvent):
	pass

# This function is performed upon entering a state
func on_enter():
	pass
	
# This function is performed upon exiting a state
func on_exit():
	pass
