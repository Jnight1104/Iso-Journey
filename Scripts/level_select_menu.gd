extends Control

@onready var global = get_node("/root/Global")
const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.set_modulate(TRANSPARENT)
	$Fade.show()
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


# Begins level 1 when it is pressed
func _level_1_pressed():
	global.level = 1
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


# Begins level 2 when it is pressed
func _level_2_pressed():
	global.level = 2
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_3_pressed():
	global.level = 3
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


# Navigation back to main menu when back is pressed
func _back_button_pressed():
	global.level = 0
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _back_mouse_entered():
	$Back.set_modulate(DARKENED)


func _back_mouse_exited():
	$Back.set_modulate(TRANSPARENT)


func _level_1_mouse_entered():
	$Level_1.set_modulate(DARKENED)


func _level_1_mouse_exited():
	$Level_1.set_modulate(TRANSPARENT)


func _level_2_mouse_entered():
	$Level_2.set_modulate(DARKENED)


func _level_2_mouse_exited():
	$Level_2.set_modulate(TRANSPARENT)


func _level_3_mouse_entered():
	$Level_3.set_modulate(DARKENED)


func _level_3_mouse_exited():
	$Level_3.set_modulate(TRANSPARENT)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		$Fade.hide()
	else:
		if global.level == 0:
			get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
		elif global.level == 1:
			get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")
		elif global.level == 2:
			get_tree().change_scene_to_file("res://Scenes/Level_2.tscn")
		elif global.level == 3:
			get_tree().change_scene_to_file("res://Scenes/Level_3.tscn")
			
