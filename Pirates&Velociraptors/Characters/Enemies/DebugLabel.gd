extends Label

@export var state_machine : CharacterStateMachine

func _process(delta):
	pass#text = "State: " + state_machine.current_state.name
