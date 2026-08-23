extends Node2D

@onready var enemy_prefab = preload("res://Prefab/enemy.tscn")
var delete: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_enemy_spawn_timer_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(3272,-640)
	add_child(enemy)


func _on_enemy_spawn_timer_2_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(-752,1680)
	add_child(enemy)


func _on_enemy_spawn_timer_3_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(3040,4288)
	add_child(enemy)
