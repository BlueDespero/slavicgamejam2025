extends HBoxContainer
const plant_button = preload("res://GUI/plant_button.tscn")
const spritesheet = preload("res://plants/plant_assets/Crop_Spritesheet.png")

func create_identifier_buttons(spritesheet: Texture2D) -> Array:
	var buttons = []
	
	for plant in Constants.plants:
		var button = plant_button.instantiate()
		button.initialize_from_grid(
			spritesheet, 
			plant.sprite_positions.x, 
			plant.sprite_positions.y, 
			16, 
			plant.name,
			plant.key)
		buttons.append(button)
	
	return buttons


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var identifier_buttons = create_identifier_buttons(spritesheet)
	for button in identifier_buttons:
		add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
