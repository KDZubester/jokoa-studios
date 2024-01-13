extends Node

################################################################################
## Signal Bus Script
##
## The signal bus is a singleton that any node can access. This helps communicate
## between nodes that don't normally have access to each other's information
################################################################################

# Signal that a Damageable oject emits when it's health is changed
signal on_health_changed(node : Node, health_change : float)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
