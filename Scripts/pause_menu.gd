extends Control

@onready var global = get_node("/root/Global")
@onready var fast_mode_toggle: Node = $Pause_screen_ui/Fast_mode_button/Toggle
@onready var music_toggle: Node = $Pause_screen_ui/Music_button/Toggle2
@onready var sounds_toggle: Node = $Pause_screen_ui/Sounds_button/Toggle3
@onready var fast_mode_button: Node = $Pause_screen_ui/Fast_mode_button
@onready var music_button: Node = $Pause_screen_ui/Music_button
@onready var sounds_button: Node = $Pause_screen_ui/Sounds_button
const NORMAL: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const TRANSPARENT: Color = Color(1, 1, 1, 0.5)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const TRANSPARENCY_SCALE: float = 10.0
const MAX_REPEAT_RANGE: int = 101
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const START_FRAME: int = 0
const END_FRAME: int = 11
var transparency: Color = Color(1, 1, 1, 0)
var transparency_target: float = 0.0
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
var fading: bool = true
var quitting: bool = false
signal music_play
signal music_stop


# Called when the node enters the scene tree for the first time.
func _ready():
	music_play.connect(get_node("/root/MusicNode").music_on)
	music_stop.connect(get_node("/root/MusicNode").music_off)
	quitting = false
	$Fade.show()
	fading = true
	resume()
	global.paused = true
	$Pause_screen_ui.set_modulate(transparency)
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)
	# Sets toggle button visual modes based on whether their representing values are true or false
	if not global.fast_mode:
		fast_mode_toggle.set_frame(END_FRAME)
	else:
		fast_mode_toggle.set_frame(START_FRAME)
	if not global.music_on:
		music_toggle.set_frame(END_FRAME)
	else:
		music_toggle.set_frame(START_FRAME)
	if not global.sound_on:
		sounds_toggle.set_frame(END_FRAME)
	else:
		sounds_toggle.set_frame(START_FRAME)


func _process(delta):
	if not fading:
		# Pauses/unpauses the game on user input based on whether it is already paused or not
		if Input.is_action_just_pressed("ui_escape"):
			if global.paused == false:
				pause()
			else:
				save_data()
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
	save_data()
	resume()


# Quits the game on quit button pressed
func _quit_button_pressed():
	fading = true
	save_data()
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


func _fast_mode_pressed():
	if not global.fast_mode:
		fast_mode_toggle.play_backwards()
		global.fast_mode = true
	else:
		fast_mode_toggle.play()
		global.fast_mode = false
	save_data()


func _fast_mode_mouse_entered():
	fast_mode_button.set_modulate(DARKENED)


func _fast_mode_mouse_exited():
	fast_mode_button.set_modulate(NORMAL)


func _music_pressed():
	if not global.music_on:
		music_toggle.play_backwards()
		global.music_on = true
		music_play.emit()
	else:
		music_toggle.play()
		global.music_on = false
		music_stop.emit()
	save_data()


func _music_mouse_entered():
	music_button.set_modulate(DARKENED)


func _music_mouse_exited():
	music_button.set_modulate(NORMAL)


func _sounds_pressed():
	if not global.sound_on:
		sounds_toggle.play_backwards()
		global.sound_on = true
	else:
		sounds_toggle.play()
		global.sound_on = false
	save_data()


func _sounds_mouse_entered():
	sounds_button.set_modulate(DARKENED)


func _sounds_mouse_exited():
	sounds_button.set_modulate(NORMAL)


func save_data():
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
