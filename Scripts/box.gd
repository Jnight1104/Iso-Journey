extends RigidBody3D

@onready var global = get_node("/root/Global")
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
func _ready():
	$Dust.emitting = false
	target_location = position
	action_history.append(position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Sets speed multiplier based on whether fast mode is enabled
	if global.fast_mode:
		speed_mult = FAST_MODE_SCALE
	else:
		speed_mult = REGULAR_MODE_SCALE
	# Moves the box to the set position smoothly
	position = lerp(position, target_location, LERP_RATE * speed_mult * delta)


func _pushed(direction, node):
	if direction == WAIT:
		if undos > 0:
			action_history = action_history.slice(0, len(action_history) - undos)
			undos = 0
		action_history.append(target_location)
	elif direction == UNDO:
		undos += UNDO_OFFSET
		target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
	elif direction == REDO:
		undos -= UNDO_OFFSET
		target_location = action_history[len(action_history) - (undos + UNDO_OFFSET)]
	else:
		$Dust.process_material.direction = -1 * direction
		if direction == UP:
			detection_ray = $Forward
		elif direction == RIGHT:
			detection_ray = $Right
		elif direction == DOWN:
			detection_ray = $Back
		elif direction == LEFT:
			detection_ray = $Left
		if detection_ray.is_colliding() or $Above.has_overlapping_bodies():
			if undos > 0:
				action_history = action_history.slice(0, len(action_history) - undos)
				undos = 0
			action_history.append(target_location)
		else:
			if node == self:
				if undos > 0:
					action_history = action_history.slice(0, len(action_history) - undos)
					undos = 0
				if global.sound_on:
					$Move_sound.play()
				target_location += direction
				$Dust.restart()
				action_history.append(target_location)
			else:
				if undos > 0:
					action_history = action_history.slice(0, len(action_history) - undos)
					undos = 0
				action_history.append(target_location)
