extends ColorRect

var score: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score = get_child(0)
	size.x = score.size.x
	size.y = score.size.y
	EventBus.change_score.connect(_set_score_text)
	
func _set_score_text(delta: int) -> void:
	score.text = "Score: %d" % (int(score.text) + delta)
	size.x = score.size.x
	size.y = score.size.y
