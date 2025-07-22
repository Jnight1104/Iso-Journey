extends Control

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	resume()


func _process(_delta):
	# Pauses/unpauses the game on user input based on whether it is already paused or not
	if Input.is_action_just_pressed("ui_escape"):
		if global.paused == false:
			pause()
		else:
			resume()


# Pauses the game on pause button pressed
func _pause_button_pressed():
	pause()


# Function for pausing the game
func pause():
	global.paused = true
	$Pause.hide()
	$ColorRect.show()
	$Label.show()
	$Resume.show()
	$Quit.show()


# Function for resuming the game
func resume():
	global.paused = false
	$Resume.hide()
	$Quit.hide()
	$Label.hide()
	$ColorRect.hide()
	$Pause.show()


# Resumes the game on resume button pressed
func _resume_button_pressed():
	resume()


# Quits the game on quit button pressed
func _quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")


func _win():
	self.hide()
