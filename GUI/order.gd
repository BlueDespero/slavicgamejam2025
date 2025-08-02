extends VBoxContainer
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
			
	var updated_storage = storage.duplicate(true)
	for ingredient in order_details.keys():
		updated_storage[ingredient] -= order_details[ingredient]
	return [true, updated_storage]
	
func cash_in_points() -> void:
	EventBus.change_score.emit(calculate_score_for_order())
	
func calculate_score_for_order() -> int:
	var total_score = 0
	
	# Iterate through each ingredient in the order
	for ingredient_name in order_details.keys():
		var quantity = order_details[ingredient_name]
		
		var plant_data = Constants.plants[ingredient_name]
		var ingredient_points = plant_data.points_per_plant * quantity		
		total_score += ingredient_points
	
	var difficulty_multiplier = calculate_difficulty_multiplier()
	
	return int(total_score * difficulty_multiplier)

func calculate_difficulty_multiplier() -> float:
	var base_multiplier = 1.0
	
	# More ingredients = higher multiplier
	var ingredient_count = order_details.size()
	var ingredient_bonus = (ingredient_count - 1) * 0.2  # 20% bonus per extra ingredient
	
	# Higher quantities = higher multiplier  
	var total_quantity = 0
	for quantity in order_details.values():
		total_quantity += quantity
	var quantity_bonus = (total_quantity - order_details.size()) * 0.1  # 10% bonus per extra item
	
	# Time pressure bonus (order done quicker = better)
	var time_bonus = 0.0
	if $OrderTimeout.time_left > $OrderTimeout.wait_time * 0.6:
		time_bonus = 0.5
	elif $OrderTimeout.time_left > $OrderTimeout.wait_time * 0.3:
		time_bonus = 0.25
	
	return base_multiplier + ingredient_bonus + quantity_bonus + time_bonus

func generate_order() -> void:
	var no_ingredience = rng.randi_range(1,Constants.MAX_INGREDIENCE_PER_ORDER)
	var picked_ingredients = []
	var ingredients_box = get_node("Ingredients")
	while ingredients_box.get_children().filter(func(n): return n is VBoxContainer).size() < no_ingredience:
		var ingredient = Constants.plants.values().pick_random()
		if ingredient.name in picked_ingredients:
			continue
		picked_ingredients.append(ingredient.name)
		var how_much_of_this_ingredience = randi_range(1, Constants.MAX_NUMBER_OF_INGREDIENCE)
		order_details[ingredient.name] = how_much_of_this_ingredience
		var new_ingredient = construct_ingredient(ingredient, how_much_of_this_ingredience)
		ingredients_box.add_child(new_ingredient)

	var order_points_label = get_node("ExtraInfo/OrderPoints")	
	var order_points = calculate_score_for_order()
	order_points_label.text = "Max %d pts" % order_points


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
