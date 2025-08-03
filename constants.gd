extends Node

const MAX_NUMBER_ORDERS: int = 5
const MAX_NUMBER_OF_INGREDIENCE: int = 4
const MAX_INGREDIENCE_PER_ORDER: int = 4
const CELL_SIZE: int = 64
const FAILED_ORDER_PENALTY_DISCONT = 0.2

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

var plant_interactions = {
	"Turnip": {
		"Rose": 1, "Cucumber": -1, "Tulip": 2, "Tomato": -2, "Melon": 3, "Eggplant": -3, "Lemon": 0
	},
	"Rose": {
		"Turnip": 1, "Cucumber": 1, "Tulip": 2, "Tomato": 3, "Melon": -1, "Eggplant": -2, "Lemon": -3
	},
	"Cucumber": {
		"Turnip": -1, "Rose": 1, "Tulip": 3, "Tomato": 2, "Melon": 0, "Eggplant": 2, "Lemon": 3
	},
	"Tulip": {
		"Turnip": 2, "Rose": 2, "Cucumber": 3, "Tomato": 0, "Melon": 0, "Eggplant": 0, "Lemon": 0
	},
	"Tomato": {
		"Turnip": -2, "Rose": 3, "Cucumber": 2, "Tulip": 0, "Melon": 1, "Eggplant": -1, "Lemon": -2
	},
	"Melon": {
		"Turnip": 3, "Rose": -1, "Cucumber": 0, "Tulip": 0, "Tomato": 1, "Eggplant": 2, "Lemon": 1
	},
	"Eggplant": {
		"Turnip": -3, "Rose": -2, "Cucumber": 2, "Tulip": 0, "Tomato": -1, "Melon": 2, "Lemon": -3
	},
	"Lemon": {
		"Turnip": 0, "Rose": -3, "Cucumber": 3, "Tulip": 0, "Tomato": -2, "Melon": 1, "Eggplant": -3
	}
	}
