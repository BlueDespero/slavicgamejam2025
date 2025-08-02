extends HBoxContainer
@export var order_instance: PackedScene

func _ready() -> void:
	EventBus.storage_updated.connect(_check_if_order_fulfilled)
	
func _check_if_order_fulfilled(plant_key: String, storage: Dictionary) -> void:
	var any_orders_fulfilled:bool = true
	
	# loop hrough the orders and see if they can be completed
	for order in get_children().filter(func(n): return n is HBoxContainer):
		var result: Array = order.order_fulfilled(storage)
		var fulfilled: bool = result[0]
		if fulfilled:
			# update storage with consumed goods
			storage = result[1]
			order.cash_in_points()
			remove_child(order)

	if any_orders_fulfilled:
		# send back the new values to global storage
		EventBus.set_storage.emit(storage)

func _on_new_order_timer_timeout() -> void:
	if get_children().filter(func(n): return n is HBoxContainer).size() < Constants.MAX_NUMBER_ORDERS:
		var NewOrder = order_instance.instantiate()
		add_child(NewOrder)
