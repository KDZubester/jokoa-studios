extends Label

################################################################################
## HealthChangedLabel Script
##
## This script is in charge of moving the label representing a change in health
## up, basically animating it
################################################################################

################################################################################
## Export Variables
################################################################################

# The float speed is the speed at which the label will rise in the air
@export var float_speed : Vector2 = Vector2(0, 50)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position -= float_speed * delta

# When the timer reaches 0, remove the label from the queue/scene
func _on_timer_timeout():
	queue_free()
