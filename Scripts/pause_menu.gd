extends Control

@onready var global = get_node("/root/Global")
const NORMAL: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const TRANSPARENT: Color = Color(1, 1, 1, 0.5)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const TRANSPARENCY_SCALE: float = 10.0
const MAX_REPEAT_RANGE: int = 101
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
var transparency: Color = Color(1, 1, 1, 0)
var transparency_target: float = 0.0
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
var fading: bool = true
var quitting: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	quitting = false
	$Fade.show()
	fading = true
	resume()
	global.paused = true
	$Pause_screen_ui.set_modulate(transparency)
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)


func _process(delta):
	if not fading:
		# Pauses/unpauses the game on user input based on whether it is already paused or not
		if Input.is_action_just_pressed("ui_escape"):
			if global.paused == false:
				pause()
			else:
				resume()
	transparency.a = lerp(transparency.a, transparency_target, TRANSPARENCY_SCALE * delta)
	$Pause_screen_ui.set_modulate(transparency)
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


# Pauses the game on pause button pressed
func _pause_button_pressed():
	pause()


func _pause_mouse_entered():
	$Pause.set_modulate(DARKENED)


func _pause_mouse_exited():
	$Pause.set_modulate(NORMAL)


# Function for pausing the game
func pause():
	global.paused = true
	transparency_target = FADE_IN
	$Pause.hide()
	$Undo.hide()
	$Redo.hide()
	$Restart.hide()
	$Pause_screen_ui/Resume.set_disabled(false)
	$Pause_screen_ui/Quit.set_disabled(false)


# Function for resuming the game
func resume():
	global.paused = false
	transparency_target = FADE_OUT
	$Pause_screen_ui/Resume.set_disabled(true)
	$Pause_screen_ui/Quit.set_disabled(true)
	$Pause.show()
	$Undo.show()
	$Redo.show()
	$Restart.show()


# Resumes the game on resume button pressed
func _resume_button_pressed():
	resume()


# Quits the game on quit button pressed
func _quit_button_pressed():
	fading = true
	$Fade.show()
	global.paused = true
	global.undoing = false
	global.redoing = false
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)
	quitting = true


func _win():
	self.hide()


func _resume_mouse_entered():
	$Pause_screen_ui/Resume.set_modulate(DARKENED)


func _resume_mouse_exited():
	$Pause_screen_ui/Resume.set_modulate(NORMAL)


func _quit_mouse_entered():
	$Pause_screen_ui/Quit.set_modulate(DARKENED)


func _quit_mouse_exited():
	$Pause_screen_ui/Quit.set_modulate(NORMAL)


func _undo_button_pressed():
	global.undoing = true


func _undo_mouse_entered():
	$Undo.set_modulate(TRANSPARENT)
	

func _undo_mouse_exited():
	$Undo.set_modulate(NORMAL)


func _redo_button_pressed():
	global.redoing = true


func _redo_mouse_entered():
	$Redo.set_modulate(TRANSPARENT)


func _redo_mouse_exited():
	$Redo.set_modulate(NORMAL)


func _restart_button_pressed():
	fading = true
	$Fade.show()
	global.paused = true
	global.undoing = false
	global.redoing = false
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _restart_mouse_entered():
	$Restart.set_modulate(TRANSPARENT)


func _restart_mouse_exited():
	$Restart.set_modulate(NORMAL)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		global.paused = false
		fading = false
		$Fade.hide()
	elif quitting == true:
		get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
	else:
		get_tree().reload_current_scene()
