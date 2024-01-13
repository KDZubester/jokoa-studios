extends Area2D

################################################################################
## Gun Area2D script
################################################################################

################################################################################
## Export Variables
################################################################################

# The amount of damage the gun gives to enemies
@export var damage : float = -5
# Pointer to the player CharacterBody2D
@export var player : Player
# Pointer to the gun CollisionPolygon2D that can check for collisions
@export var gun : CollisionPolygon2D

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# The gun will damage an enemy if they have the Damageable node and the gun is
# monitoring for collisions. This function should also calculate a knockback to
# knock back enemy when shot. 
func _on_body_entered(body):
	for child in body.get_children():
		if child is Damageable:
			if monitoring:
				print("shooting: " + child.name)
			var direction_to_damageable = (body.global_position - get_parent().global_position)
			var direction_sign = sign(direction_to_damageable.x)
			
			if direction_sign > 0:
				child.take_damage(damage, Vector2.RIGHT)
			elif direction_sign < 0:
				child.take_damage(damage, Vector2.LEFT)
			else:
				child.take_damage(damage, Vector2.ZERO)
