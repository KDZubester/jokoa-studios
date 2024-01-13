extends Node

class_name CharacterStateMachine
################################################################################
## CharacterStateMachine Script
## The main manager of all the states. It manages their reocurring processes and
## their inputs. It also manages the exiting and entering of states.
################################################################################

################################################################################
## Export Variables
################################################################################

# The state the state machine is currently in
@export var current_state : State
#@export var animation_tree : AnimationTree
# A pointer to the CharacterBody2D the player controls
@export var character : CharacterBody2D

################################################################################
## Local Variables
################################################################################

# An array of States that fills at start of program
var states : Array[State]

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
# Checks the children of this node for State objects and addes them to the 
# states Array.
func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			
			child.character = character
			#child.playback = animation_tree["parameters/playback"]
			child.connect("interrupt_state", on_state_interrupt_state)
			
		else:
			push_warning("Child " + child.name + " is not a valid state for CharacterStateMachine")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Instead of each state having its own _physicis_process to get confused between,
# this function calls each statets' "state_process" function, which fills the
# same role. Typically, a state's next state is null, so this function stays in
# the same state unless the current state wants to switch.
func _physics_process(delta):
	if current_state.next_state != null:
		switch_states(current_state.next_state)
	
	current_state.state_process(delta)
	
# Each state has the option of whether the player can move in it or not. This
# checks what the current states "can_move" value is
func check_if_can_move():
	return current_state.can_move
	
# Manages switching between states. Upon exiting, the "on_exit()" function is 
# called and the new state's "next_state" variable is set to null. Then it calls
# the "on_enter()" function of the new state.
func switch_states(new_state : State):
	if current_state != null:
		current_state.on_exit()
		current_state.next_state = null
	current_state = new_state
	
	current_state.on_enter()
	
# Similar to how the _physics_process() function managed the reocurring process
# in each state, this function manages the user input at each state. This also 
# includes an experimental form of Input Buffering
func _input(event : InputEvent):
	#print(event.as_text())
	InputBuffer._input(event)
	current_state.state_input(event)

# Each state has the Interrupt_State signal connected to them. This switches 
# states in the middle of the process in case a state needs to be evacuated.
func on_state_interrupt_state(new_state : State):
	switch_states(new_state)
