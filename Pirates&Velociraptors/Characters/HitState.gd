extends State

class_name HitState

@export var damageable : Damageable
@export var character_state_machine : CharacterStateMachine
@export var dead_state : State
#@export var dead_animation : String = "dead"
@export var knockback_velocity : Vector2 = Vector2(50,0)
@export var return_state : State

@onready var timer : Timer = $HitStateTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	damageable.connect("on_hit", on_damageable_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_enter():
	timer.start()

func on_damageable_hit(node : Node, health_changed : float, knockback_direction : Vector2):
	if damageable.health > 0:
		character.velocity = knockback_velocity * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		#playback.travel(dead_animation)
		
func on_exit():
	character.velocity = Vector2.ZERO

func _on_hit_state_timer_timeout():
	next_state = return_state
