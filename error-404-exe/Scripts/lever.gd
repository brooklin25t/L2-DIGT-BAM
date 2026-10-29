extends Area2D
class_name Lever

# Signal emitted whenever the lever's state changes
signal state_changed(is_on)
signal lever_state_changed(is_active: bool)

@export var lever_id: int = 0
var is_active: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
