extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#sets limit to camera bottom to pixel amount on ready of level
	get_node("Player/Player/Camera2D").limit_bottom = 1700
	


