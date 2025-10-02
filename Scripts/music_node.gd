extends Node


# Plays the music when the game starts
func _ready():
	$Music.play()


# Replays the music when it finishes
func _music_finished():
	$Music.play()
