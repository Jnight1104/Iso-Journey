extends Control

@onready var global = get_node("/root/Global")
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
func _ready():
	music_play.connect(get_node("/root/MusicNode").music_on)
	music_stop.connect(get_node("/root/MusicNode").music_off)
	$Back.set_modulate(TRANSPARENT)
	$Fade.show()
	$Fade.set_modulate(fade)
	fade_target = FADE_OUT
	$Fade_timer.start(FADE_TIME)
	# Sets toggle button visual modes based on whether their representing values are true or false
	if not global.fast_mode:
		$Fast_mode_button/Toggle.set_frame(END_FRAME)
	else:
		$Fast_mode_button/Toggle.set_frame(START_FRAME)
	if not global.music_on:
		$Music_button/Toggle2.set_frame(END_FRAME)
	else:
		$Music_button/Toggle2.set_frame(START_FRAME)
	if not global.sound_on:
		$Sounds_button/Toggle3.set_frame(END_FRAME)
	else:
		$Sounds_button/Toggle3.set_frame(START_FRAME)


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


func _back_button_pressed():
	$Fade.show()
	fade_target = FADE_IN
	$Fade_timer.start(FADE_TIME)


func _back_mouse_entered():
	$Back.set_modulate(DARKENED)


func _back_mouse_exited():
	$Back.set_modulate(TRANSPARENT)


func _fade_timer_done():
	if fade_target == FADE_OUT:
		$Fade.hide()
	else:
		get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")


func _fast_mode_pressed():
	if not global.fast_mode:
		$Fast_mode_button/Toggle.play_backwards()
		global.fast_mode = true
	else:
		$Fast_mode_button/Toggle.play()
		global.fast_mode = false


func _fast_mode_mouse_entered():
	$Fast_mode_button.set_modulate(DARKENED)


func _fast_mode_mouse_exited():
	$Fast_mode_button.set_modulate(TRANSPARENT)


func _music_pressed():
	if not global.music_on:
		$Music_button/Toggle2.play_backwards()
		global.music_on = true
		music_play.emit()
	else:
		$Music_button/Toggle2.play()
		global.music_on = false
		music_stop.emit()


func _music_mouse_entered():
	$Music_button.set_modulate(DARKENED)


func _music_mouse_exited():
	$Music_button.set_modulate(TRANSPARENT)


func _sounds_pressed():
	if not global.sound_on:
		$Sounds_button/Toggle3.play_backwards()
		global.sound_on = true
	else:
		$Sounds_button/Toggle3.play()
		global.sound_on = false


func _sounds_mouse_entered():
	$Sounds_button.set_modulate(DARKENED)


func _sounds_mouse_exited():
	$Sounds_button.set_modulate(TRANSPARENT)
