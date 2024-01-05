extends Node

class_name Damageable

#@export var dead_animation : String = "dead"
@export var health : float = 20.0 :
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		
signal on_hit(node: Node, health_changed : float, knockback_direction : Vector2)

func change_health(health_change : float, knockback_direction : Vector2):
	health += health_change
	
	emit_signal("on_hit", get_parent(), health_change, knockback_direction)
	#
	#if health <= 0:
		#get_parent().queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#func _on_animation_tree_animation_finished(anim_name):
	#if anim_name == dead_animation:
		#get_parent().queue_free()
