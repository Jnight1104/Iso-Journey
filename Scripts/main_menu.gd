extends Control

@onready var global = get_node("/root/Global")
const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)
const BASE_POSITION : Vector2 = Vector2(575.4, 342.5)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const OPTIONS: String = "opt"
const PLAY: String = "ply"
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
var action: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	var file = ResourceLoader.load("res://Scripts/save.tres")
	$Play.set_modulate(TRANSPARENT)
	$Options.set_modulate(TRANSPARENT)
	$Quit.set_modulate(TRANSPARENT)	
	$Fade.show()
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


# Navigation to the level select screen when play is pressed
func _play_button_pressed():
	action = PLAY
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)
	

# Saves key data and quits the game when quit is pressed
func _quit_button_pressed():
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
	get_tree().quit()


func _options_button_pressed():
	action = OPTIONS
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _play_mouse_entered():
	$Play.set_modulate(DARKENED)


func _play_mouse_exited():
	$Play.set_modulate(TRANSPARENT)


func _options_mouse_entered():
	$Options.set_modulate(DARKENED)


func _options_mouse_exited():
	$Options.set_modulate(TRANSPARENT)


func _quit_mouse_entered():
	$Quit.set_modulate(DARKENED)


func _quit_mouse_exited():
	$Quit.set_modulate(TRANSPARENT)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		$Fade.hide()
	elif action == OPTIONS:
		get_tree().change_scene_to_file("res://Scenes/Options_menu.tscn")
	elif action == PLAY:
		get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
		
