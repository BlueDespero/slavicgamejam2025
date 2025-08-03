extends RichTextLabel

var score: int = 0

func _ready():
	EventBus.change_score.connect(_set_game_over_score)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_text("Time: %s" % str($GameOverTimer.get_time_left()).pad_decimals(1))


func _on_start_game_button_pressed() -> void:
	$GameOverTimer.start()

func _set_game_over_score(delta):
	score += delta

func _on_game_over_timer_timeout() -> void:
	$GameOverTimer.stop()
	EventBus.game_over.emit()
	var score_hud = get_parent().get_node("ScoreSummaryHUD")
	var score_label = score_hud.get_node("Score")
	score_label.text = "%d pts" % score
	score_hud.visible = true
