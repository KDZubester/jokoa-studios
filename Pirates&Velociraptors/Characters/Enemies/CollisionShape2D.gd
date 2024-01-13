extends CollisionShape2D

################################################################################
## CollisionShape2D Script
##
## This script is in charge of storing the different positions the character's
## line of sight can be in with relation to the character
################################################################################

################################################################################
## Export Variables
################################################################################

# The two directions the character's line of sight can be in
@export var facing_right_position : Vector2
@export var facing_left_position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
