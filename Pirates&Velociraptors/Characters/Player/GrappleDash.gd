extends State

class_name GrappleDashState
################################################################################
## GrappleDashState Script
##
##
################################################################################

################################################################################
## Export Variables
################################################################################
# If the character is on the floor and they stop aiming, go to GroundState
@export var ground_state : State
# If the character is in the air and they stop aiming, go to AirState
@export var air_state : State
# Pointer to the timer to leave the state
@export var grapple_dash_timer : Timer

################################################################################
## Signals
################################################################################

# Signal used to indicate to an animation to flip itself
signal start_grapple(enemy_global_position : Vector2)
# Indicate to stop grappling
signal stop_grapple()

func on_enter():
	grapple_dash_timer.start()
	emit_signal("start_grapple", character.enemy_to_grapple.global_position)

func _on_grapple_dash_duration_timeout():
	emit_signal("stop_grapple")
	if character.is_on_floor():
		next_state = ground_state
	else:
		next_state = air_state
