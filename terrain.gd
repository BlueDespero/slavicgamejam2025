extends TileMapLayer


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
			if atlas[0] == -1:
				set_cell(coords, 0, Vector2i(0, 0))
			shadow[coords] = atlas[0]
			water[coords] = atlas[1]
	
	update_terrain()
	

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

			if shadow[coords] > 3:
				water[coords] += 0.5
			if shadow[coords] < 1:
				water[coords] -= 0.
				
			if water[coords] > 1:
				for neighbor in get_surrounding_cells(coords):
					if !water.has(neighbor):
						continue
					
					if !water_change.has(neighbor):
						water_change[neighbor] = 0

					var water_diff = water[coords] - water[neighbor]
					if water_diff > 0:
						water_change[neighbor] += water_diff * 1/6
						water_change[coords] -= water_diff * 1/6
		

	for x in range(map_size.size.x):
		for y in range(map_size.size.y):
			var coords = Vector2i(x, y)
			if water_change.has(coords):
				water[coords] += water_change[coords]
				if water[coords] < 0:
					water[coords] = 0
				elif water[coords] > 3:
					water[coords] = 3

			var atlas = get_cell_atlas_coords(coords)
			atlas[1] = floor(water[coords])
			set_cell(coords, 0, atlas)
