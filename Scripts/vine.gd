extends StaticBody3D

@onready var global = get_node("/root/Global")
@onready var vine: Node = $Vine
@onready var collision: Node = $CollisionShape3D
const BLOCKED: Vector3 = Vector3(0, 1.19, 0)
const UNBLOCKED: Vector3 = Vector3(0, -1, 0)
const COLLISION_ACTIVE: Vector3 = Vector3(0, 0.5, 0)
const COLLISION_INACTIVE: Vector3 = Vector3(0, -3, 0)
const FAST_MODE_SCALE: float = 2.0
const REGULAR_MODE_SCALE: float = 1.0
const LERP_RATE: float = 10
const UP: String = "Up"
var state: Vector3 = BLOCKED
var speed_mult: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sets initial vine state based on whether it is in the up or down group
	if self.is_in_group(UP):
		state = BLOCKED
		vine.position = BLOCKED
		collision.position = COLLISION_ACTIVE
	else:
		state = UNBLOCKED
		vine.position = UNBLOCKED
		collision.position = COLLISION_INACTIVE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	# Modifies speed based on fast mode
	if global.fast_mode:
		speed_mult = FAST_MODE_SCALE
	else:
		speed_mult = REGULAR_MODE_SCALE
	# Provides smooth vine rising/lowering animation when transitioning state
	vine.position = lerp(vine.position, state, LERP_RATE * speed_mult * delta)


# Flips state when the linked button(s) are pressed or released 
func _activated():
	if state == BLOCKED:
		state = UNBLOCKED
		collision.position = COLLISION_INACTIVE
	else:
		state = BLOCKED
		collision.position = COLLISION_ACTIVE
