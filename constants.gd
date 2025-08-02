extends Node

const MAX_NUMBER_ORDERS: int = 6
const MAX_NUMBER_OF_INGREDIENCE: int = 4
const MAX_INGREDIENCE_PER_ORDER: int = 4
const CELL_SIZE: int = 64
var plants = [
	{
		"name": "Turnip (1)",
		"sprite_positions": {"x": 0, "y": 0},
		"key": KEY_1,
	},
	{
		"name": "Rose (2)",
		"sprite_positions": {"x": 6, "y": 0},
		"key": KEY_2,
	},
	{
		"name": "Cucumber (3)",
		"sprite_positions": {"x": 0, "y": 1},
		"key": KEY_3,
	},
	{
		"name": "Tulip (4)",
		"sprite_positions": {"x": 6, "y": 1},
		"key": KEY_4,
	},	
]
