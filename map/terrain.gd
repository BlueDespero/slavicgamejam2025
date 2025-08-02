extends TileMapLayer

const MAX_WATER_LEVEL = 2
const MIN_WATER_LEVEL = 0
const MAX_SHADOW_LEVEL = 3
const MIN_SHADOW_LEVEL = 0

var last_update: float = 0.0
var update_interval: float = 1.0
var map_size: Rect2i

var shadow = {}
var water = {}

func _ready() -> void:
	# Initialize the terrain layer
	# set the undefined tiles to a default tile
	map_size = get_used_rect()
	
	for x in range(map_size.size.x):
		for y in range(map_size.size.y):
			var coords = Vector2i(x, y)
			var atlas = get_cell_atlas_coords(coords)
			if atlas.x == -1:
				atlas = Vector2i(0, 0)
				set_cell(coords, 0, atlas)
			shadow[coords] = atlas.x
			water[coords] = atlas.y
	
	update_terrain()
	

func _input(event):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
	):
		var mouse_pos = get_global_mouse_position()
		var clicked_tile_coords = local_to_map(mouse_pos)
		print("Clicked at: ", clicked_tile_coords)
		print("Tile position: ", map_to_local(clicked_tile_coords))
		
		
func _process(delta: float) -> void:
	# Update the terrain periodically
	last_update += delta
	if last_update >= update_interval:
		last_update = 0.0
		update_terrain()

func update_terrain() -> void:
	# Logic to update the terrain layer
	var water_change = {}
	for x in range(map_size.size.x):
		for y in range(map_size.size.y):
			var coords = Vector2i(x, y)
			if !water_change.has(coords):
				water_change[coords] = 0

			if shadow[coords] > 2 and water[coords] < 2:
				water_change[coords] += 0.1
			if shadow[coords] < 1 and water[coords] > 0:
				water_change[coords] -= 0.1
				
			if water[coords] > 1:
				for neighbor in get_surrounding_cells(coords):
					if !water.has(neighbor):
						continue
					
					if !water_change.has(neighbor):
						water_change[neighbor] = 0

					var water_diff = water[coords] - water[neighbor]
					if water_diff > 0:
						water_change[neighbor] += water_diff * 0.05
						water_change[coords] -= water_diff * 0.05
		

	for x in range(map_size.size.x):
		for y in range(map_size.size.y):
			var coords = Vector2i(x, y)
			if water_change.has(coords) and water_change[coords] != 0:
				water[coords] += water_change[coords]
				if water[coords] < -1:
					water[coords] = -1
				elif water[coords] > 3:
					water[coords] = 3

			var atlas = get_cell_atlas_coords(coords)
			atlas[1] = get_water(coords)
			set_cell(coords, 0, atlas)


func get_water(coords: Vector2i) -> int:
	"""Get the water level at the given coordinates."""
	if water.has(coords):
			var tile_water = floor(water[coords])
			if tile_water < MIN_WATER_LEVEL: tile_water = MIN_WATER_LEVEL
			if tile_water > MAX_WATER_LEVEL: tile_water = MAX_WATER_LEVEL
			return tile_water
	return MIN_WATER_LEVEL

func get_shadow(coords: Vector2i) -> int:
	"""Get the shadow level at the given coordinates."""
	if shadow.has(coords):
		var tile_shadow = floor(shadow[coords])
		if tile_shadow < MIN_SHADOW_LEVEL: tile_shadow = MIN_SHADOW_LEVEL
		if tile_shadow > MAX_SHADOW_LEVEL: tile_shadow = MAX_SHADOW_LEVEL
		return tile_shadow
	return MIN_SHADOW_LEVEL
