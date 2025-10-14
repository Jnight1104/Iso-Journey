extends Control

@onready var global = get_node("/root/Global")
@onready var fade_screen: Node = $Fade
@onready var fade_timer: Node = $Fade_timer
@onready var back: Node = $Back
@onready var fast_mode_button: Node = $Fast_mode_button
@onready var music_button: Node = $Music_button
@onready var sounds_button: Node = $Sounds_button
@onready var fast_mode_animation: Node = $Fast_mode_button/Toggle
@onready var music_animation: Node = $Music_button/Toggle2
@onready var sounds_animation: Node = $Sounds_button/Toggle3
const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
const START_FRAME: int = 0
const END_FRAME: int = 11
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0
signal music_play
signal music_stop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music_play.connect(get_node("/root/MusicNode").music_on)
	music_stop.connect(get_node("/root/MusicNode").music_off)
	back.set_modulate(TRANSPARENT)
	fade_screen.show()
	fade_screen.set_modulate(fade)
	fade_target = FADE_OUT
	fade_timer.start(FADE_TIME)
	# Sets toggle button visual modes based on whether their representing values are true or false
	if not global.fast_mode:
		fast_mode_animation.set_frame(END_FRAME)
	else:
		fast_mode_animation.set_frame(START_FRAME)
	if not global.music_on:
		music_animation.set_frame(END_FRAME)
	else:
		music_animation.set_frame(START_FRAME)
	if not global.sound_on:
		sounds_animation.set_frame(END_FRAME)
	else:
		sounds_animation.set_frame(START_FRAME)


func _process(delta) -> void:
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	fade_screen.set_modulate(fade)


func _back_button_pressed():
	save_data()
	fade_screen.show()
	fade_target = FADE_IN
	fade_timer.start(FADE_TIME)


func _back_mouse_entered():
	back.set_modulate(DARKENED)


func _back_mouse_exited():
	back.set_modulate(TRANSPARENT)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		fade_screen.hide()
	else:
		get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")


func _fast_mode_pressed():
	if not global.fast_mode:
		fast_mode_animation.play_backwards()
		global.fast_mode = true
	else:
		fast_mode_animation.play()
		global.fast_mode = false
	save_data()


func _fast_mode_mouse_entered():
	fast_mode_button.set_modulate(DARKENED)


func _fast_mode_mouse_exited():
	fast_mode_button.set_modulate(TRANSPARENT)


func _music_pressed():
	if not global.music_on:
		music_animation.play_backwards()
		global.music_on = true
		music_play.emit()
	else:
		music_animation.play()
		global.music_on = false
		music_stop.emit()
	save_data()


func _music_mouse_entered():
	music_button.set_modulate(DARKENED)


func _music_mouse_exited():
	music_button.set_modulate(TRANSPARENT)


func _sounds_pressed():
	if not global.sound_on:
		sounds_animation.play_backwards()
		global.sound_on = true
	else:
		sounds_animation.play()
		global.sound_on = false
	save_data()


func _sounds_mouse_entered():
	sounds_button.set_modulate(DARKENED)


func _sounds_mouse_exited():
	sounds_button.set_modulate(TRANSPARENT)


func save_data():
	var file = save.new()
	file.fast_mode = global.fast_mode
	file.music_on = global.music_on
	file.sound_on = global.sound_on
	file.levels_unlocked = global.levels_unlocked
	ResourceSaver.save(file, "res://Scripts/save.tres")
