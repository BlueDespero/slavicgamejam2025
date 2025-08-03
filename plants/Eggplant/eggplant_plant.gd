extends Plant
class_name EggplantPlant

func _ready():
	plant_name = "Eggplant"
	growth_stages = 6
	scene = preload("res://plants/Eggplant/EggplantScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage

func can_grow() -> bool:
	# Eggplant plants require a lot of water to grow fast
	var water_level = tile_map.get_water(tile)
	if water_level <= 1:
		growth_rate = 0.05
	growth_rate = 0.15
	return true