extends RigidBody2D
class_name Plant

# Basic properties
@export var plant_name: String = "Base Plant"
@export var growth_stages: int = 6
var current_stage: float = 0.0
@export var scene = preload("res://plants/plant.tscn")
var tile_map: TileMapLayer
var tile: Vector2i

# Node reference
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_update: float = 0.0
var update_interval: float = 1.0
var growth_rate: float = 0.1

var jump_position: int = 0
var jump_timer: float = 0.0

func _ready():
	update_sprite()

func create_scene(curr_tile, curr_tile_map: TileMapLayer) -> Node2D:
	var plant = scene.instantiate()
	plant.position = curr_tile_map.map_to_local(curr_tile)
	plant.tile = curr_tile
	plant.tile_map = curr_tile_map
	return plant
	
func _process(delta: float) -> void:
	# Update the terrain periodically
	last_update += delta
	
	if is_fully_grown():
		make_it_jump(delta)
			
	if last_update >= update_interval:
		last_update = 0.0
		grow()
		influence()
		
func make_it_jump(delta: float):
	jump_timer += delta
	if jump_timer < 0.15:
		return
	jump_timer = 0.0
	var jump_height = 10
	if jump_position == 0:
		self.position.y -= jump_height
		jump_position = 1
	else:
		self.position.y += jump_height
		jump_position = 0
	

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

func influence() -> void:
	pass
