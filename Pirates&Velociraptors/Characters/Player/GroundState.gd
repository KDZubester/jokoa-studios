extends State

class_name GroundState

@export var jump_velocity = -400.0
@export var air_state : State
@export var debug_label : Label
@export var gun : Area2D
@export var gun_sprite : Sprite2D
@export var shoot_state : State
#@export var attack_state : State
#@export var jump_animation : String = "jump_start"
#@export var attack_animation : String = "attack1"

@onready var coyote_timer : Timer =  $CoyoteBuffer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_enter():
	gun.monitoring = false

func state_process(delta):
	if not character.is_on_floor():
		coyote_timer.start()
	if not character.is_on_floor() && coyote_timer.is_stopped():
		next_state = air_state

func state_input(event : InputEvent):
	if Input.is_action_pressed("jump") or InputBuffer.is_action_press_buffered("jump"):
		debug_label.text = "pressed: jump"
		jump()
	
	
	gun.monitoring = false
	
	# Check for aiming
	if Input.is_action_pressed("aim") or InputBuffer.is_action_press_buffered("aim"):
		can_move = false
		gun.show()
		update_aim()
		if Input.is_action_pressed("shoot"):
			next_state = shoot_state
	else:
		gun.rotation = 0
		gun_sprite.flip_v = false
		gun.hide()
		can_move = true
	#elif event.is_action_pressed("attack"):
		#attack()
		
func on_exit():
	can_move = true

func jump():
	character.velocity.y = jump_velocity
	next_state = air_state
	#playback.travel(jump_animation)

func update_aim():
	#character.direction = Input.get_vector("left", "right", "up", "down")
	#gun.rotation = (-character.direction.x * PI) - (character.direction.y * PI/2)
	#gun_sprite.flip_v = bool(character.direction.x)
	
	if Input.is_action_pressed("up") or InputBuffer.is_action_press_buffered("up"):
		gun.rotation = PI/2
	elif Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
		gun.rotation = PI
		gun_sprite.flip_v = true
	elif  Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
		gun.rotation = 0
		gun_sprite.flip_v = false
		
