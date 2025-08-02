extends ColorRect

func _process(delta: float) -> void:
	size.x = $Score.size.x
	size.y = $Score.size.y

func _ready() -> void:
	size.x = $Score.size.x
	size.y = $Score.size.y
	EventBus.change_score.connect(_set_score_text)
	
func _set_score_text(delta: int) -> void:
	$Score.text = "Score: %d" % (int($Score.text) + delta)
