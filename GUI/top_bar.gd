extends HBoxContainer
@export var order_instance: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_order_timer_timeout() -> void:
	if get_children().filter(func(n): return n is HBoxContainer).size() < Constants.MAX_NUMBER_ORDERS:
		var NewOrder = order_instance.instantiate()
		add_child(NewOrder)
