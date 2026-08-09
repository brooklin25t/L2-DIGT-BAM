extends Node2D

@onready var enemy_prefab = preload("res://Prefab/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(127,-354)
	add_child(enemy)
