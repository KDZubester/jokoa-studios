extends Node

class_name Damageable
################################################################################
## Damageable Script
##
## This script manages the health of the character. Whenever the health is changed
## It emits a signal to the SignalBus, it also emits the signal "on_hit"
##
## TODO: these two signals are redundant. Find a way to combine them 
## or to change the name of the change_health function to something specifically 
## related to losing health
################################################################################

################################################################################
## Export Variables
################################################################################
#@export var dead_animation : String = "dead"

# Getter and Setter do the same as normal, but when changing the value of health
# Emit the "on_health_changed" signal. This occurs whenever the value "healht"
# is set to a new value
@export var health : float = 20.0 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		
################################################################################
## Signals
################################################################################

# Emits a signal whenever the character is hit. This signal contains the parent
# actor, the actor's new health, and the knockback direction
signal on_hit(node: Node, health_changed : float, knockback_direction : Vector2)


################################################################################
## Functions
################################################################################

# Changes the health of the damageable character and emits the "on_hit" signal
func take_damage(damage : float, knockback_direction : Vector2):
	health += damage
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	#
	if health <= 0:
		get_parent().queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_animation_tree_animation_finished(anim_name):
	#if anim_name == dead_animation:
		#get_parent().queue_free()
