extends Area3D

const TRANSPARENT_COLOUR : Color = Color(1, 0.78, 0.4, 0.53)
const OPAQUE_COLOUR : Color = Color(1, 0.78, 0.4, 1)
var unlocked : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$CSGBox3D.material.albedo_color = TRANSPARENT_COLOUR


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _collected(body):
	if body.is_in_group("Player") and unlocked:
		print("plink")
		queue_free()


func _unlocked():
	$CSGBox3D.material.albedo_color = OPAQUE_COLOUR
	unlocked = true


func _locked():
	$CSGBox3D.material.albedo_color = TRANSPARENT_COLOUR
	unlocked = false
	
