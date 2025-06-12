extends CharacterBody3D

const SPAWN : Vector3 = Vector3(0, 0.5, 0)
const UP : Vector3 = Vector3(1, 0, 0)
const DOWN : Vector3 = Vector3(-1, 0, 0)
const LEFT : Vector3 = Vector3(0, 0, -1)
const RIGHT : Vector3 = Vector3(0, 0, 1)
var target_location : Vector3 = SPAWN
var target_distance : Vector3 = Vector3(0, 0, 0)
var moving : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		_move(UP)
	elif Input.is_action_just_pressed("ui_down"):
		_move(DOWN)
	elif Input.is_action_just_pressed("ui_left"):
		_move(LEFT)
	elif Input.is_action_just_pressed("ui_right"):
		_move(RIGHT)	
	if position == target_location:
		moving = false
	print(lerp(position, target_location, 0.4))
	target_distance = abs(target_location - position)
	if abs(lerp(position, target_location, 0.4)).x < 0.001 and abs(lerp(position, target_location, 0.4)).z < 0.001:
		position = target_location
	position = lerp(position, target_location, 0.4)

func _move(direction):
	if not moving:
		moving = true
		target_location += direction
		
