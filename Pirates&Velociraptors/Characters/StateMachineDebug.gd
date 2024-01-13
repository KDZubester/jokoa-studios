extends Label

################################################################################
## StateMachineDebug Script
## Prints the state the player is currently in for debug purposes
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the state machine managing the player's actions
@export var state_machine : CharacterStateMachine

func _process(delta):
	text = "State: " + state_machine.current_state.name
