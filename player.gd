extends Area2D

@export var speed = 400;
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "walk_right"
	if velocity.x < 0:
		$AnimatedSprite2D.animation = "walk_left"
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "walk_down"
	if velocity.y < 0:
		$AnimatedSprite2D.animation = "walk_up"
	
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
