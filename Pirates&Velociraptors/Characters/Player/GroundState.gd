extends State

class_name GroundState
################################################################################
## GroundState Script
##
## Ground State can travel to: AirState & ShootState
## The state is in charge of jumping, and aiming
################################################################################

################################################################################
## Export Variables
################################################################################

# The play'ers base jumping speed
@export var jump_velocity = -400.0
# Pointer to the AirState
@export var air_state : State
# Pointer to the ShootState
@export var shoot_state : State
# Pointer to the AimState
@export var aim_state : State
# Label meant for debugging user input
@export var debug_label : Label
# Pointer to the gun Area2D that contains its CollisionShape2D
@export var gun : Area2D
# Pointer to the gun sprite to show or hide when desired
@export var gun_sprite : Sprite2D
#@export var attack_state : State
#@export var jump_animation : String = "jump_start"
#@export var attack_animation : String = "attack1"

################################################################################
## On-Ready Variables
################################################################################

# Pointer to the timer that controls coyote time
@onready var fall_timer : Timer =  $FallBuffer

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Hide the gun by default
func on_enter():
	gun.monitoring = false

# If the character is no longer on the floor and the coyote timer has stopped
# switch to the air state
func state_process(delta):
	if not character.is_on_floor():
		next_state = air_state
	if not character.is_on_floor() && fall_timer.is_stopped():
		next_state = air_state

# Respond to the appropriate input: Jump, Aim, and Shoot
func state_input(event : InputEvent):
	#if Input.is_action_pressed("jump") or InputBuffer.is_action_press_buffered("jump"):
		#debug_label.text = "pressed: jump"
		#jump()

	gun.monitoring = false

	# Regular Shooting, no aiming.
	if Input.is_action_pressed("shoot"):
		next_state = shoot_state
		gun.show()
	
	# Check for aiming
	if character.enemies_in_grapple_area > 0: # If character.enemy_to_grapple != null
		if Input.is_action_pressed("aim") or InputBuffer.is_action_press_buffered("aim"):
			next_state = aim_state
			#can_move = false
			#gun.show()
			#update_aim()
			#is_aiming = true
			#if Input.is_action_pressed("shoot"):
				#next_state = shoot_state
		#else:
			#is_aiming = false
			#gun.rotation = 0
			#gun_sprite.flip_v = false
			#gun.hide()
			#can_move = true
	#elif event.is_action_pressed("attack"):
		#attack()
		
func on_exit():
	can_move = true

# Sets the character's Y velocity and travels to the AirState
#func jump():
	#character.velocity.y = jump_velocity
	#character.has_jumped = true
	#next_state = air_state
	#playback.travel(jump_animation)

## Manages the gun aiming by rotating and flipping the gun sprite. 
## Can aim Up, Right, and Left.
## TODO: make gun aim diagonally up left/right
#func update_aim():
	##character.direction = Input.get_vector("left", "right", "up", "down")
	##gun.rotation = (-character.direction.x * PI) - (character.direction.y * PI/2)
	##gun_sprite.flip_v = bool(character.direction.x)
	#gun.look_at(character.enemy_to_grapple.global_position)
	##if Input.is_action_pressed("up") or InputBuffer.is_action_press_buffered("up"):
		##gun.rotation = PI/2
	##elif Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
		##gun.rotation = PI
		##gun_sprite.flip_v = true
	##elif  Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
		##gun.rotation = 0
		##gun_sprite.flip_v = false
		

