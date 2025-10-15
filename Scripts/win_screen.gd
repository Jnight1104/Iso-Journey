extends Control

@onready var global = get_node("/root/Global")
@onready var fade_screen: Node = $Fade
@onready var fade_timer: Node = $Fade_timer
@onready var next_level_button: Node = $Next_level_button
@onready var success_sound: Node = $Success_sound
@onready var exit: Node = $Exit
const TRANSPARENT: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const FINAL_LEVEL: int = 10
const PLUS_ONE: int = 1
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
var next_level: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_screen.hide()
	self.hide()
	fade_target = FADE_OUT
	if global.level < FINAL_LEVEL:
		next_level_button.show()
	else:
		next_level_button.hide()


func _process(delta) -> void:
	# Smoothly fades the black screen when needed
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	fade_screen.set_modulate(fade)


# Plays win sound and shows win tab on game win
func _win():
	if global.sound_on:
		success_sound.play()
	if global.level == global.levels_unlocked:
		global.levels_unlocked = global.level + PLUS_ONE
	save_data()
	self.show()


# Exits to level select when pressed
func _exit_button_pressed():
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _exit_mouse_entered():
	exit.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _exit_mouse_exited():
	exit.set_modulate(TRANSPARENT)


func _fade_timer_done():
	# Changes scene when fading is done
	if fade_target == FADE_IN:
		# Begins next level if next level is pressed
		if next_level:
			# Identifies the next level based on current level
			if global.level == 1:
				global.level = 2
				get_tree().change_scene_to_file("res://Scenes/Level_2.tscn")
			elif global.level == 2:
				global.level = 3
				get_tree().change_scene_to_file("res://Scenes/Level_3.tscn")
			elif global.level == 3:
				global.level = 4
				get_tree().change_scene_to_file("res://Scenes/Level_4.tscn")
			elif global.level == 4:
				global.level = 5
				get_tree().change_scene_to_file("res://Scenes/Level_5.tscn")
			elif global.level == 5:
				global.level = 6
				get_tree().change_scene_to_file("res://Scenes/Level_6.tscn")
			elif global.level == 6:
				global.level = 7
				get_tree().change_scene_to_file("res://Scenes/Level_7.tscn")
			elif global.level == 7:
				global.level = 8
				get_tree().change_scene_to_file("res://Scenes/Level_8.tscn")
			elif global.level == 8:
				global.level = 9
				get_tree().change_scene_to_file("res://Scenes/Level_9.tscn")
			elif global.level == 9:
				global.level = 10
				get_tree().change_scene_to_file("res://Scenes/Level_10.tscn")
		# Exits to level select if exit pressed
		else:
			get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")


# Changes scene to the next level when pressed
func _next_level_pressed():
	fade_screen.show()
	fade_target = FADE_IN
	next_level = true
	fade_timer.start(FADE_TIME)


# Darkens button when mouse is hovering it
func _next_level_mouse_entered():
	next_level_button.set_modulate(DARKENED)


# Lightens button when mouse moves off it
func _next_level_mouse_exited():
	next_level_button.set_modulate(TRANSPARENT)


# Data save function
func save_data():
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
