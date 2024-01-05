extends Area2D

@export var collision_shape : CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func _on_enemy_facing_direction_changed(facing_right):
	if facing_right:
		collision_shape.position = collision_shape.facing_right_position
	else:
		collision_shape.position = collision_shape.facing_left_position
