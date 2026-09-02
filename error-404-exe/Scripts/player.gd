extends CharacterBody2D


const SPEED = 350.0
const DASHSPEED = 700.0

# seeing if you are dashing
var dash_time: bool = false
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO
@export var player: CharacterBody2D

# Save the starting position when the game loads
@onready var spawn_position = global_position
# dash cooldown timer and the dash time
@onready var dash_timer: Timer = $DashTimer
@onready var dash_cooldown: Timer = $DashCooldownTimer



func respawn():
	# Reset the player's position back to the spawn
	global_position = spawn_position
	# Optional: Reset velocity to zero so the player doesn't keep falling/sliding
	velocity = Vector2.ZERO




		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")

	# Dash logic
	if dash_time == false:
		if Input.is_action_just_pressed("player_dash") and not is_dashing:
			if direction == Vector2.ZERO:
				dash_direction = Vector2.RIGHT
			else:
				dash_direction = direction.normalized()
				
			is_dashing = true
			dash_time = true
			dash_timer.start()
			dash_cooldown.start()

	# Movement
	if is_dashing:
		velocity = dash_direction * DASHSPEED
	else:
		if direction != Vector2.ZERO:
			velocity = direction * SPEED
		else:
			velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	# 1. Move the player
	move_and_slide()

	# 2. Check for collisions directly! No Area2D or signals required.
	check_enemy_collisions()
#

func check_enemy_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		
		# If the object we bumped into is in the "Enemies" group
		if collider and collider.is_in_group("Enemies"):
			get_tree().change_scene_to_file("res://Scenes/death_scene.tscn")
			break


func _on_dash_timer_timeout() -> void:
	is_dashing = false
	



func _on_dash_cooldown_timer_timeout() -> void:
	dash_time = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		get_tree().change_scene_to_file("res://Scenes/death_scene.tscn")
