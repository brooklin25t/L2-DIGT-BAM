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


	# Toggle lever state when the player touches it
	if body.is_in_group("Player"):
		toggle_lever()

func toggle_lever():
	is_active = !is_active
	update_visuals()
	state_changed.emit(is_active)
	if body.is_in_group("Player") and not is_active:
		is_active = true
		update_visuals()
		lever_state_changed.emit(is_active)


func update_visuals():
	if sprite:
		sprite.stop()
		sprite.frame = 1 if is_active else 0
