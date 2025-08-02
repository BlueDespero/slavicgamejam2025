# map.gd
extends Node2D

@onready var tile_map = $Terrain
@onready var player: Area2D = $Player

var planted_plants: Dictionary[Vector2i, Plant] = {}

func _ready():
	player.tile_map = tile_map
	EventBus.plant_selected.connect(Callable(self, "_on_plant_selected"))
	EventBus.harvest_crops.connect(_on_harvest_crops)
	
	
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

func _on_harvest_crops(tile_position: Vector2i):
	var plant = planted_plants.get(tile_position)
	if not plant:
		print("There is no plant at: ", tile_position)
		return
	var plant_name = plant.plant_name
	if not plant.is_fully_grown():
		print("Plant not ready for harvesting: ", plant_name)
		return
	planted_plants.erase(tile_position)
	EventBus.update_storage.emit(plant_name, 1)
	plant.queue_free()	
	
