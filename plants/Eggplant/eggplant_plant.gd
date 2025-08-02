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
