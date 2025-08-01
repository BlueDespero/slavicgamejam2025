extends HBoxContainer
@export var plant_button: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 10:
		var NewButton = plant_button.instantiate()
		add_child(NewButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
