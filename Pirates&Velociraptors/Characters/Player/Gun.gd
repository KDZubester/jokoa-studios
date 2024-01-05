extends Area2D

@export var damage : float = -5
@export var player : Player
@export var gun : CollisionPolygon2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			if monitoring:
				print("shooting: " + child.name)
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			
			if direction_sign > 0:
				child.change_health(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.change_health(damage, Vector2.LEFT)
			else:
				child.change_health(damage, Vector2.ZERO)
