extends CharacterBody3D

@onready var global = get_node("/root/Global")
const SPAWN : Vector3 = Vector3(0, 0.5, 0)
const UP : Vector3 = Vector3(1, 0, 0)
const DOWN : Vector3 = Vector3(-1, 0, 0)
const LEFT : Vector3 = Vector3(0, 0, -1)
const RIGHT : Vector3 = Vector3(0, 0, 1)
const MOVE_DELAY : float = 0.1
const LERP_RATE : float = 0.2
const MAX_ACTION_QUEUE : int = 2
const OBSTACLE_BUFFER_SCALE : float = 0.3
var target_location : Vector3 = SPAWN
var moving : bool = false
var action_queue : Array = []
var front_blocked : bool = false
var right_blocked : bool = false
var back_blocked : bool = false
var left_blocked : bool = false
var detection_ray : Node = null
var game_finished : bool = false
signal push

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global.player_pos = position
	if not game_finished:
		if Input.is_action_just_pressed("ui_up"):
			_move_input(UP)
		elif Input.is_action_just_pressed("ui_down"):
			_move_input(DOWN)
		elif Input.is_action_just_pressed("ui_left"):
			_move_input(LEFT)
		elif Input.is_action_just_pressed("ui_right"):
			_move_input(RIGHT)
		
	# Moves the player toward the target location smoothly
	position = lerp(position, target_location, LERP_RATE)


# Function for setting the target location depending on the direction based on the input
func _move_input(direction):
	if len(action_queue) < MAX_ACTION_QUEUE:
			action_queue.append(direction)
	if not moving:
		moving = true
		_move(direction)


func _move(direction):
	if direction == UP:
		detection_ray = $Forward
	elif direction == RIGHT:
		detection_ray = $Right
	elif direction == DOWN:
		detection_ray = $Back
	elif direction == LEFT:
		detection_ray = $Left
	if detection_ray.is_colliding():
		if detection_ray.get_collider().is_in_group("Box"):
			push.connect(detection_ray.get_collider()._pushed)
			push.emit(direction, detection_ray.get_collider())
			$Move_delay_timer.start(MOVE_DELAY)
			position += direction * OBSTACLE_BUFFER_SCALE
		elif detection_ray.get_collider().is_in_group("Boundaries"):
			$Move_delay_timer.start(MOVE_DELAY)
			position += direction * OBSTACLE_BUFFER_SCALE
		else:
			target_location += direction
			$Move_delay_timer.start(MOVE_DELAY)
	else:
		target_location += direction
		$Move_delay_timer.start(MOVE_DELAY)
		

# Allows player to move again after the delay is done
func _move_delay_done():
	action_queue.remove_at(0)
	# Repeats movement if the action queue isnt done
	if len(action_queue) > 0:
		_move(action_queue[0])
		$Move_delay_timer.start(MOVE_DELAY)
	else:
		moving = false


func _win():
	game_finished = true
	action_queue = []
	
