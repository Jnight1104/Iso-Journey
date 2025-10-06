extends Node

@onready var global = get_node("/root/Global")


# Plays the music when the game starts
func _ready():
	if global.music_on:
		$Music.play()


# Replays the music when it finishes
func _music_finished():
	$Music.play()


# Turns on the music when called
func music_on():
	$Music.play()


# Turns off the music when called
func music_off():
	$Music.stop()
