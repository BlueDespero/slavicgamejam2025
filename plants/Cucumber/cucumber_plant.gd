extends Plant
class_name CucumberPlant

func _ready():
	plant_name = "Cucumber"
	growth_stages = 6
	scene = preload("res://plants/Cucumber/CucumberPlant.tscn")
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage
