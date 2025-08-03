extends HBoxContainer
@export var order_instance: PackedScene

func _ready() -> void:
	EventBus.storage_updated.connect(_check_if_order_fulfilled)
	$NewOrderTimer.stop()
	$Orders/OrderTimeout.stop()
	EventBus.start_game_button_pressed.connect($NewOrderTimer.start)
	
func _check_if_order_fulfilled(plant_key: String, storage: Dictionary) -> void:
	var last_storage = storage
	for order in get_children().filter(func(n): return n is VBoxContainer):
		var result: Array = order.order_fulfilled(last_storage)
		var fulfilled: bool = result[0]
		if fulfilled:
			last_storage = result[1]
			order.cash_in_points()
			remove_child(order)
			EventBus.set_storage.emit(last_storage)

func _on_new_order_timer_timeout() -> void:
	if get_children().filter(func(n): return n is VBoxContainer).size() < Constants.MAX_NUMBER_ORDERS:
		var NewOrder = order_instance.instantiate()
		add_child(NewOrder)
