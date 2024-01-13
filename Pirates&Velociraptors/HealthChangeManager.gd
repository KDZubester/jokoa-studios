extends Control

################################################################################
## HealthChangedManager Script
## This script recieves the on_health_changed signal to dynamically draw the
## change in health of a character.
################################################################################

################################################################################
## Export Variables
################################################################################

# health_changed_label is a PackedScene, which means that it is a simplified 
# interface to a scene file. It Provides access to operations and checks that 
# can be performed on the scene resource itself.
@export var health_changed_label : PackedScene
# damage_color is Godot's default RED color used when a character takes damage
@export var damage_color : Color = Color.RED
# heal_color is Godot's default GREEN color used when a character gains health
@export var heal_color : Color = Color.GREEN

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
# Connects the "on_health_changed" signal in SignalBus to the function on_signal_health_changed
# in the current node.
func _ready():
	SignalBus.connect("on_health_changed", on_signal_health_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# When the signal is received, an instantiation of the health_changed_label is
# added as a child to the node that had its health changed. The value and color
# will depend on whether health is gained or lost
func on_signal_health_changed(node : Node, health_changed):
	var label_instance : Label = health_changed_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(health_changed)
	
	if health_changed >= 0:
		label_instance.modulate = heal_color
	else:
		label_instance.modulate = damage_color
