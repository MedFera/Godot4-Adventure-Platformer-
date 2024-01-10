extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var playerVar = get_node("../../Player/Player")


func _physics_process(delta):
	
	apply_gravity(delta)
	#print(get_relative_position(playerVar, self))
	move_and_slide()







func apply_gravity(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	










#CHECKS RELATIVE POSITION BETWEEN CHARACTER AND ENEMY
enum RelativePosition { LEFT, RIGHT, ABOVE, BELOW }

func get_relative_position(player: Node2D, enemy: Node2D) -> RelativePosition:
	var player_position = player.global_position
	var enemy_position = enemy.global_position



	var x_distance = player_position.x - enemy_position.x
	var y_distance = player_position.y - enemy_position.y

	if abs(x_distance) > abs(y_distance):
		if x_distance > 0:
			return RelativePosition.RIGHT #Prints 1
		else:
			return RelativePosition.LEFT #Prints 0
	else:
		if y_distance > 0:
			return RelativePosition.BELOW #Prints 3
		else:
			return RelativePosition.ABOVE #Prints 2





func _on_attack_box_body_entered(body):
	print(body)
	if body.name == "EggProjectile":
		var velocityY = 600
		body.apply_impulse(Vector2(0,-1 * velocityY))
	else:
		pass


func _on_hit_box_body_entered(body):
	#print(body.name)
	if body.name == "EggProjectile":
		body.free()
	else:
		pass 
