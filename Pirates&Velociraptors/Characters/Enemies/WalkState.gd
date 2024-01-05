extends State

@export var walk_speed : float = 2000.0

@export var enemy_character : CharacterBody2D
@export var run_state : Node

func state_process(delta):		
	enemy_character.velocity.x = delta * walk_speed * enemy_character.direction
	enemy_character.move_and_slide()
		
func state_input(event : InputEvent):
	pass

func _on_line_of_sight_body_entered(body):
	next_state = run_state
	print("Player entered line of sight")



func _on_detection_area_2d_body_entered(body):
	print("Enemy detected " + str(body.name))
	if body is Player:
		next_state = run_state
