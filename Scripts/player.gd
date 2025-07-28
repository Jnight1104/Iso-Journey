extends CharacterBody3D

@onready var global = get_node("/root/Global")
const SPAWN : Vector3 = Vector3(0, 0.5, 0)
const UP : Vector3 = Vector3(1, 0, 0)
const DOWN : Vector3 = Vector3(-1, 0, 0)
const LEFT : Vector3 = Vector3(0, 0, -1)
const RIGHT : Vector3 = Vector3(0, 0, 1)
const MOVE_DELAY : float = 0.1
const SHORT_MOVE_DELAY : float = 0.01
const LERP_RATE : float = 12
const MAX_ACTION_QUEUE : int = 2
const OBSTACLE_BUFFER_SCALE : float = 0.3
const UNDO_OFFSET : int = 1
const UNDO : Vector3 = Vector3(-100, 0, 0)
var target_location : Vector3 = SPAWN
var moving : bool = false
var action_queue : Array = []
var front_blocked : bool = false
var right_blocked : bool = false
var back_blocked : bool = false
var left_blocked : bool = false
var detection_ray : Node = null
var game_finished : bool = false
var undos : int = 0
var action_history : Array = [SPAWN]
signal push

# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_node("/root/Level").get_children():
		if node.is_in_group("Box"):
			push.connect(node._pushed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global.player_pos = position
	if not game_finished and not global.paused:
		if Input.is_action_just_pressed("ui_minus"):
			_move_input(UNDO)
		elif Input.is_action_just_pressed("ui_up"):
			_move_input(UP)
		elif Input.is_action_just_pressed("ui_down"):
			_move_input(DOWN)
		elif Input.is_action_just_pressed("ui_left"):
			_move_input(LEFT)
		elif Input.is_action_just_pressed("ui_right"):
			_move_input(RIGHT)
	# Clears pending actions when game is paused
	if Input.is_action_just_pressed("ui_escape"):
		action_queue = []
	# Moves the player toward the target location smoothly
	if not global.paused:
		position = lerp(position, target_location, LERP_RATE * delta)


# Function for setting the target location depending on the direction based on the input
func _move_input(direction):
	if len(action_queue) < MAX_ACTION_QUEUE:
			action_queue.append(direction)
	if not moving:
		moving = true
		_move(direction)


func _move(direction):
	print(action_history)
	if direction == UNDO:
		if undos < len(action_history) - UNDO_OFFSET:
			undos += UNDO_OFFSET
			target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
			$Move_delay_timer.start(MOVE_DELAY)
		else:
			$Move_delay_timer.start(SHORT_MOVE_DELAY)
	else:
		if undos > 0:
			action_history = action_history.slice(0, len(action_history) - undos)
			undos = 0
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
				#push.connect(detection_ray.get_collider()._pushed)
				push.emit(direction, detection_ray.get_collider())
				action_history.append(target_location)
				$Move_delay_timer.start(MOVE_DELAY)
				position += direction * OBSTACLE_BUFFER_SCALE
			elif detection_ray.get_collider().is_in_group("Boundaries"):
				$Move_delay_timer.start(MOVE_DELAY)
				position += direction * OBSTACLE_BUFFER_SCALE
			else:
				target_location += direction
				action_history.append(target_location)
				$Move_delay_timer.start(MOVE_DELAY)
		else:
			target_location += direction
			action_history.append(target_location)
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
	
