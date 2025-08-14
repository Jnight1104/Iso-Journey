extends Control

@onready var global = get_node("/root/Global")
const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)


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


func _pause_mouse_entered():
	$Pause.set_modulate(DARKENED)


func _pause_mouse_exited():
	$Pause.set_modulate(TRANSPARENT)


# Function for pausing the game
func pause():
	global.paused = true
	$Pause.hide()
	$ColorRect.show()
	$Label.show()
	$Resume.show()
	$Quit.show()
	$Text.show()
	$Toggle.show()
	$Toggle2.show()
	$Toggle3.show()

# Function for resuming the game
func resume():
	global.paused = false
	$Resume.hide()
	$Quit.hide()
	$Label.hide()
	$ColorRect.hide()
	$Text.hide()
	$Toggle.hide()
	$Toggle2.hide()
	$Toggle3.hide()
	$Pause.show()


# Resumes the game on resume button pressed
func _resume_button_pressed():
	resume()


# Quits the game on quit button pressed
func _quit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")


func _win():
	self.hide()


func _resume_mouse_entered():
	$Resume.set_modulate(DARKENED)


func _resume_mouse_exited():
	$Resume.set_modulate(TRANSPARENT)


func _quit_mouse_entered():
	$Quit.set_modulate(DARKENED)


func _quit_mouse_exited():
	$Quit.set_modulate(TRANSPARENT)
