extends Label

################################################################################
## Local Variables
################################################################################

# Enemy to draw target onto when targetted for grappling
var enemy_to_grapple

# Boolian to keep track if targetting or not
var targetting_enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if targetting_enemy and enemy_to_grapple:
		visible = true
		position = enemy_to_grapple.position
	else:
		visible = false


func _on_player_player_stopped_targetting_enemy():
	targetting_enemy = false


func _on_player_player_targetting_enemy(enemy_to_target):
	targetting_enemy = true
	enemy_to_grapple = enemy_to_target
