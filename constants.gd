extends Node

const MAX_NUMBER_ORDERS: int = 6
const MAX_NUMBER_OF_INGREDIENCE: int = 4
const MAX_INGREDIENCE_PER_ORDER: int = 4
const CELL_SIZE: int = 64
var plants = [
	{
		"name": "Turnip",
		"sprite_positions": {"x": 0, "y": 0},
		"key": KEY_1,
		"class_name": "Turnip",
	},
	{
		"name": "Rose",
		"sprite_positions": {"x": 6, "y": 0},
		"key": KEY_2,
		"class_name": "Rose",
	},
	{
		"name": "Cucumber",
		"sprite_positions": {"x": 0, "y": 1},
		"key": KEY_3,
		"class_name": "Cucumber",
	},
	{
		"name": "Tulip",
		"sprite_positions": {"x": 6, "y": 1},
		"key": KEY_4,
		"class_name": "Tulip",
	},	
]
