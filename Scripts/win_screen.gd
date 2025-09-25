extends Control

const TRANSPARENT: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)
const FADE_IN: float = 1.0
const FADE_OUT: float = 0.0
const FADE_SCALE: float = 4.0
const FADE_TIME: float = 1.0
var fade: Color = Color(0, 0, 0, 1)
var fade_target: float = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Fade.hide()
	self.hide()
	fade_target = FADE_OUT


func _process(delta):
	fade.a = lerp(fade.a, fade_target, FADE_SCALE * delta)
	$Fade.set_modulate(fade)


func _win():
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
		get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
		
