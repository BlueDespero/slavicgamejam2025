extends Node

var score: int = 0
var storage: Dictionary = {}

func _ready() -> void:
	initialize_storage()
	EventBus.set_storage.connect(_set_storage)
	
func initialize_storage() -> void:
	for plant in Constants.plants.keys():
		storage[plant] = 0

func _set_storage(new_storage: Dictionary) -> void:
	storage = new_storage

func _on_timer_timeout() -> void:
	for plant_key in Constants.plants.keys():
		storage[plant_key] += 1
		EventBus.storage_updated.emit(plant_key, storage)
