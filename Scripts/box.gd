extends RigidBody3D

const LERP_RATE : float = 0.3
const UP : Vector3 = Vector3(1, 0, 0)
const DOWN : Vector3 = Vector3(-1, 0, 0)
const LEFT : Vector3 = Vector3(0, 0, -1)
const RIGHT : Vector3 = Vector3(0, 0, 1)
const MOVE_DELAY : float = 0.1
var target_location : Vector3 = Vector3(0, 0, 0)
var detection_ray : Node = null


# Called when the node enters the scene tree for the first time.
func _ready():
	target_location = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = lerp(position, target_location, LERP_RATE)


func _pushed(direction, node):
	if direction == UP:
		detection_ray = $Forward
	elif direction == RIGHT:
		detection_ray = $Right
	elif direction == DOWN:
		detection_ray = $Back
	elif direction == LEFT:
		detection_ray = $Left
	if detection_ray.is_colliding():
		pass
	else:
		if node == self:
			target_location += direction
