extends Node

################################################################################
## Main Script
## Keeps track of the main scene. If the player falls into a collision domain at
## the bottom of the screen, they  respawn at the start.
################################################################################

################################################################################
## Export Variables
################################################################################
# player points to the CharacterBody2D that the player controls
@export var player : Player
# starting_position refers to the respawn point of the player
@export var starting_position : Vector2 = Vector2(154,221)

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called whenever the player object enters the Area2D at the bottom of the main scene
# Respawn the player whenever they enter the Area2D
func _on_area_2d_body_entered(body):
	if body is Player:
		player.position = starting_position
