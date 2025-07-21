extends Area3D

const TRANSPARENT_COLOUR : Color = Color(1, 0.78, 0.4, 0.53)
const OPAQUE_COLOUR : Color = Color(1, 0.78, 0.4, 1)
var unlocked : bool = false
signal win

# Called when the node enters the scene tree for the first time.
func _ready():
	win.connect(get_node("/root/Level/Player")._win)
	win.connect(get_node("/root/Level/Win_screen")._win)
	win.connect(get_node("/root/Level/Pause_menu")._win)
	$CSGBox3D.material.albedo_color = TRANSPARENT_COLOUR


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _collected(body):
	if body.is_in_group("Player") and unlocked:
		win.emit()
		print("plink")
		queue_free()


func _unlocked():
	$CSGBox3D.material.albedo_color = OPAQUE_COLOUR
	unlocked = true


func _locked():
	$CSGBox3D.material.albedo_color = TRANSPARENT_COLOUR
	unlocked = false
	
