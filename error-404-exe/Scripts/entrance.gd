class_name Door
extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func open():
	# Play the opening animation if available
	if animation_player and animation_player.has_animation("open"):
		animation_player.play("open")
	
	# Disable the collision so the player can pass through
	collision_shape.set_deferred("disabled", true)
