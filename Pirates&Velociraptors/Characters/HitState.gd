extends State

class_name HitState

################################################################################
## HitState Script
##
## This script is in charge of applying a knockback to the character when hit
## If the character dies, the state should travel to the DeadState
################################################################################

################################################################################
## Export Variables
################################################################################

# Pointer to the node that allows the character to get hurt
@export var damageable : Damageable
# Pointer to the state machine manager
@export var character_state_machine : CharacterStateMachine
# Pointer to the DeadState for if the character dies
@export var dead_state : State
# The velocity at which the character is knocked back when damaged
@export var knockback_velocity : Vector2 = Vector2(50,0)
# Pointer to the state the enemy should return to after knockback is finished
@export var return_state : State

################################################################################
## On-Ready Variables
################################################################################

# Pointer to a timer controlling how long the character should be knocked back
@onready var timer : Timer = $HitStateTimer

################################################################################
## Functions
################################################################################

# Called when the node enters the scene tree for the first time.
# Connect the "on_hit" signal that the damageable node emits to this node
func _ready():
	damageable.connect("on_hit", on_damageable_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
# Upon entering the state, start the timer
func on_enter():
	timer.start()

# When the damageable node registers a hit, apply a knockback to the character
# sprite. If the character dies, go to the DeadState
func on_damageable_hit(node : Node, health_changed : float, knockback_direction : Vector2):
	if damageable.health > 0:
		print("knockback vel: " + str(knockback_velocity))
		print("knockback dir: " + str(knockback_direction))
		character.velocity = knockback_velocity * knockback_direction
		emit_signal("interrupt_state", self)
	else:
		emit_signal("interrupt_state", dead_state)
		#playback.travel(dead_animation)
		
# Upon exiting the state, make the character stop moving
func on_exit():
	character.velocity = Vector2.ZERO

# Once the knockback is done playing out, go back to the previous state
func _on_hit_state_timer_timeout():
	next_state = return_state
