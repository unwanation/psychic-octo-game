extends Node

const TILE_SIZE: int = 64
const TILE_SIZE_SQUARED: int = TILE_SIZE ** 2
const PLAYER_SPEED: int = 500
const CAMERA_ANGLE: int = 45
const INFINITY: int = 9223372036854775807

const SCENES: Dictionary = {
	"MENU": "res://scenes/Menu.tscn",
	"LOBBY": "res://scenes/Lobby.tscn",
	"GAME": "res://scenes/Game.tscn",
}

const ACTIONS: Dictionary = {
	"UP": "up",
	"DOWN": "down",
	"LEFT": "left",
	"RIGHT": "right",
	"SHOOT": "shoot",
	"INTERACT": "interact",
}

const CAMERA_ANGLES: Dictionary = {
	"UP_LEFT": -(180 - CAMERA_ANGLE),
	"UP_RIGHT": -(90 - CAMERA_ANGLE),
	"DOWN_RIGHT": 90 - CAMERA_ANGLE,
	"DOWN_LEFT": 180 - CAMERA_ANGLE,
}

enum COLLISION_LAYERS {
	NONE,
	WORLD,
	CHARACTER,
	PLAYER,
	BULLETS,
	BOOSTS,
	INTERACTABLE,
}
