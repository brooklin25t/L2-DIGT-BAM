extends Node2D


#starts the game
func _on_startbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")




func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")
