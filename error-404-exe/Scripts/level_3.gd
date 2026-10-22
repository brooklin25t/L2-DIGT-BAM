extends Node2D

@onready var spawn: Timer = $bullet_spawn
@onready var survive: Timer = $survival_timer
@onready var bullet_prefab = preload("res://Prefab/bullet2.tscn")
@export var tilemap: TileMap
@export var door: Door
@export var wire_layer: int = 0
@export var tile_source_id: int = 0
@export var unpowered_alt_id: int = 0
@export var powered_alt_id: int = 1

var total_levers: int = 0
var active_levers: int = 0
var body: CharacterBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_area_entered(area: Area2D) -> void:
	spawn.start()
	survive.start()
	print("started")


func _on_bullet_spawn_timeout() -> void:
	var bullet = bullet_prefab.instantiate()
	bullet.position = Vector2(11688, 200)
	add_child(bullet)
	spawn.start()
	
func _ready():
	var levers = get_tree().get_nodes_in_group("Levers")
	total_levers = levers.size()
	
	for lever in levers:
		if lever is Lever:
			lever.lever_state_changed.connect(_on_lever_changed)

func _on_lever_changed(lever: Lever, is_active: bool):
	if is_active:
		active_levers += 1
		power_up_wire(lever.wire_positions)
	
	if active_levers >= total_levers and total_levers > 0:
		if door:
			door.open()

func power_up_wire(positions: Array[Vector2i]):
	if not tilemap:
		return

	for pos in positions:
		var atlas_coords = tilemap.get_cell_atlas_coords(wire_layer, pos)
		
		# Update cell using the powered alternative tile ID
		tilemap.set_cell(
			wire_layer,
			pos,
			tile_source_id,
			atlas_coords,
			powered_alt_id
		)
