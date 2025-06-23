extends CharacterBody3D

const SPAWN : Vector3 = Vector3(0, 0.5, 0)
const UP : Vector3 = Vector3(1, 0, 0)
const DOWN : Vector3 = Vector3(-1, 0, 0)
const LEFT : Vector3 = Vector3(0, 0, -1)
const RIGHT : Vector3 = Vector3(0, 0, 1)
const MOVE_DELAY : float = 0.1
const LERP_RATE : float = 0.4
const MAX_ACTION_QUEUE : int = 1
var target_location : Vector3 = SPAWN
var moving : bool = false
var action_queue : Array = []


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
	# Moves the player toward the target location smoothly
	position = lerp(position, target_location, LERP_RATE)


# Function for setting the target location depending on the direction based on the input
func _move(direction):
	if moving:
		if len(action_queue) < MAX_ACTION_QUEUE:
			action_queue.append(direction)
	else:
		moving = true
		target_location += direction
		$Move_delay_timer.start(MOVE_DELAY)


# Allows player to move again after the delay is done
func _move_delay_done():
	# Repeats movement if the action queue isnt done
	if len(action_queue) > 0:
		target_location += action_queue[0]
		action_queue.remove_at(0)
		$Move_delay_timer.start(MOVE_DELAY)
	else:
		moving = false
