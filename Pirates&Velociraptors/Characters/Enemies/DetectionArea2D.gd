extends Area2D

################################################################################
## DetectionArea2D Script
##
## This script keeps the line of sight of the character in front of them
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the characters collision body
@export var collision_shape : CollisionShape2D

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

# If the characters direction changes, the detection area should flip
func _on_enemy_facing_direction_changed(facing_right):
	if facing_right:
		collision_shape.position = collision_shape.facing_right_position
	else:
		collision_shape.position = collision_shape.facing_left_position
