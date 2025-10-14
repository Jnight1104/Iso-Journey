extends RigidBody3D

@onready var global = get_node("/root/Global")
@onready var dust: Node = $Dust
@onready var forward: Node = $Forward
@onready var right: Node = $Right
@onready var back: Node = $Back
@onready var left: Node = $Left
@onready var above: Node = $Above
@onready var move_sound: Node = $Move_sound
const LERP_RATE: float = 18
const UP: Vector3 = Vector3(1, 0, 0)
const DOWN: Vector3 = Vector3(-1, 0, 0)
const LEFT: Vector3 = Vector3(0, 0, -1)
const RIGHT: Vector3 = Vector3(0, 0, 1)
const UNDO: Vector3 = Vector3(-100, 0, 0)
const REDO: Vector3 = Vector3(100, 0, 0)
const WAIT: Vector3 = Vector3(100, 100, 100)
const UNDO_OFFSET: int = 1
const FAST_MODE_SCALE: float = 2.0
const REGULAR_MODE_SCALE: float = 1.0
var target_location: Vector3 = Vector3(0, 0, 0)
var detection_ray: Node = null
var action_history: Array = []
var undos: int = 0
var speed_mult: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dust.emitting = false
	target_location = position
	action_history.append(position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Sets speed multiplier based on whether fast mode is enabled
	if global.fast_mode:
		speed_mult = FAST_MODE_SCALE
	else:
		speed_mult = REGULAR_MODE_SCALE
	# Moves the box to the set position smoothly
	position = lerp(position, target_location, LERP_RATE * speed_mult * delta)


func _pushed(direction, node):
	# Adds onto action history for remaining stationary after a player input
	if direction == WAIT:
		# Cuts off undone actions when a new input is created
		if undos > 0:
			action_history = action_history.slice(0, len(action_history) - undos)
			undos = 0
		action_history.append(target_location)
	# Restores previous positions when undo happens
	elif direction == UNDO:
		undos += UNDO_OFFSET
		target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
	# Restores undone positions when redo happens
	elif direction == REDO:
		undos -= UNDO_OFFSET
		target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
	else:
		# Makes dust emit in opposite direction to current movement
		dust.process_material.direction = -1 * direction
		# Calls the required detection ray based on direction recieved
		if direction == UP:
			detection_ray = forward
		elif direction == RIGHT:
			detection_ray = right
		elif direction == DOWN:
			detection_ray = back
		elif direction == LEFT:
			detection_ray = left
		# Prevents movement if detection ray detects an adjacent obstacle
		if detection_ray.is_colliding() or above.has_overlapping_bodies():
			# Cuts off undone actions when a new input is created
			if undos > 0:
				action_history = action_history.slice(0, len(action_history) - undos)
				undos = 0
			action_history.append(target_location)
		else:
			# Ensures only the box being called to push is pushed
			if node == self:
				# Cuts off undone actions when a new input is created
				if undos > 0:
					action_history = action_history.slice(0, len(action_history) - undos)
					undos = 0
				# Playes sound if sound enabled
				if global.sound_on:
					move_sound.play()
				# Moves the box to set location
				target_location += direction
				dust.restart()
				action_history.append(target_location)
			# Keeps box stationary if not being pushed
			else:
				# Cuts off undone actions when a new input is created
				if undos > 0:
					action_history = action_history.slice(0, len(action_history) - undos)
					undos = 0
				action_history.append(target_location)
