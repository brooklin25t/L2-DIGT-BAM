extends CharacterBody2D

const SPEED = 300.0
@onready var player_prefab = preload("res://Prefab/player.tscn")
@onready var spawn_position: Vector2 = global_position
@onready var nav2d: NavigationAgent2D = $NavigationAgent2D
var player: CharacterBody2D
signal enemy_delete

func respawn():
	#Reset the player's position back to the spawn
	global_position = spawn_position
	#Optional: Reset velocity to zero so the player doesn't keep falling/sliding
	velocity = Vector2.ZERO 

func _ready() -> void:
	await get_tree().physics_frame
	player = get_tree().get_first_node_in_group("Target")


func _physics_process(delta: float) -> void:
	if not player:
		print("help")
		return
	if player != null:
		nav2d.target_position = player.global_position
	if nav2d.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav2d.get_next_path_position()
	var direction: Vector2 = current_agent_position.direction_to(next_path_position)
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
		enemy_delete.emit()
