extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Navigation to the level select screen when play is pressed
func _play_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
	

# Quits the game when quit is pressed
func _quit_button_pressed():
	get_tree().quit()


func _options_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Options_menu.tscn")
