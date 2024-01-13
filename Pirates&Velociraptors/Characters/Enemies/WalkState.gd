extends State

class_name WalkState
################################################################################
## WalkState Script
##
## If a Player enters its line of sight, it should travel to the RunState
################################################################################

################################################################################
## Export Variables
################################################################################

# A pointer to the parent actor CharacterBody2D
@export var enemy_character : CharacterBody2D
# A pointer to the RunState node
@export var run_state : Node

################################################################################
## Functions
################################################################################

# The enemy moves at a linear rate determined by its speed and direction
func state_process(delta):
	pass
		
func state_input(event : InputEvent):
	pass

# If a Player enters its line of sight as determened by an Area2D
# go to the RunState
func _on_detection_area_2d_body_entered(body):
	print("Enemy detected " + str(body.name))
	if body is Player:
		next_state = run_state
