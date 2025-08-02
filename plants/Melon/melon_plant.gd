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
