extends Plant
class_name CucumberPlant

func _ready():
	plant_name = "Cucumber"
	growth_stages = 6
	scene = preload("res://plants/Cucumber/CucumberScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage

func influence() -> void:
	growth_rate = tile_map.get_water(tile) * 0.1
	tile_map.water[tile] -= 0.1

func can_grow() -> bool:
	# Cucumber plants require water to grow
	return tile_map.get_water(tile) >= 1
	
