extends Path2D

################################################################################
## GrappleDashPath Script
##
## 
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the FollowGrappleDash node
@export var follow_grapple_dash : PathFollow2D
# Grapple Speed
@export var grapple_speed : float = 600
# Pointer to player to get current position when adding points
@export var player : Player

################################################################################
## Local Variables
################################################################################

#Indicate if grappling or not
var is_grappling : bool = false

var starting_point : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_grappling:
		follow_grapple_dash.set_progress(follow_grapple_dash.get_progress() + grapple_speed * delta)

func _on_player_player_starting_grapple(enemy_global_position):
	curve.clear_points()
	follow_grapple_dash.set_progress(0)
	print("Before grappling: " + str(follow_grapple_dash.get_progress()))
	
	curve.add_point(starting_point)
	curve.add_point(enemy_global_position - player.global_position)
	
	is_grappling = true
	#follow_grapple_path


func _on_player_player_stop_grappling():
	print("After grappling: " + str(follow_grapple_dash.get_progress()))
	is_grappling = false
	#tween.stop()
