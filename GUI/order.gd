extends HBoxContainer
@export var ingredient_instance: PackedScene
const spritesheet = preload("res://plants/plant_assets/Crop_Spritesheet.png")
var rng = RandomNumberGenerator.new()

func generate_order() -> void:
	var no_ingredience = rng.randi_range(1,Constants.MAX_INGREDIENCE_PER_ORDER)
	var picked_ingredients = []
	while get_children().filter(func(n): return n is VBoxContainer).size() < no_ingredience:
		var ingredient = Constants.plants.values().pick_random()
		if ingredient.name in picked_ingredients:
			continue
		picked_ingredients.append(ingredient.name)
		var how_much_of_this_ingredience = randi_range(1, Constants.MAX_NUMBER_OF_INGREDIENCE)
		var new_ingredient = construct_ingredient(ingredient, how_much_of_this_ingredience)
		add_child(new_ingredient)

func construct_ingredient(plant: Dictionary, amount: int) -> Node:
	var new_ingredient = ingredient_instance.instantiate()
	var icon :TextureRect = new_ingredient.get_node("IngredientIcon")
	icon.texture = get_icon(plant)
	var number_label : Label = new_ingredient.get_node("IngredientNumber")
	number_label.text = str(amount)
	return new_ingredient
	
func get_icon(plant: Dictionary) -> AtlasTexture:
	var cell_size = 16
	
	var atlas_texture = AtlasTexture.new()
	atlas_texture.atlas = spritesheet
	atlas_texture.region = Rect2(
		plant.sprite_positions.x * cell_size, 
		plant.sprite_positions.y * cell_size, 
		cell_size, 
		cell_size
	)
	return atlas_texture

func _ready() -> void:
	generate_order() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
