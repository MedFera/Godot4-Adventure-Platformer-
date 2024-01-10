extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var player_direction = -1 #Used for egg throw direction
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("AnimationPlayer")
@onready var coyoteTimer = $CoyoteTimer
const projectilePath = preload("res://Player/EggProjectile.tscn")

var extraJump = true
var gotHit = false
var was_on_floor = false
var is_attacking = false
var dashing = false


func _physics_process(delta):
	
	apply_gravity(delta)
	was_on_floor = is_on_floor()
	#Checks Player direction and flips character as needed
	var x_direction = input()	
	movement(x_direction)
	jump()
	
	if Input.is_action_just_pressed("Attack_Button") and is_attacking == false:
		is_attacking = true
		anim.play("Attack1")
		extraJump = false
	move_and_slide()
	
	#COYOTE TIMER CHECK
	if was_on_floor && !is_on_floor():
		coyoteTimer.start()







#Gravity method simplified
func apply_gravity(delta):
		# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

#Executes movement in of sprite 
func movement(direction):
	
	if direction and gotHit == false:
		velocity.x = direction * SPEED
		if velocity.y == 0 and is_attacking == false:
			anim.play("Run")
	elif direction == 0 and gotHit == false:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and is_attacking == false:
			anim.play("Idle")
	if velocity.y > 0 and is_attacking == false:
			anim.play("Jump")

#Checks input for x axis and flips character accordingly
func input():
	var direction = 0
	direction =  Input.get_axis("Left_Button","Right_Button")
	
	#Sprite direction
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = false
		get_node("PlayerThrowMarker").position.x = -50
		get_node("PlayerThrowMarker").position.y = -35
		player_direction = -1
		
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = true
		get_node("PlayerThrowMarker").position.x = 50
		get_node("PlayerThrowMarker").position.y = -35
		player_direction = 1
	
	return direction
	
#JUMP ACTION
func jump():
	# Handle Jump.
	if Input.is_action_just_pressed("Jump_Button") and gotHit == false and is_attacking == false:
		if is_on_floor() or !coyoteTimer.is_stopped():
			velocity.y = JUMP_VELOCITY
			extraJump = true
			#print(extraJump)
		elif extraJump:
			velocity.y = JUMP_VELOCITY
			extraJump = false
			#print(extraJump)
		if velocity.y < 0:
			anim.play("Jump")

#PROJECTILE ATTACK FUNCTION
func throw_egg():
	
	var egg = projectilePath.instantiate()
	#print(egg.name)
	egg.shot_direction = player_direction
	owner.add_child(egg)
	egg.transform = $PlayerThrowMarker.global_transform
	
		

#CODE TO OCCUR AFTER ANIMATION FINISHES
func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Attack1":	
		throw_egg()
		anim.play("Attack1_End")
		await anim.animation_finished
	if anim_name == "Attack1_End":
		is_attacking = false
