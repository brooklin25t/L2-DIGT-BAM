extends StaticBody2D

@export var lever_1: Node
@export var lever_2: Node

var lever_1_active: bool = false
var lever_2_active: bool = false

func _ready():
	# Connect the custom state_changed signals from both levers
	if lever_1:
		lever_1.connect("state_changed", _on_lever_1_changed)
	if lever_2:
		lever_2.connect("state_changed", _on_lever_2_changed)

func _on_lever_1_changed(active: bool):
	lever_1_active = active
	check_door_status()

func _on_lever_2_changed(active: bool):
	lever_2_active = active
	check_door_status()

func check_door_status():
	if lever_1_active and lever_2_active:
		open_door()
	else:
		close_door()

func open_door():
	print("Door Opened!")
	# Play opening animation or disable collision here

func close_door():
	print("Door Closed!")
	# Play closing animation or enable collision here
