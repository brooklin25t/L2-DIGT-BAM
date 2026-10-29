extends StaticBody2D

@export var lever_1: Node
@export var lever_2: Node
@onready var enterance: StaticBody2D = $"."

var lever_1_active: bool = false
var lever_2_active: bool = false

func _ready():
	pass

func check_door_status():
	if lever_1_active and lever_2_active == true:
		open_door()
	else:
		close_door()

func open_door():
	print("Door Opened!")
	collision_layer = 0
	collision_mask = 0
	enterance.visible = false
	# Play opening animation or disable collision here

func close_door():
	print("Door Closed!")
	collision_layer = 1
	collision_mask = 1
	enterance.visible = false
	# Play closing animation or enable collision here


func _on_lever_on_lever_2_changed() -> void:
	lever_2_active = true
	check_door_status()


func _on_lever_2_on_lever_1_changed() -> void:
	lever_1_active = true
	print("yes")
	check_door_status()
