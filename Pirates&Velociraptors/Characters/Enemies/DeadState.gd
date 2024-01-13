extends State

class_name DeadState
################################################################################
## DeadState Script
##
## This state should remove the character from the scene when they die
################################################################################

################################################################################
## Functions
################################################################################

# Upon entering the DeadState, the character should be removed from the scene
func on_enter():
	#get_parent().queue_free()
	pass
