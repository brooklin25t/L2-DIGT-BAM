extends CharacterBody2D

const SPEED = 300.0
@onready var player_prefab = preload("res://Prefab/player.tscn")
@onready var spawn_position: Vector2 = global_position
@onready var nav2d: NavigationAgent2D = $NavigationAgent2D
@onready var animated_sprite = $AnimatedSprite2D

var player: CharacterBody2D
signal enemy_delete

# Track last horizontal direction (1 = right, -1 = left)
var last_facing_x: float = 1.0

func respawn():
	global_position = spawn_position
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
		
	# Checks to see if enemy reached destination
	if nav2d.is_navigation_finished():
		velocity = Vector2.ZERO
		move_and_slide()
		# Play idle animation when stopped
		animated_sprite.flip_h = (last_facing_x == -1.0)
		animated_sprite.play("Idle x.axis")
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = nav2d.get_next_path_position()
	var direction: Vector2 = current_agent_position.direction_to(next_path_position)
	
	velocity = direction * SPEED
	move_and_slide()
	
	# Loop through all solid contacts safely
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# Safely check if the collider exists and is the player target
		if collider and collider.is_in_group("Target"):
			if collider.has_method("respawn"):
				collider.respawn()
	
	# Check if the enemy is actually moving horizontally significantly
	if abs(direction.x) > 0.05:
		last_facing_x = sign(direction.x)
		animated_sprite.flip_h = (last_facing_x == -1.0)
		animated_sprite.play("Walking x.axis")
	else:
		# If moving purely vertically or standing still, use the horizontal profile facing the last known side
		animated_sprite.flip_h = (last_facing_x == -1.0)
		animated_sprite.play("Idle x.axis")

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		enemy_delete.emit()
