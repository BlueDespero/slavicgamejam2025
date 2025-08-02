# map.gd
extends Node2D

@onready var tile_map = $Terrain
@onready var player: Area2D = $Player

var planted_plants = {}

func _ready():
	player.tile_map = tile_map
	EventBus.plant_selected.connect(Callable(self, "_on_plant_selected"))
	var conns = EventBus.plant_selected.get_connections()
	print(conns)
	
func _on_plant_selected(plant_cls: Plant):
	# var plant_data = Constants.get_plant_by_key(plant_key)
	# if plant_data:
	#     var new_plant = preload("res://plant_scene.tscn").instantiate()
	#     new_plant.setup(plant_data)
	#     new_plant.global_position = get_global_mouse_position() # Or some other logic
	#     add_child(new_plant)
	print('HEHHEHEHEHEHEH')
	var curr_tile = tile_map.local_to_map(player.position)
	var plant = plant_cls.create_scene(player.position)
	print(player.position)
	add_child(plant)
