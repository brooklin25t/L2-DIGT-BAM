extends CharacterBody2D

const SPEED = 330.0
@onready var player_prefab = preload("res://Prefab/player.tscn")
@onready var nav2d: NavigationAgent2D = $NavigationAgent2D
var player: CharacterBody2D

func _ready() -> void:
	#makes the player the target
	player = get_tree().get_first_node_in_group("Target")


func _physics_process(delta: float) -> void:
	#checks if the player is in the scene
	if not player:
		print("help")
		return
	#gets player position
	if player != null:
		nav2d.target_position = player.global_position
	#checks if the navigation is finished and then sets speed to zreo
	if nav2d.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		return
	#where the enemy is
	var current_agent_position: Vector2 = global_position
	#finding the path for the enemy
	var next_path_position: Vector2 = nav2d.get_next_path_position()
	#gives direction
	var direction: Vector2 = current_agent_position.direction_to(next_path_position)
	#makes it move
	velocity = direction * SPEED
	#alows it to move
	move_and_slide()
	
	# Loop through all solid contacts from move_and_slide()
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		if collider.is_in_group("enemies"):
			get_tree().change_scene_to_file("res://Scenes/death_scene.tscn")
