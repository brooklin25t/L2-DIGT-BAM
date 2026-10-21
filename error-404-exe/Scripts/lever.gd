extends Area2D

signal lever_activated

@export var lever_id: int = 0
var is_active: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	# Connect the body_entered signal to our function
	body_entered.connect(_on_body_entered)
	update_visuals()

func _on_body_entered(body):
	# Check if the colliding object is the player
	if body.is_in_group("Player") and not is_active:
		is_active = true
		update_visuals()
		
func update_visuals():
	if is_active:
		sprite.frame = 1
	else:
		sprite.frame = 0
