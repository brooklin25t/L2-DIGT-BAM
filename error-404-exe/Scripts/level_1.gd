extends Node2D
#gets enemy ready for spawning
@onready var enemy_prefab = preload("res://Prefab/enemy.tscn")
@onready var enemy2_prefab = preload("res://Prefab/enemy2.tscn")
@onready var enemy3_prefab = preload("res://Prefab/enemy3.tscn")
var spawn_limit = 0

@onready var timer1: Timer = $enemy_spawn_timer2
@onready var timer2: Timer = $enemy_spawn_timer3
@onready var timer3: Timer = $enemy_spawn_timer4
var spawn_stoped: bool = false
var spawn_stoped2: bool = false
var spawn_stoped3: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_limit >= 100:
		timer1.stop()
		timer2.stop()
		timer3.stop()
	if spawn_stoped == true:
		timer1.stop()
	if spawn_stoped2 == true:
		timer2.stop()
	if spawn_stoped3 == true:
		timer3.stop()

#spaws enemy every so often
func _on_enemy_spawn_timer_2_timeout() -> void:
	var enemy = enemy_prefab.instantiate()
	enemy.position = Vector2(-752,1680)
	add_child(enemy)
	enemy.stop_spawn.connect(_on_stop_spawn)
	enemy.start_spawn.connect(_on_start_spawn)
	spawn_limit += 1


func _on_enemy_spawn_timer_3_timeout() -> void:
	var enemy2 = enemy2_prefab.instantiate()
	enemy.position = Vector2(3040,4288)
	add_child(enemy2)
	enemy2.stop_spawn2.connect(_on_stop_spawn_2)
	enemy2.start_spawn2.connect(_on_start_spawn_2)
	spawn_limit += 1
	#add way to hold spawning till spawn stoped is false



func _on_enemy_spawn_timer_4_timeout() -> void:
	var enemy3 = enemy3_prefab.instantiate()
	enemy.position = Vector2(3248,-600)
	add_child(enemy3)
	enemy3.stop_spawn3.connect(_on_stop_spawn_3)
	enemy3.start_spawn3.connect(_on_start_spawn_3)
	spawn_limit += 1


func _on_stop_spawn():
	spawn_stoped = true
	
func _on_start_spawn():
	timer1.start()
	spawn_stoped = false
	
func _on_stop_spawn_2():
	spawn_stoped2 = true
	
func _on_start_spawn_2():
	timer2.start()
	spawn_stoped2 = false
	
func _on_stop_spawn_3():
	spawn_stoped3 = true
	
func _on_start_spawn_3():
	timer3.start()
	spawn_stoped3 = false
