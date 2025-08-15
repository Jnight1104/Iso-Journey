extends Control

const TRANSPARENT: Color = Color(1, 1, 1, 1)
const DARKENED: Color = Color(0.9, 0.9, 0.9, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()


func _win():
	self.show()


func _exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")


func _exit_mouse_entered():
	$Exit.set_modulate(DARKENED)


func _exit_mouse_exited():
	$Exit.set_modulate(TRANSPARENT)
