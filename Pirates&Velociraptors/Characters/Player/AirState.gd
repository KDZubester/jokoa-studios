extends State

class_name AirState

@export var ground_state : State
#@export var landing_state : State
@export var debug_label : Label
@export var gun_jump_velocity : Vector2 = Vector2(0,-2000.0)
@export var gun_dash_right_velocity : Vector2 = Vector2(2500.0,0)
@export var gun_dash_left_velocity : Vector2 = Vector2(-2500.0,0)
@export var gun_dash_diag_left_velocity : Vector2 = Vector2(-1500.0,-500.0)
@export var gun_dash_diag_right_velocity : Vector2 = Vector2(1500.0,-500.0)
@export var gun_dash_jump_duration : float = 0.1
@export var max_number_of_shots : int = 1

@onready var dash_jump_duration_timer : Timer = $Dash

var has_gun_jumped_or_dashed : int = 0
var shot_gun : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func state_process(delta):
	if dash_jump_duration_timer.is_stopped():
		can_move = true
	if character.is_on_floor():
		#next_state = landing_state
		next_state = ground_state
	
func state_input(event : InputEvent):
	if event.is_action_released("shoot"):
		shot_gun = false
	if dash_jump_duration_timer.is_stopped():
		if (Input.is_action_pressed("shoot") or InputBuffer.is_action_press_buffered("shoot")) and not shot_gun:
			shot_gun = true
			debug_label.text = "pressed: shoot"
			if Input.is_action_pressed("up") or InputBuffer.is_action_press_buffered("up"):
				if Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
					gun_jump_dash(gun_dash_diag_right_velocity)
				elif Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
					gun_jump_dash(gun_dash_diag_left_velocity)
				else:
					debug_label.text = "pressed: shoot & up"
					gun_jump_dash(gun_jump_velocity)
			elif Input.is_action_pressed("right") or InputBuffer.is_action_press_buffered("right"):
				debug_label.text = "pressed: shoot & right"
				gun_jump_dash(gun_dash_right_velocity)
			elif Input.is_action_pressed("left") or InputBuffer.is_action_press_buffered("left"):
				debug_label.text = "pressed: shoot & left"
				gun_jump_dash(gun_dash_left_velocity)
	
func on_exit():
	if next_state == ground_state:
		#playback.travel(landing_animation)
		has_gun_jumped_or_dashed = 0
		can_move = true
		shot_gun = false
	
func gun_jump_dash(velocity):
	if has_gun_jumped_or_dashed < max_number_of_shots:
		character.velocity = velocity
		has_gun_jumped_or_dashed += 1
		
		can_move = false
		dash_jump_duration_timer.wait_time = gun_dash_jump_duration
		dash_jump_duration_timer.start()
		
		Globals.camera.shake(10,0.2)

