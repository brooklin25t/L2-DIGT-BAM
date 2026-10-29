extends Area2D
class_name Lever

# Signal emitted whenever the lever's state changes
signal state_changed(is_on)
signal lever_state_changed(is_active: bool)
signal tilemaplayer_change

@export var lever_id: int = 0
var is_active: bool = false
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _ready():
	body_entered.connect(_on_body_entered)
	update_visuals()

func _on_body_entered(body):
	if body.is_in_group("Player") and not is_active:
		is_active = true
		update_visuals()
		lever_state_changed.emit(self, is_active)

func update_visuals():
	sprite.stop()
	if is_active:
		sprite.frame = 1
	else:
		sprite.frame = 0
