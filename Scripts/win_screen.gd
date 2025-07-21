extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()


func _win():
	self.show()


func _exit_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Level_select_menu.tscn")
