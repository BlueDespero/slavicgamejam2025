extends Plant
class_name LemonPlant

func _ready():
	plant_name = "Lemon"
	growth_stages = 6
	scene = preload("res://plants/Lemon/LemonScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage

func can_grow() -> bool:
	# Lemon plants require sun
	return tile_map.get_shadow(tile) < 1

func influence() -> void:
	tile_map.cast_shadow(tile, 1, current_stage - 1)