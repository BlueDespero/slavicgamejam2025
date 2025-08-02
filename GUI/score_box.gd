extends ColorRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var score: Label = get_child(0)
	size.x = score.size.x
	size.y = score.size.y
