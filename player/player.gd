extends Area2D

@export var speed = 400;
@export var tile_map: TileMapLayer
var screen_size
var target_position: Vector2

func _ready() -> void:
	if tile_map == null:
		print_rich("[color=red]ERROR: TileMap not assigned to the player script.[/color]")
	screen_size = get_viewport_rect().size
	target_position = global_position

func _input(event):
	if (
		event is InputEventMouseButton 
		and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed()
	):
		var mouse_pos = get_global_mouse_position()
		var clicked_tile_coords = tile_map.local_to_map(mouse_pos)
		print("Tile coordinates: ", clicked_tile_coords)
		target_position = tile_map.map_to_local(clicked_tile_coords)
		
func _physics_process(delta):
	var direction = global_position.direction_to(target_position)
	var velocity = Vector2.ZERO
	if global_position.distance_to(target_position) > 5:
		velocity = direction.normalized() * speed
	animate_movement(velocity)
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func animate_movement(velocity):
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			$AnimatedSprite2D.animation = "walk_right"
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "walk_left"
	else:
		if velocity.y > 0:
			$AnimatedSprite2D.animation = "walk_down"
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_up"

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
