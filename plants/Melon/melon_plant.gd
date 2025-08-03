extends Plant
class_name MelonPlant

func _ready():
	plant_name = "Melon"
	growth_stages = 6
	scene = preload("res://plants/Melon/MelonScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage

func can_grow() -> bool:
	# Melon cannot grow in shadow
	var shadow_level = tile_map.get_shadow(tile)
	growth_rate = (3 - shadow_level) * 0.05
	return shadow_level <= 1