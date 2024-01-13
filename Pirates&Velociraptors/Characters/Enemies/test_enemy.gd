extends CharacterBody2D

################################################################################
## Test Enemy Script
##
## The Test Enemy script is in charge of check if the enemy is on the ground
## and if the enemy is about to fall off a ledge. If the enemy is not on the
## ground, it should fall. If the enemy approaches a ledge, it should change
## directions.
################################################################################

################################################################################
## Export Variables
################################################################################

@export var state_machine : CharacterStateMachine

@export var walk_speed : float = 50.0

@export var run_speed : float = 200.0

################################################################################
## On-Ready Variables
################################################################################

# Pointer to the enemies sprite
@onready var sprite : Sprite2D = $Sprite2D
# A raycast vector that checks if the enemy is about to fall off an edge
@onready var raycast_floor : RayCast2D = $RayCastFloor

################################################################################
## Local Variables
################################################################################

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# The direction the enemy is moving (-1 is left, 1 is right)
var direction = -1
# Booleans used to flip the enemy and its raycast vector only once upon reaching
# an edge
var first_flip_2_right : bool = true
var first_flip_2_left : bool = true

################################################################################
## Signals
################################################################################

# Signal used to indicate to an animation to flip itself
signal facing_direction_changed(facing_right : bool)

################################################################################
## Functions
################################################################################

# Checks if the enemy is on the floor and if it is about to reach a ledge
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# if the raycast vector is no longer colliding with anything, flip the player
	if not raycast_floor.is_colliding():
		direction = -direction
		
	update_facing_direction()
	
	if state_machine != null:
		if state_machine.current_state is WalkState and state_machine.check_if_can_move():
			velocity.x = direction * walk_speed
		elif state_machine.current_state is RunState and state_machine.check_if_can_move():
			velocity.x = direction * run_speed
			#velocity.x = move_toward(velocity.x, 0, snail_speed)
	
	move_and_slide()

# Keeps track of the direction the enemy is facing. The direction changes only
# once upon reaching an edge. The raycast vector should flip along with the sprite
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
