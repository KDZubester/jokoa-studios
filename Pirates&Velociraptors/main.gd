extends Node

@export var player : Player
@export var starting_position : Vector2 = Vector2(154,221)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body is Player:
		player.position = starting_position
