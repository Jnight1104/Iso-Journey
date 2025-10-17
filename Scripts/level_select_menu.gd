extends Control

@onready var global = get_node("/root/Global")
@onready var reset_tab: Node = $Reset_tab
@onready var reset_confirm: Node = $Reset_tab/Confirm
@onready var reset_backout: Node = $Reset_tab/Backout
@onready var reset_progress: Node = $Reset_progress
@onready var back: Node = $Back
@onready var fade_screen: Node = $Fade
@onready var fade_timer: Node = $Fade_timer
@onready var level_1: Node = $Level_1
@onready var level_2: Node = $Level_2
@onready var level_3: Node = $Level_3
@onready var level_4: Node = $Level_4
@onready var level_5: Node = $Level_5
@onready var level_6: Node = $Level_6
@onready var level_7: Node = $Level_7
@onready var level_8: Node = $Level_8
@onready var level_9: Node = $Level_9
@onready var level_10: Node = $Level_10
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
const TEN: int = 10
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_tab.hide()
	back.set_modulate(NORMAL)
	# Activates fade in sequence on scene entry
	fade_screen.show()
	fade_screen.set_modulate(fade)
	fade_target = FADE_OUT
	fade_timer.start(FADE_TIME)
	# Hides levels that are not unlocked
	if global.levels_unlocked < TWO:
		level_2.hide()
	if global.levels_unlocked < THREE:
		level_3.hide()
	if global.levels_unlocked < FOUR:
		level_4.hide()
	if global.levels_unlocked < FIVE:
		level_5.hide()
	if global.levels_unlocked < SIX:
		level_6.hide()
	if global.levels_unlocked < SEVEN:
		level_7.hide()
	if global.levels_unlocked < EIGHT:
		level_8.hide()
	if global.levels_unlocked < NINE:
		level_9.hide()
	if global.levels_unlocked < TEN:
		level_10.hide()


func _process(delta) -> void:
	# Smoothly fades the black screen when needed
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	fade_screen.set_modulate(fade)


# Begins level 1 when it is pressed
func _level_1_pressed():
	global.level = ONE
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Begins level 2 when it is pressed
func _level_2_pressed():
	global.level = TWO
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Begins level 3 when it is pressed
func _level_3_pressed():
	global.level = THREE
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Begins level 4 when it is pressed
func _level_4_pressed():
	global.level = FOUR
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Begins level 5 when it is pressed
func _level_5_pressed():
	global.level = FIVE
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Navigation back to main menu when back is pressed
func _back_button_pressed():
	global.level = 0
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _back_mouse_entered():
	back.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _back_mouse_exited():
	back.set_modulate(NORMAL)


# Darkens button when mouse is hovering it
func _level_1_mouse_entered():
	level_1.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_1_mouse_exited():
	level_1.set_modulate(NORMAL)


# Darkens button when mouse is hovering it
func _level_2_mouse_entered():
	level_2.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_2_mouse_exited():
	level_2.set_modulate(NORMAL)


# Darkens button when mouse is hovering it
func _level_3_mouse_entered():
	level_3.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_3_mouse_exited():
	level_3.set_modulate(NORMAL)


# Darkens button when mouse is hovering it
func _level_4_mouse_entered():
	level_4.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_4_mouse_exited():
	level_4.set_modulate(NORMAL)


# Darkens button when mouse is hovering it
func _level_5_mouse_entered():
	level_5.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_5_mouse_exited():
	level_5.set_modulate(NORMAL)


func _fade_timer_done():
	# Ends fade out sequence if fading out
	if fade_target == FADE_OUT:
		fade_screen.hide()
	# Changes scene based on level chosen
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
		elif global.level == TEN:
			get_tree().change_scene_to_file("res://Scenes/Level_10.tscn")


# Opens reset tab when pressed
func _reset_progress_pressed():
	reset_tab.show()


# Makes button see-through when mouse it hovering it
func _reset_progress_mouse_entered():
	reset_progress.set_modulate(TRANSPARENT)


# Makes button solid when mouse moves off it
func _reset_progress_mouse_exited():
	reset_progress.set_modulate(NORMAL)


# Resets progress when pressed
func _confirm_pressed():
	global.levels_unlocked = ONE
	# Hides levels above 1
	level_2.hide()
	level_3.hide()
	level_4.hide()
	level_5.hide()
	level_6.hide()
	level_7.hide()
	level_8.hide()
	level_9.hide()
	level_10.hide()
	reset_tab.hide()
	# Saves data
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")


# Darkens button when mouse is hovering it
func _confirm_mouse_entered():
	reset_confirm.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _confirm_mouse_exited():
	reset_confirm.set_modulate(NORMAL)


# Hides reset tab when pressed
func _backout_pressed():
	reset_tab.hide()


# Darkens button when mouse is hovering it
func _backout_mouse_entered():
	reset_backout.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _backout_mouse_exited():
	reset_backout.set_modulate(NORMAL)


# Begins level 6 when it is pressed
func _level_6_pressed():
	global.level = SIX
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _level_6_mouse_entered():
	level_6.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_6_mouse_exited():
	level_6.set_modulate(NORMAL)


# Begins level 7 when it is pressed
func _level_7_pressed():
	global.level = SEVEN
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _level_7_mouse_entered():
	level_7.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _on_level_7_mouse_exited():
	level_7.set_modulate(NORMAL)


# Begins level 8 when it is pressed
func _level_8_pressed():
	global.level = EIGHT
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _level_8_mouse_entered():
	level_8.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_8_mouse_exited():
	level_8.set_modulate(NORMAL)


# Begins level 9 when it is pressed
func _level_9_pressed():
	global.level = NINE
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _level_9_mouse_entered():
	level_9.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_9_mouse_exited():
	level_9.set_modulate(NORMAL)


# Begins level 10 when it is pressed
func _level_10_pressed():
	global.level = TEN
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _level_10_mouse_entered():
	level_10.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _level_10_mouse_exited():
	level_10.set_modulate(NORMAL)
