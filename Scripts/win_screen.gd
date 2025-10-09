extends Control

@onready var global = get_node("/root/Global")
const TRANSPARENT: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const FINAL_LEVEL: int = 8
const PLUS_ONE: int = 1
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
var next_level: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fade.hide()
	self.hide()
	fade_target = FADE_OUT
	if global.level < FINAL_LEVEL:
		$Next_level_button.show()
	else:
		$Next_level_button.hide()


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


func _win():
	if global.sound_on:
		$Success_sound.play()
	if global.level == global.levels_unlocked:
		global.levels_unlocked = global.level + PLUS_ONE
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
	self.show()


func _exit_button_pressed():
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _exit_mouse_entered():
	$Exit.set_modulate(DARKENED)


func _exit_mouse_exited():
	$Exit.set_modulate(TRANSPARENT)


func _fade_timer_done():
	if fade_target == FADE_IN:
		if next_level:
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
		else:
			get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")


func _next_level_pressed():
	$Fade.show()
	fade_target = FADE_IN
	next_level = true
	$Fade_timer.start(FADE_TIME)


func _next_level_mouse_entered():
	$Next_level_button.set_modulate(DARKENED)


func _next_level_mouse_exited():
	$Next_level_button.set_modulate(TRANSPARENT)
