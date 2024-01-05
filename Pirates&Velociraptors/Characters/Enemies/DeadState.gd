extends State

class_name DeadState

func on_enter():
	get_parent().queue_free()
