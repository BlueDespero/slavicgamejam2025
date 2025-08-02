extends HBoxContainer
@export var ingredient_instance: PackedScene
var rng = RandomNumberGenerator.new()

func generate_order() -> void:
	for i in rng.randi_range(1,Constants.MAX_INGREDIENCE_PER_ORDER):
		var no_ingredience = rng.randi_range(1, Constants.MAX_NUMBER_OF_INGREDIENCE)
		var ingredient = Constants.plants.pick_random()["name"]
		var new_ingredient = construct_ingredient(ingredient, no_ingredience)
		add_child(new_ingredient)

func construct_ingredient(ingredient_type: String, amount: int) -> Node:
	var new_ingredient = ingredient_instance.instantiate()
	var icon :TextureRect = new_ingredient.get_node("IngredientIcon")
	var number_label : Label = new_ingredient.get_node("IngredientNumber")
	number_label.text = str(amount)
	return new_ingredient
	

func _ready() -> void:
	generate_order() 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
