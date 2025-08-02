extends Node

const MAX_NUMBER_ORDERS: int = 6
const MAX_NUMBER_OF_INGREDIENCE: int = 4
const MAX_INGREDIENCE_PER_ORDER: int = 4
const CELL_SIZE: int = 64
var plants = {
	"Turnip": {
		"name": "Turnip",
		"sprite_positions": {"x": 0, "y": 0},
		"key": KEY_1,
	},
	"Rose": {
		"name": "Rose",
		"sprite_positions": {"x": 6, "y": 0},
		"key": KEY_2,
	},
	"Cucumber": {
		"name": "Cucumber",
		"sprite_positions": {"x": 0, "y": 1},
		"key": KEY_3,
	},
	"Tulip": {
		"name": "Tulip",
		"sprite_positions": {"x": 6, "y": 1},
		"key": KEY_4,
	},	
}
