# map.gd
extends Node2D

@onready var tile_map = $Terrain
@onready var player: Area2D = $Player

var planted_plants = {}

func _ready():
	player.tile_map = tile_map
	EventBus.plant_selected.connect(Callable(self, "_on_plant_selected"))
	
func _on_plant_selected(plant_cls):
	var curr_tile = tile_map.local_to_map(player.position)
	if planted_plants.get(curr_tile):
		print("There is already plant at: ", curr_tile)
		planted_plants[curr_tile].queue_free()
	var plant_inst = plant_cls.new()
	plant_inst._ready()
	var plant = plant_inst.create_scene(curr_tile, tile_map)
	planted_plants[curr_tile] = plant
	add_child(plant)
