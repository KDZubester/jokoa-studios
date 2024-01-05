extends CharacterBody2D

@onready var sprite : Sprite2D = $Sprite2D
@onready var raycast_floor : RayCast2D = $RayCastFloor

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = -1
var first_flip_2_right : bool = true
var first_flip_2_left : bool = true

signal facing_direction_changed(facing_right : bool)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if not raycast_floor.is_colliding():
		direction = -direction
		
	update_facing_direction()

func update_facing_direction():
	emit_signal("facing_direction_changed", not sprite.flip_h)
	if direction > 0:
		sprite.flip_h = false
		if first_flip_2_right:
			first_flip_2_right = false
			first_flip_2_left = true
			raycast_floor.position.x = -raycast_floor.position.x
	elif direction < 0:
		sprite.flip_h = true
		if first_flip_2_left:
			first_flip_2_left = false
			first_flip_2_right = true
			raycast_floor.position.x = -raycast_floor.position.x
