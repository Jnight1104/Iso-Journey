extends Control

@onready var global = get_node("/root/Global")
@onready var fade_screen: Node = $Fade
@onready var fade_timer: Node = $Fade_timer
@onready var play: Node = $Play
@onready var options: Node = $Options
@onready var quit: Node = $Quit
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
func _ready() -> void:
	play.set_modulate(TRANSPARENT)
	options.set_modulate(TRANSPARENT)
	quit.set_modulate(TRANSPARENT)
	# Activates fade in sequence on scene entry
	fade_screen.show()
	fade_screen.set_modulate(fade)
	fade_target = FADE_OUT
	fade_timer.start(FADE_TIME)


func _process(delta) -> void:
	# Smoothly fades the black screen when needed
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	fade_screen.set_modulate(fade)


# Navigation to the level select screen when play is pressed
func _play_button_pressed():
	action = PLAY
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)
	

# Saves key data and quits the game when quit is pressed
func _quit_button_pressed():
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
	get_tree().quit()


# Navigates to options menu when pressed
func _options_button_pressed():
	action = OPTIONS
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _play_mouse_entered():
	play.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _play_mouse_exited():
	play.set_modulate(TRANSPARENT)


# Darkens button when mouse is hovering it
func _options_mouse_entered():
	options.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _options_mouse_exited():
	options.set_modulate(TRANSPARENT)


# Darkens button when mouse is hovering it
func _quit_mouse_entered():
	quit.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _quit_mouse_exited():
	quit.set_modulate(TRANSPARENT)


func _fade_timer_done():
	# Completes fade out sequence on fade out
	if fade_target == FADE_OUT:
		fade_screen.hide()
	# Switches scene based on button pressed
	elif action == OPTIONS:
		get_tree().change_scene_to_file("res://Scenes/Options_menu.tscn")
	elif action == PLAY:
		get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
		
