extends Node2D

var plant_scene = preload("res://plants/plant.tscn")
var wheat_scene = preload("res://plants/WheatPlant.tscn")
var tomato_scene = preload("res://plants/TomatoPlant.tscn")

func _draw():
	for x in range(0, 1152, 64):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, 64):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(0, 0, 0), 2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_debug_plants()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func init_debug_plants() -> void:
	var plants = [
		[plant_scene.instantiate(), Vector2(300, 200)],
		[wheat_scene.instantiate(), Vector2(500, 200)],
		[tomato_scene.instantiate(), Vector2(700, 200)],
	]
	for plant in plants:
		plant[0].position = plant[1]
		add_child(plant[0])
	
	# Test growth every 2 seconds
	var timer = Timer.new()
	timer.wait_time = 2.0
	timer.timeout.connect(func(): 
		for plant in plants:
			plant[0].grow()
	)
	add_child(timer)
	timer.start()

	
