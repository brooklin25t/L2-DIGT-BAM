extends Node2D

@onready var spawn: Timer = $bullet_spawn
@onready var survive: Timer = $survival_timer
@onready var tilemaplayer: TileMapLayer = $Node2D/TileMapLayer4
@onready var tilemaplayer2: TileMapLayer = $Node2D/TileMapLayer3
@onready var bullet_prefab = preload("res://Prefab/bullet2.tscn")


var total_levers: int = 0
var active_levers: int = 0
var body: CharacterBody2D

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
	


func _on_lever_tilemaplayer_change() -> void:
	tilemaplayer2.visible = true


func _on_lever_2_tilemaplayer_change_2() -> void:
	tilemaplayer.visible = true
	
