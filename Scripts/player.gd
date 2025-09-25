extends CharacterBody3D

@onready var global = get_node("/root/Global")
@onready var move_delay_timer: Node = $Move_delay_timer
@onready var forward_ray: Node = $Forward
@onready var right_ray: Node = $Right
@onready var back_ray: Node = $Back
@onready var left_ray: Node = $Left
@onready var left_hand: Node = $Left_hand
@onready var right_hand: Node = $Right_hand
const SPAWN: Vector3 = Vector3(0, 0.5, 0)
const UP: Vector3 = Vector3(1, 0, 0)
const DOWN: Vector3 = Vector3(-1, 0, 0)
const LEFT: Vector3 = Vector3(0, 0, -1)
const RIGHT: Vector3 = Vector3(0, 0, 1)
const MOVE_DELAY: float = 0.1
const SHORT_MOVE_DELAY: float = 0.01
const LERP_RATE: float = 12
const MAX_ACTION_QUEUE: int = 2
const OBSTACLE_BUFFER_SCALE: float = 0.1
const HAND_PUSH_SCALE: float = 0.3
const UNDO_OFFSET: int = 1
const UNDO: Vector3 = Vector3(-100, 0, 0)
const REDO: Vector3 = Vector3(100, 0, 0)
const WAIT: Vector3 = Vector3(100, 100, 100)
const RESTART: Vector3 = Vector3(10, 10, 10)
const HAND_Y_POS: float = 0.7
const HAND_Y_POS_MULTIPLIER: float = 0.05
const TIME_INCREMENT: float = 1.5
var left_hand_position: Vector3 = Vector3(0, 0.7, -0.45)
var right_hand_position: Vector3 = Vector3(0, 0.7, 0.45)
var target_location: Vector3 = SPAWN
var moving: bool = false
var action_queue: Array = []
var front_blocked: bool = false
var right_blocked: bool = false
var back_blocked: bool = false
var left_blocked: bool = false
var detection_ray: Node = null
var game_finished: bool = false
var undos: int = 0
var action_history: Array = [SPAWN]
var hand_y_pos_offset: float = 0.0
var time_variation: float = 0.0
signal push


# Called when the node enters the scene tree for the first time.
func _ready():
	for node in get_node("/root/Level").get_children():
		if node.is_in_group("Box"):
			push.connect(node._pushed)
			#action.connect(node._action_done)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global.player_pos = position
	if not game_finished and not global.paused:
		if Input.is_action_just_pressed("ui_minus") or global.undoing == true:
			global.undoing = false
			_move_input(UNDO)
		elif Input.is_action_just_pressed("ui_plus") or global.redoing == true:
			global.redoing = false
			_move_input(REDO)
		elif Input.is_action_just_pressed("ui_w"):
			_move_input(UP)
		elif Input.is_action_just_pressed("ui_s"):
			_move_input(DOWN)
		elif Input.is_action_just_pressed("ui_a"):
			_move_input(LEFT)
		elif Input.is_action_just_pressed("ui_d"):
			_move_input(RIGHT)
	# Clears pending actions when game is paused
	if Input.is_action_just_pressed("ui_escape"):
		action_queue = []
	# Moves the player toward the target location smoothly and sets position of hands
	if not global.paused:
		position = lerp(position, target_location, LERP_RATE * delta)
		left_hand.position = lerp(left_hand.position, left_hand_position, LERP_RATE * delta)
		right_hand.position = lerp(right_hand.position, right_hand_position, LERP_RATE * delta)
		if not moving:
			left_hand_position.y = HAND_Y_POS + HAND_Y_POS_MULTIPLIER * sin(time_variation)
			right_hand_position.y = HAND_Y_POS + HAND_Y_POS_MULTIPLIER * sin(time_variation)
			time_variation += TIME_INCREMENT * delta


# Function for setting the target location depending on the direction based on the input
func _move_input(direction):
	if len(action_queue) < MAX_ACTION_QUEUE:
			action_queue.append(direction)
	if not moving:
		moving = true
		_move(direction)


func _move(direction):
	if direction == UNDO:
		if undos < len(action_history) - UNDO_OFFSET:
			push.emit(UNDO, self)
			undos += UNDO_OFFSET
			target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
			move_delay_timer.start(MOVE_DELAY)
		else:
			move_delay_timer.start(SHORT_MOVE_DELAY)
	elif direction == REDO:
		if undos > 0:
			push.emit(REDO, self)
			undos -= UNDO_OFFSET
			target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
			move_delay_timer.start(MOVE_DELAY)
		else:
			move_delay_timer.start(SHORT_MOVE_DELAY)
	else:
		if undos > 0:
			action_history = action_history.slice(0, len(action_history) - undos)
			undos = 0
		if direction == UP:
			detection_ray = forward_ray
		elif direction == RIGHT:
			detection_ray = right_ray
		elif direction == DOWN:
			detection_ray = back_ray
		elif direction == LEFT:
			detection_ray = left_ray
		if detection_ray.is_colliding():
			if detection_ray.get_collider().is_in_group("Box"):
				push.emit(direction, detection_ray.get_collider())
				action_history.append(target_location)
				move_delay_timer.start(MOVE_DELAY)
				if direction == UP:
					right_hand.position += HAND_PUSH_SCALE * direction
					left_hand.position += HAND_PUSH_SCALE * direction
				elif direction == RIGHT:
					right_hand.position += HAND_PUSH_SCALE * direction
				elif direction == DOWN:
					right_hand.position += HAND_PUSH_SCALE * direction
					left_hand.position += HAND_PUSH_SCALE * direction
				elif direction == LEFT:
					left_hand.position += HAND_PUSH_SCALE * direction
			elif detection_ray.get_collider().is_in_group("Boundaries"):
				move_delay_timer.start(MOVE_DELAY)
				position += direction * OBSTACLE_BUFFER_SCALE
			else:
				push.emit(WAIT, self)
				target_location += direction
				action_history.append(target_location)
				move_delay_timer.start(MOVE_DELAY)
		else:
			push.emit(WAIT, self)
			target_location += direction
			action_history.append(target_location)
			move_delay_timer.start(MOVE_DELAY)


# Allows player to move again after the delay is done
func _move_delay_done():
	action_queue.remove_at(0)
	# Repeats movement if the action queue isnt done
	if len(action_queue) > 0:
		_move(action_queue[0])
		move_delay_timer.start(MOVE_DELAY)
	else:
		moving = false


# Triggers game end effects upon winning
func _win():
	game_finished = true
	action_queue = []
