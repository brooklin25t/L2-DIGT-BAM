extends Node2D
#gets enemy ready for spawning
@onready var enemy_prefab = preload("res://Prefab/enemy.tscn")
var spawn_limit = 0

@onready var timer1: Timer = $enemy_spawn_timer2
@onready var timer2: Timer = $enemy_spawn_timer3
@onready var timer3: Timer = $enemy_spawn_timer4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_limit >= 10:
		timer1.stop()
		timer2.stop()
		timer3.stop()

#spaws enemy every so often
func _on_enemy_spawn_timer_2_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(-752,1680)
	add_child(enemy)
	spawn_limit += 1


func _on_enemy_spawn_timer_3_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(3040,4288)
	add_child(enemy)
	spawn_limit += 1



func _on_enemy_spawn_timer_4_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(3248,-600)
	add_child(enemy)
	spawn_limit += 1
