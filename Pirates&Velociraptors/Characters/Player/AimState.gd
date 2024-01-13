extends State

class_name AimState
################################################################################
## AimState Script
##
##
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the gun Area2D that contains its CollisionShape2D
@export var gun : Area2D
# Pointer to the gun sprite to show or hide when desired
@export var gun_sprite : Sprite2D
# If the character is on the floor and they stop aiming, go to GroundState
@export var ground_state : State
# If the character is in the air and they stop aiming, go to AirState
@export var air_state : State
# If the player shoots, go to the ShootState
@export var shoot_state : State

################################################################################
## Functions
################################################################################


func state_process(delta):
	update_aim()

# Jump if "jump" button is pressed
func state_input(event : InputEvent):
	if event.is_action_released("aim"):
		if character.is_on_floor():
			next_state = ground_state
		else:
			next_state = air_state
	if event.is_action_pressed("shoot"):
		next_state = shoot_state
		
# Have the gun face the direction that the sprit is facing.
# We currently can't tell if this is working until we start animating the
# Direction of the sprite. We can still do that with just the Godot sprites
# We just animate the player like we're animating the enemies
func on_exit():
	reset_aim()
	character.enemy_to_grapple = null

# Manages the gun aiming by rotating and flipping the gun sprite. 
# Can aim Up, Right, and Left.
# TODO: make gun aim diagonally up left/right
func update_aim():
	#character.direction = Input.get_vector("left", "right", "up", "down")
	#gun.rotation = (-character.direction.x * PI) - (character.direction.y * PI/2)
	#gun_sprite.flip_v = bool(character.direction.x)
	if character.enemy_to_grapple and (character.enemies_in_grapple_area > 0):
		gun.look_at(character.enemy_to_grapple.global_position)
	else:
		reset_aim()
	#if Input.is_action_pressed("up") or InputBuffer.is_action_press_buffered("up"):
		#gun.rotation = PI/2
	#elif Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
		#gun.rotation = PI
		#gun_sprite.flip_v = true
	#elif  Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
		#gun.rotation = 0
		#gun_sprite.flip_v = false

func reset_aim():
	if character.facing_right:
		gun.rotation = 0
		gun_sprite.flip_v = false
	else:
		gun.rotation = PI
		gun_sprite.flip_v = true
