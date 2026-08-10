extends CharacterBody2D


const SPEED = 300.0
@export var player_prefab = preload("res://Prefab/player.tscn")
@onready var spawn_position: Vector2 = global_position
var player = player_prefab.instantiate()

func respawn():
	# Reset the player's position back to the spawn
	global_position = spawn_position
	# Optional: Reset velocity to zero so the player doesn't keep falling/sliding
	velocity = Vector2.ZERO 


func _physics_process(delta: float) -> void:
	if player == null:
		print("no player")
		return
	#Where is the player
	var direction = (player.position - position).normalized()
	velocity = direction * SPEED
	move_and_slide()
			
	# Loop through all solid contacts from move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.is_in_group("enemies"):
			player.respawn()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		respawn()
