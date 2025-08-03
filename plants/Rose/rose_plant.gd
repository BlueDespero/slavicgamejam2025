extends Plant
class_name RosePlant

func _ready():
	plant_name = "Rose"
	growth_stages = 6
	scene = preload("res://plants/Rose/RoseScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage

func can_grow() -> bool:
	"""Roses likes dry soil"""
	var water_level = tile_map.get_water(tile)
	return water_level == 0