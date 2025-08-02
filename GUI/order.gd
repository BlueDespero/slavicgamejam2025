extends HBoxContainer
@export var ingredient_instance: PackedScene
const spritesheet = preload("res://plants/plant_assets/Crop_Spritesheet.png")
var rng = RandomNumberGenerator.new()
var order_details: Dictionary = {}

func _ready() -> void:
	generate_order()
	
func _process(delta: float) -> void:
	var red_shade = 1 - $OrderTimeout.time_left / $OrderTimeout.wait_time
	$Background.modulate = Color(red_shade, 1 - red_shade, 1 - red_shade)

func order_fulfilled(storage: Dictionary)->Array:
	for ingredient in order_details.keys():
		if storage[ingredient] < order_details[ingredient]:
			return [false, {}]
			
	for ingredient in order_details.keys():
		storage[ingredient] -= order_details[ingredient]

	return [true, storage]
	
func cash_in_points() -> void:
	# TODO make scoreing dynamic
	EventBus.change_score.emit(calculate_score_for_order())
	
func calculate_score_for_order() -> int:
	return 100

func generate_order() -> void:
	var no_ingredience = rng.randi_range(1,Constants.MAX_INGREDIENCE_PER_ORDER)
	var picked_ingredients = []
	while get_children().filter(func(n): return n is VBoxContainer).size() < no_ingredience:
		var ingredient = Constants.plants.values().pick_random()
		if ingredient.name in picked_ingredients:
			continue
		picked_ingredients.append(ingredient.name)
		var how_much_of_this_ingredience = randi_range(1, Constants.MAX_NUMBER_OF_INGREDIENCE)
		order_details[ingredient.name] = how_much_of_this_ingredience
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


func _on_order_timeout_timeout() -> void:
	# TODO dynamic scoring * discount
	EventBus.change_score.emit(-calculate_score_for_order())
	queue_free()
