extends Node

const PLAYER_STARTING_POS_Y: float = 0.5
var level: int = 0
var player_pos: Vector3 = Vector3(0, PLAYER_STARTING_POS_Y, 0)
var paused: bool = true
var objectives_reached: int = 0
var undoing: bool = false
var redoing: bool = false
var fast_mode: bool = false
var music_on: bool = true
var sound_on: bool = true
var levels_unlocked: int = 1


func _ready() -> void:
	var file = ResourceLoader.load("res://Scripts/save.tres")
	if file:
		fast_mode = file.fast_mode
		music_on = file.music_on
		sound_on = file.sound_on
		levels_unlocked = file.levels_unlocked
