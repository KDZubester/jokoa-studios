extends State

@export var walk_state : Node
@export var run_speed : float = 5000.0
@export var enemy_character : CharacterBody2D

func state_process(delta):		
	enemy_character.velocity.x = delta * run_speed * enemy_character.direction
	enemy_character.move_and_slide()
		
func state_input(event : InputEvent):
	pass

func _on_line_of_sight_body_exited(body):
	next_state = walk_state
	print("Player exited line of sight")


func _on_detection_area_2d_body_exited(body):
	print("Enemy lost " + str(body.name))
	if body is Player:
		next_state = walk_state
