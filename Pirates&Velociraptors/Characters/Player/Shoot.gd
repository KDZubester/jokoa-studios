extends State

class_name ShootState
################################################################################
## ShootState Script
##
## This state can travel to the: GroundState and AirState
## It is in charge of monitoring the Guns Area2D for collisions.
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the AirState
@export var air_state : State
# Pointer to GroundState
@export var ground_state : State
# Pointer to the Gun Area2D and the gun's CollisionShape2D and Sprite2D
@export var gun : Area2D
# Pointer to the Gun's sprite Sprite2D
@export var gun_sprite : Sprite2D
# The timer that helps decide what state to travel to after finished shooting
@export var shoot_timer : Timer

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Upon entering, make the gun monitor its collision shape and start its timer
func on_enter():
	gun.monitoring = true
	shoot_timer.start()

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
		
# Upon exiting, make the gun stop monitoring its collision shape
func on_exit():
	gun.monitoring = false

# If the character is in the air after shooting, travel to the AirState
# Otherwise, travel to the GroundState
func _on_shoot_timer_timeout():
	if not character.is_on_floor():
		next_state = air_state
	else:
		next_state = ground_state
