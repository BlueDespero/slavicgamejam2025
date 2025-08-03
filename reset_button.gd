extends Button

func _on_pressed() -> void:
	GameData.initialize_storage()
	get_tree().reload_current_scene()
