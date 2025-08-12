extends Area3D

@onready var appearance: Node = $Cube
const TRANSPARENT_COLOUR: Color = Color(1, 0.788, 0.226, 0.53)
const OPAQUE_COLOUR: Color = Color(1, 0.788, 0.226, 1)
var unlocked: bool = false
signal win


# Called when the node enters the scene tree for the first time.
func _ready():
	win.connect(get_node("/root/Level/Player")._win)
	win.connect(get_node("/root/Level/Win_screen")._win)
	win.connect(get_node("/root/Level/Pause_menu")._win)
	appearance.material_override.albedo_color = TRANSPARENT_COLOUR


func _collected(body):
	if body.is_in_group("Player") and unlocked:
		win.emit()
		print("plink")
		queue_free()


func _unlocked():
	appearance.material_override.albedo_color = OPAQUE_COLOUR
	unlocked = true


func _locked():
	appearance.material_override.albedo_color = TRANSPARENT_COLOUR
	unlocked = false
	
