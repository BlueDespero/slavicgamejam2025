extends Plant
class_name TulipPlant

func _ready():
	plant_name = "Tulip"
	growth_stages = 6
	scene = preload("res://plants/Tulip/TulipScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage
