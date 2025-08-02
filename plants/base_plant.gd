extends RigidBody2D
class_name Plant

# Basic properties
@export var plant_name: String = "Base Plant"
@export var growth_stages: int = 6
var current_stage: int = 0
@export var scene = preload("res://plants/plant.tscn")
# Node reference
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	update_sprite()

func create_scene(pos):
	var plant = scene.instantiate()
	plant.position = pos
	return plant

func grow():
	"""Grow to the next stage"""
	if not can_grow():
		print(plant_name, " can't grow on this field")
		return 
	if current_stage < growth_stages - 1:
		current_stage += 1
		update_sprite()
		print(plant_name, " grew to stage: ", current_stage)
	else:
		print(plant_name, " is fully grown!")

func update_sprite():
	"""Update the sprite based on current stage"""
	if animated_sprite:
		# Set the frame to match the current stage
		animated_sprite.frame = current_stage

# Simple getters
func get_current_stage() -> int:
	return current_stage

func is_fully_grown() -> bool:
	return current_stage >= growth_stages - 1

func can_grow() -> bool:
	return true
