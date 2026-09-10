extends Area2D

var survived: bool = false

func _on_area_entered(area: Area2D) -> void:
	if area.name == "character" and survived == true:
		get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_survival_time_timeout() -> void:
	survived = false
