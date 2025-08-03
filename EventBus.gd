extends Node

signal plant_selected(plant_cls)
signal storage_updated(key: String, storage: Dictionary)
signal set_storage(storage: Dictionary)
signal update_storage(key: String, delta: int)
signal change_score(score_delta: int)
signal harvest_crops(tile_position: Vector2i)
signal start_game_button_pressed()
signal game_over()
signal check_orders(storage:Dictionary)
