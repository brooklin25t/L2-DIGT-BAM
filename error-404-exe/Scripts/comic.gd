extends Node2D

@onready var timer1: Timer = $Timer
@onready var timer2: Timer = $Timer2
@onready var timer3: Timer = $Timer3
@onready var timer4: Timer = $Timer4
@onready var timer5: Timer = $Timer5
@onready var timer6: Timer = $Timer6
@onready var timer7: Timer = $Timer7
@onready var timer8: Timer = $Timer8
@onready var comic_frame1 = $Sprite2D
@onready var comic_frame2 = $Sprite2D2
@onready var comic_frame3 = $Sprite2D3
@onready var blink = $Sprite2D4

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass





func _on_timer_timeout() -> void:
	timer5.start()
	blink.visible = true


func _on_timer_2_timeout() -> void:
	timer6.start()
	blink.visible = true


func _on_timer_3_timeout() -> void:
	timer7.start()
	blink.visible = true



func _on_timer_4_timeout() -> void:
	#get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	pass


func _on_timer_5_timeout() -> void:
	timer2.start()
	comic_frame2.visible = true


func _on_timer_6_timeout() -> void:
	timer3.start()
	comic_frame3.visible = true


func _on_timer_7_timeout() -> void:
	pass # Replace with function body.
