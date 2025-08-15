extends Control

@onready var global = get_node("/root/Global")
const TRANSPARENT: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const TRANSPARENCY_SCALE: float = 10.0
var transparency: Color = Color(1, 1, 1, 0)
var transparency_target: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Pause_screen_ui.set_modulate(transparency)
	resume()


func _process(delta):
	# Pauses/unpauses the game on user input based on whether it is already paused or not
	if Input.is_action_just_pressed("ui_escape"):
		if global.paused == false:
			pause()
		else:
			resume()
	transparency.a = lerp(transparency.a, transparency_target, TRANSPARENCY_SCALE * delta)
	$Pause_screen_ui.set_modulate(transparency)


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
	transparency_target = FADE_IN
	$Pause.hide()
	$Pause_screen_ui/Resume.set_disabled(false)
	$Pause_screen_ui/Quit.set_disabled(false)


# Function for resuming the game
func resume():
	global.paused = false
	transparency_target = FADE_OUT
	$Pause_screen_ui/Resume.set_disabled(true)
	$Pause_screen_ui/Quit.set_disabled(true)
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
	$Pause_screen_ui/Resume.set_modulate(DARKENED)


func _resume_mouse_exited():
	$Pause_screen_ui/Resume.set_modulate(TRANSPARENT)


func _quit_mouse_entered():
	$Pause_screen_ui/Quit.set_modulate(DARKENED)


func _quit_mouse_exited():
	$Pause_screen_ui/Quit.set_modulate(TRANSPARENT)
