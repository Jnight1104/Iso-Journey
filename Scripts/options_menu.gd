extends Control

const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Back.set_modulate(TRANSPARENT)


func _back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")


func _back_mouse_entered():
	$Back.set_modulate(DARKENED)


func _back_mouse_exited():
	$Back.set_modulate(TRANSPARENT)
