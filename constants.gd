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
		"points_per_plant": 10
	},
	"Rose": {
		"name": "Rose",
		"sprite_positions": {"x": 6, "y": 0},
		"key": KEY_2,
		"points_per_plant": 17
	},
	"Cucumber": {
		"name": "Cucumber",
		"sprite_positions": {"x": 0, "y": 1},
		"key": KEY_3,
		"points_per_plant": 22
	},
	"Tulip": {
		"name": "Tulip",
		"sprite_positions": {"x": 6, "y": 1},
		"key": KEY_4,
		"points_per_plant": 15
	},	
	"Tomato": {
		"name": "Tomato",
		"sprite_positions": {"x": 0, "y": 2},
		"key": KEY_5,
		"points_per_plant": 11
	},	
	"Melon": {
		"name": "Melon",
		"sprite_positions": {"x": 6, "y": 2},
		"key": KEY_6,
		"points_per_plant": 16
	},	
	"Eggplant": {
		"name": "Eggplant",
		"sprite_positions": {"x": 0, "y": 3},
		"key": KEY_7,
		"points_per_plant": 12
	},	
	"Lemon": {
		"name": "Lemon",
		"sprite_positions": {"x": 6, "y": 3},
		"key": KEY_8,
		"points_per_plant": 30
	},	

}
