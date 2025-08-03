extends Node2D

func _draw():
	for x in range(0, 1152, 64):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, 64):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(0, 0, 0), 2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_game_button_pressed() -> void:
	EventBus.start_game_button_pressed.emit()
