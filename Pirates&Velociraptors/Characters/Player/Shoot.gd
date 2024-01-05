extends State

class_name ShootState

@export var air_state : State
@export var gun : Area2D
@export var gun_sprite : Sprite2D
@export var ground_state : State
@export var shoot_timer : Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_enter():
	gun.monitoring = true
	shoot_timer.start()

func state_process(delta):
	pass

func state_input(event : InputEvent):
	pass
		
func on_exit():
	gun.monitoring = false


func _on_shoot_timer_timeout():
	if not character.is_on_floor():
		next_state = air_state
	else:
		next_state = ground_state
