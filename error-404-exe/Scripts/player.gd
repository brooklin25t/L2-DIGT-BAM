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
@onready var animated_sprite = $AnimatedSprite2D

# Track last absolute directions (1 = right/down, -1 = left/up)
var last_facing_x: float = 1.0
var last_facing_y: float = 0.0 
var preferred_axis: String = "x" # Tracks if player was last moving mainly horizontally or vertically

func respawn():
	# Reset the player's position back to the spawn
	global_position = spawn_position
	# Reset velocity to zero so the player fall/slide
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction = Input.get_vector("player_left", "player_right", "player_up", "player_down")

	# Dash logic
	if dash_time == false:
		if Input.is_action_just_pressed("player_dash") and not is_dashing:
			if direction == Vector2.ZERO:
				# Dash in the last faced horizontal direction if standing still
				dash_direction = Vector2.RIGHT if last_facing_x == 1.0 else Vector2.LEFT
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

	# 2. Check for collisions
	check_enemy_collisions()

	# 3. Store last movement directions and preferred axis
	if direction != Vector2.ZERO:
		if direction.x != 0:
			last_facing_x = sign(direction.x)
		if direction.y != 0:
			last_facing_y = sign(direction.y)
		
		# Remember if we were walking sideways or vertically
		if abs(direction.x) >= abs(direction.y):
			preferred_axis = "x"
		else:
			preferred_axis = "y"

	# 4. Handle animations and sprite flipping
	if is_dashing:
		animated_sprite.flip_h = (dash_direction.x < 0)
		if abs(dash_direction.x) >= abs(dash_direction.y):
			animated_sprite.play("Walking x.axis")
		else:
			animated_sprite.play("Walking y.axis_up" if dash_direction.y < 0 else "Walking y.axis_down")
			
	elif direction != Vector2.ZERO:
		# WALKING ANIMATIONS
		if preferred_axis == "x":
			animated_sprite.flip_h = (last_facing_x == -1.0)
			animated_sprite.play("Walking x.axis")
		else:
			animated_sprite.flip_h = false # Standard orientation for vertical sprites
			if last_facing_y == -1.0:
				animated_sprite.play("Walking y.axis_up")
			else:
				animated_sprite.play("Walking y.axis_down")
	else:
		# IDLE ANIMATIONS (When direction == Vector2.ZERO)
		if preferred_axis == "x":
			animated_sprite.flip_h = (last_facing_x == -1.0)
			animated_sprite.play("Idle x.axis") # Make sure this matches your horizontal idle name
		else:
			animated_sprite.flip_h = false
			if last_facing_y == -1.0:
				animated_sprite.play("Idle y.axis_up")
			else:
				animated_sprite.play("Idle y.axis_down")


func check_enemy_collisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider and collider.is_in_group("Enemies"):
			respawn()
			break

func _on_dash_timer_timeout() -> void:
	is_dashing = false

func _on_dash_cooldown_timer_timeout() -> void:
	dash_time = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Enemies"):
		respawn()
