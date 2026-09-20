extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area.name == "character":
		get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
