extends State

class_name RunState
################################################################################
## RunState Script
##
## If a player leaves the enemy's line of sight, travel back to the WalkState
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the WalkState
@export var walk_state : Node
# A pointer to the parent actor's CharacterBody2D
@export var enemy_character : CharacterBody2D

################################################################################
## Functions
################################################################################

# The enemy will run at a velocity determined by a direction and speed
func state_process(delta):
	pass
		
func state_input(event : InputEvent):
	pass

# When a player leaves the enemy's line of sight, travel to the walk state
func _on_detection_area_2d_body_exited(body):
	print("Enemy lost " + str(body.name))
	if body is Player:
		next_state = walk_state
