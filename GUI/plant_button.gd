extends Button

var button_icon: Texture2D
var assigned_key: Key
var button_name: String
var plant_button_text_template: String = "%s (%d) \nIn strore: %d"

func initialize_from_grid(spritesheet: Texture2D, plant: Dictionary, cell_size: int) -> void:
	var x = plant.sprite_positions.x * cell_size
	var y = plant.sprite_positions.y * cell_size

	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = spritesheet
	atlas_texture.region = Rect2(x, y, cell_size, cell_size)
	button_icon = atlas_texture
	
	button_name = plant.name
	assigned_key = plant.key

	text = plant_button_text_template % [plant.name, plant.key - 48, 0]
	add_theme_font_size_override("font_size", 12)
	icon = button_icon

	icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	vertical_icon_alignment = VERTICAL_ALIGNMENT_TOP
	expand_icon = true

	add_theme_constant_override("icon_h_separation", 0)

	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == assigned_key:
			trigger_action()

func trigger_action() -> void:
	print("Button triggered by hotkey: " + button_name)
	pressed.emit()
	
	modulate = Color(1.2, 1.2, 1.2)
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color.WHITE, 0.3)

func _process(delta: float) -> void:
	pass
