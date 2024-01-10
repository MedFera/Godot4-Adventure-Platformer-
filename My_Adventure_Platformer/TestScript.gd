extends CharacterBody2D

const SPEED = 300.0
const JUMP_POWER = -1200.0

const acc = 50
const friction = 70

var gravity = 80
const numberJumps = 2
var currentJump = 0


func _physics_process(delta):
	var input_dir: Vector2 = input()
	#print(input_dir)
	
	if not is_on_floor():
		velocity.y += gravity 
	
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		#play_animation() (running)
	else: 
		add_friction()
		#play_animation() (idle)
	player_movement()
	jump()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("Left_Button","Right_Button")
	input_dir = input_dir.normalized()
	return input_dir

func accelerate(direction):
	velocity = velocity.move_toward(SPEED * direction, acc)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
func player_movement():
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("Jump_Button"):
		if currentJump < numberJumps:
			velocity.y = JUMP_POWER
			currentJump += 1
	
	if is_on_floor():
		currentJump = 1

func play_animation():
	pass
