extends Node2D
#gets enemy ready for spawning
@onready var enemy_prefab = preload("res://Prefab/enemy.tscn")

@onready var timer1: Timer = $enemy_spawn_timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#spaws enemy every so often
