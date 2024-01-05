extends Camera2D
@export var camera_shake_intensity = 0.0
@export var camera_shake_duration = 0.0

func _ready():
	Globals.camera = self

func shake(intensity, duration):
	# Set the shake parameters
	#
	# A good idea here is to add configuration settings that
	# allow the player to turn off shake
	#
	# if player_no_want:
	# 	intensity = 0
	
	if intensity > camera_shake_intensity and duration > camera_shake_duration:
		camera_shake_intensity = intensity
		camera_shake_duration = duration


func _process(delta):
	
	# Stop shaking if the camera_shake_duration timer is down to zero
	if camera_shake_duration <= 0:
		# Reset the camera when the shaking is done
		self.offset = Vector2.ZERO
		camera_shake_intensity = 0.0
		camera_shake_duration = 0.0
		return
	
	# Subtract the elapsed time from the camera_shake_duration
	# so that it eventually ends
	#
	# You can do other fun stuff here too like have the intensity
	# decay gradually so that the shake tapers off
	camera_shake_duration = camera_shake_duration - delta
	
	# Shake it
	var shake_offset = Vector2.ZERO
	
	# Sine wave based shake
	#
	# Play around with the magic numbers to adjust the feel
	#
	# Basing the sine wave off of get_ticks_msec ensures that
	# the returned value is continuous and smooth
	shake_offset = Vector2(sin(Time.get_ticks_msec() * 0.03), sin(Time.get_ticks_msec() * 0.07)) * camera_shake_intensity * 0.5
		
	self.offset = shake_offset
