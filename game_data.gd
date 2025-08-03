extends Node

var score: int = 0
var storage: Dictionary = {}

func _process(delta: float) -> void:
	EventBus.check_orders.emit(storage)

func _ready() -> void:
	initialize_storage()
	EventBus.set_storage.connect(_set_storage)
	EventBus.update_storage.connect(_update_storage)
	
func initialize_storage() -> void:
	for plant in Constants.plants.keys():
		storage[plant] = 0

func _set_storage(new_storage: Dictionary) -> void:
	if new_storage != storage:	
		storage = new_storage
	for key in storage.keys():
		EventBus.storage_updated.emit(key, storage)
		
		

func _update_storage(key: String, delta: int) -> void:
	if key in storage:
		storage[key] += delta
	else:
		storage[key] = delta
	EventBus.storage_updated.emit(key, storage)
