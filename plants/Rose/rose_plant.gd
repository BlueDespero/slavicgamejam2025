extends Plant
class_name RosePlant

func _ready():
	plant_name = "Rose"
	growth_stages = 6
	super._ready()

func update_sprite():
	if animated_sprite:
		animated_sprite.frame = current_stage
