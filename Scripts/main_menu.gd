extends Control

const TRANSPARENT : Color = Color(1, 1, 1, 1)
const DARKENED : Color = Color(0.9, 0.9, 0.9, 1)
const BASE_POSITION : Vector2 = Vector2(575.4, 342.5)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Play.set_modulate(TRANSPARENT)
	$Options.set_modulate(TRANSPARENT)
	$Quit.set_modulate(TRANSPARENT)	


# Navigation to the level select screen when play is pressed
func _play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
	

# Quits the game when quit is pressed
func _quit_button_pressed():
	get_tree().quit()


func _options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Options_menu.tscn")


func _play_mouse_entered():
	$Play.set_modulate(DARKENED)


func _play_mouse_exited():
	$Play.set_modulate(TRANSPARENT)


func _options_mouse_entered():
	$Options.set_modulate(DARKENED)


func _options_mouse_exited():
	$Options.set_modulate(TRANSPARENT)


func _quit_mouse_entered():
	$Quit.set_modulate(DARKENED)


func _quit_mouse_exited():
	$Quit.set_modulate(TRANSPARENT)
