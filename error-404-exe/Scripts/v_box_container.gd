extends VBoxContainer

# Speed in pixels per second
@export var speed: float = 75.0

func _process(delta: float) -> void:
	# move node up every frame
	position.y -= speed * delta
	
	# If the bottom of this node goes past the top of the screen (0)
	if position.y + size.y < 0:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
