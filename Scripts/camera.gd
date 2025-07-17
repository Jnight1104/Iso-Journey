extends Camera3D

@onready var global = get_node("/root/Global")
const CAMERA_OFFSET_RADIUS : float = sqrt(98)
const CAMERA_Y_POS : float = 5.5
const LERP_RATE : float = 0.2
const ROTATION_RATE : float = 1
const STARTING_ROTATION : float = 3 * PI / 4
var camera_offset_x : float = 0.0
var camera_offset_z : float = 0.0
var camera_offset : Vector3 = Vector3(0, 0, 0)
var target_rotation : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	target_rotation = STARTING_ROTATION


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_offset_x = sin(rotation.y) * CAMERA_OFFSET_RADIUS
	camera_offset_z = cos(rotation.y) * CAMERA_OFFSET_RADIUS
	camera_offset = Vector3(camera_offset_x, CAMERA_Y_POS, camera_offset_z) + global.player_pos
	print(position.y)
	if Input.is_action_pressed("ui_period"):
		target_rotation += ROTATION_RATE * delta
	if Input.is_action_pressed("ui_comma"):
		target_rotation -= ROTATION_RATE * delta
	
	# Moves and rotates the camera toward the target location smoothly
	rotation.y = lerp(rotation.y, target_rotation, LERP_RATE)
	position = camera_offset #lerp(position, camera_offset, LERP_RATE)

# 135, +x -z
# 45, +x +z
# -135, -x -z
# -45, -x +z
# sin for x     cos for z
