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
	print("???")
	var obj = plant_cls.new()
	var plant = obj.create_scene(player.position)
	add_child(plant)
	print(self.get_children())
	print('?')
