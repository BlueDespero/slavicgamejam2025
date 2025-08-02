extends Plant
class_name TurnipPlant

func _ready():
	plant_name = "Turnip"
	growth_stages = 6
	scene = preload("res://plants/Turnip/TurnipScene.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage
