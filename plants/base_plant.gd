extends RigidBody2D
class_name Plant

# Basic properties
@export var plant_name: String = "Base Plant"
@export var growth_stages: int = 6
var current_stage: float = 0.0
@export var scene = preload("res://plants/plant.tscn")
# Node reference
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_update: float = 0.0
var update_interval: float = 1.0
var growth_rate: float = 0.1

func _ready():
	update_sprite()

func create_scene(pos):
	var plant = scene.instantiate()
	plant.position = pos
	return plant
	
func _process(delta: float) -> void:
	# Update the terrain periodically
	last_update += delta
	if last_update >= update_interval:
		last_update = 0.0
		grow()

func grow():
	"""Grow to the next stage"""
	if not can_grow():
		print(plant_name, " can't grow on this field")
		return 
	if current_stage < growth_stages - 1:
		current_stage += growth_rate
		update_sprite()

func update_sprite():
	"""Update the sprite based on current stage"""
	if animated_sprite:
		# Set the frame to match the current stage
		animated_sprite.frame = get_current_stage()

# Simple getters
func get_current_stage() -> int:
	return floor(current_stage)

func is_fully_grown() -> bool:
	return current_stage >= growth_stages - 1

func can_grow() -> bool:
	return true
