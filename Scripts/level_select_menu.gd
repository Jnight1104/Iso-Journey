extends Control

@onready var global = get_node("/root/Global")
const NORMAL: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const MORE_DARKENED: Color = Color(0.5, 0.5, 0.5, 1)
const TRANSPARENT: Color = Color(1, 1, 1, 0.5)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const ONE: int = 1
const TWO: int = 2
const THREE: int = 3
const FOUR: int = 4
const FIVE: int = 5
const SIX: int = 6
const SEVEN: int = 7
const EIGHT: int = 8
const NINE: int = 9
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Reset_tab.hide()
	$Back.set_modulate(NORMAL)
	$Fade.show()
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)
	if global.levels_unlocked < TWO:
		$Level_2.hide()
	if global.levels_unlocked < THREE:
		$Level_3.hide()
	if global.levels_unlocked < FOUR:
		$Level_4.hide()
	if global.levels_unlocked < FIVE:
		$Level_5.hide()
	if global.levels_unlocked < SIX:
		$Level_6.hide()
	if global.levels_unlocked < SEVEN:
		$Level_7.hide()
	if global.levels_unlocked < EIGHT:
		$Level_8.hide()
	if global.levels_unlocked < NINE:
		$Level_9.hide()


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


# Begins level 1 when it is pressed
func _level_1_pressed():
	global.level = ONE
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


# Begins level 2 when it is pressed
func _level_2_pressed():
	global.level = TWO
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_3_pressed():
	global.level = THREE
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_4_pressed():
	global.level = FOUR
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_5_pressed():
	global.level = FIVE
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
	$Back.set_modulate(NORMAL)


func _level_1_mouse_entered():
	$Level_1.set_modulate(DARKENED)


func _level_1_mouse_exited():
	$Level_1.set_modulate(NORMAL)


func _level_2_mouse_entered():
	$Level_2.set_modulate(DARKENED)


func _level_2_mouse_exited():
	$Level_2.set_modulate(NORMAL)


func _level_3_mouse_entered():
	$Level_3.set_modulate(DARKENED)


func _level_3_mouse_exited():
	$Level_3.set_modulate(NORMAL)


func _level_4_mouse_entered():
	$Level_4.set_modulate(DARKENED)


func _level_4_mouse_exited():
	$Level_4.set_modulate(NORMAL)


func _level_5_mouse_entered():
	$Level_5.set_modulate(DARKENED)


func _level_5_mouse_exited():
	$Level_5.set_modulate(NORMAL)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		$Fade.hide()
	else:
		if global.level == 0:
			get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
		elif global.level == ONE:
			get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")
		elif global.level == TWO:
			get_tree().change_scene_to_file("res://Scenes/Level_2.tscn")
		elif global.level == THREE:
			get_tree().change_scene_to_file("res://Scenes/Level_3.tscn")
		elif global.level == FOUR:
			get_tree().change_scene_to_file("res://Scenes/Level_4.tscn")
		elif global.level == FIVE:
			get_tree().change_scene_to_file("res://Scenes/Level_5.tscn")
		elif global.level == SIX:
			get_tree().change_scene_to_file("res://Scenes/Level_6.tscn")
		elif global.level == SEVEN:
			get_tree().change_scene_to_file("res://Scenes/Level_7.tscn")
		elif global.level == EIGHT:
			get_tree().change_scene_to_file("res://Scenes/Level_8.tscn")
		elif global.level == NINE:
			get_tree().change_scene_to_file("res://Scenes/Level_9.tscn")


func _reset_progress_pressed():
	$Reset_tab.show()


func _reset_progress_mouse_entered():
	$Reset_progress.set_modulate(TRANSPARENT)


func _reset_progress_mouse_exited():
	$Reset_progress.set_modulate(NORMAL)


func _confirm_pressed():
	global.levels_unlocked = ONE
	$Level_2.hide()
	$Level_3.hide()
	$Level_4.hide()
	$Level_5.hide()
	$Level_6.hide()
	$Level_7.hide()
	$Level_8.hide()
	$Level_9.hide()
	$Reset_tab.hide()


func _confirm_mouse_entered():
	$Reset_tab/Confirm.set_modulate(DARKENED)


func _confirm_mouse_exited():
	$Reset_tab/Confirm.set_modulate(NORMAL)


func _backout_pressed():
	$Reset_tab.hide()


func _backout_mouse_entered():
	$Reset_tab/Backout.set_modulate(DARKENED)


func _backout_mouse_exited():
	$Reset_tab/Backout.set_modulate(NORMAL)


func _level_6_pressed():
	global.level = SIX
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_6_mouse_entered():
	$Level_6.set_modulate(DARKENED)


func _level_6_mouse_exited():
	$Level_6.set_modulate(NORMAL)


func _level_7_pressed():
	global.level = SEVEN
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_7_mouse_entered():
	$Level_7.set_modulate(DARKENED)


func _on_level_7_mouse_exited():
	$Level_7.set_modulate(NORMAL)


func _level_8_pressed():
	global.level = EIGHT
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_8_mouse_entered():
	$Level_8.set_modulate(DARKENED)


func _level_8_mouse_exited():
	$Level_8.set_modulate(NORMAL)


func _level_9_pressed():
	global.level = NINE
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _level_9_mouse_entered():
	$Level_9.set_modulate(DARKENED)


func _level_9_mouse_exited():
	$Level_9.set_modulate(NORMAL)
