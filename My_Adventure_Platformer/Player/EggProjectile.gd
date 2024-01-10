extends RigidBody2D

var shot_direction = 1
var speed_X = 300
var speed_Y = 150
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_ground = false
var time_to_live = 1.2  # Time in seconds before the grenade disappears

func _ready():
	# Connect the timeout signal of the timer to a function
	#$Timer.connect("timeout", self, "_on_timeout")
	# Start the timer
	$Timer.start(time_to_live)
	apply_impulse(Vector2(shot_direction * speed_X,-1 * speed_Y))

func _physics_process(_delta):
	# Move the grenade based on its velocity
	pass
	
	

func _on_timeout(): # This function is called when the timer expires
	queue_free()  # Destroy the grenade when the timer expires


