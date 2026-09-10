extends Node2D

@onready var spawn: Timer = $bullet_spawn
@onready var survive: Timer = $survival_timer
@onready var bullet_prefab = preload("res://Prefab/bullet2.tscn")

var body: CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	spawn.start()
	survive.start()
	print("started")


func _on_bullet_spawn_timeout() -> void:
	var bullet = bullet_prefab.instantiate()
	bullet.position = Vector2(11688, 200)
	add_child(bullet)
	spawn.start()
