extends Area2D
class_name Lever

signal lever_state_changed(is_active: bool)
signal 

@export var lever_id: int = 0
# A list of tile coordinates in the Inspector that represent this lever's wire
@export var wire_positions: Array[Vector2i] = []

var is_active: bool = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	body_entered.connect(_on_body_entered)
	update_visuals()

func _on_body_entered(body):
	if body.is_in_group("Player") and not is_active:
		is_active = true
		update_visuals()
		lever_state_changed.emit(is_active)
		

func update_visuals():
	if is_active:
		sprite.stop()
		sprite.frame = 1
	else:
		sprite.stop()
		sprite.frame = 0
