extends Button

var button_icon: Texture2D
var button_name: String

# Initialize with spritesheet grid position
func initialize_from_grid(spritesheet: Texture2D, grid_x: int, grid_y: int, cell_size: int, name: String) -> void:
	var x = grid_x * cell_size
	var y = grid_y * cell_size

	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = spritesheet
	atlas_texture.region = Rect2(x, y, cell_size, cell_size)

	button_icon = atlas_texture
	button_name = name

	text = button_name
	icon = button_icon
	
	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
	expand_icon = true
	
	add_theme_constant_override("icon_h_separation", 0)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
