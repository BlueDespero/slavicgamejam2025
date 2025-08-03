extends RichTextLabel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_text(str($GameOverTimer.get_time_left()).pad_decimals(1))


func _on_start_game_button_pressed() -> void:
	$GameOverTimer.start()
