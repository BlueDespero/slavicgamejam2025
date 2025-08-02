# map.gd
extends Node2D

@onready var tile_map = $Terrain
@onready var player = $Player

func _ready():
	player.tile_map = tile_map
