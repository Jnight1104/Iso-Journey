extends Control

@onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Begins level 1 when it is pressed
func _level_1_pressed():
	global.level = 1
	get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")


# Navigation back to main menu when back is pressed
func _back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main_menu.tscn")
