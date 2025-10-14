extends Node

@onready var global = get_node("/root/Global")
@onready var music: Node = $Music


# Plays the music when the game starts
func _ready() -> void:
	if global.music_on:
		music.play()


# Replays the music when it finishes
func _music_finished():
	music.play()


# Turns on the music when called
func music_on():
	music.play()


# Turns off the music when called
func music_off():
	music.stop()
