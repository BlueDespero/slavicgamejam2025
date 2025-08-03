extends ColorRect

var score: int

func _process(delta: float) -> void:
	size.x = $Score.size.x
	size.y = $Score.size.y

func _ready() -> void:
	size.x = $Score.size.x
	size.y = $Score.size.y
	score = 0
	EventBus.change_score.connect(_set_score_text)
	
func _set_score_text(delta: int) -> void:
	score += delta
	$Score.text = "Score: %d" % (score)
