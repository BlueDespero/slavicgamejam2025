extends Node

var score: int = 0
var storage: Dictionary = {}

func _ready() -> void:
	initialize_storage()
	
func initialize_storage() -> void:
	for plant in Constants.plants.keys():
		storage[plant] = 0

func _on_timer_timeout() -> void:
	var plant_key = Constants.plants.keys().pick_random()
	storage[plant_key] += 1
	EventBus.storage_updated.emit(plant_key, storage[plant_key])
