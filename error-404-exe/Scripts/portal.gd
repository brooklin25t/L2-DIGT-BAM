extends Area2D




func _on_area_entered(area: Area2D) -> void:
	if area.name == "character":
		print("teleport")
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
	
	
	
	
	
