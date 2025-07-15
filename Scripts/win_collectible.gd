extends RigidBody3D

const TRANSPARENT_COLOUR : Color = Color(1, 0.78, 0.4, 0.53)
const OPAQUE_COLOUR : Color = Color(1, 0.78, 0.4, 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	$CSGBox3D.material.albedo_color = TRANSPARENT_COLOUR
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _collected(body):
	if body.is_in_group("Player"):
		print("plink")
		queue_free()
