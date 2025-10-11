extends StaticBody3D

@onready var global = get_node("/root/Global")
const BLOCKED: Vector3 = Vector3(0, 1.19, 0)
const UNBLOCKED: Vector3 = Vector3(0, -1, 0)
const COLLISION_ACTIVE: Vector3 = Vector3(0, 0.5, 0)
const COLLISION_INACTIVE: Vector3 = Vector3(0, -3, 0)
const FAST_MODE_SCALE: float = 2.0
const REGULAR_MODE_SCALE: float = 1.0
const LERP_RATE: float = 10
var state: Vector3 = BLOCKED
var speed_mult: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	if self.is_in_group("Up"):
		state = BLOCKED
		$Vine.position = BLOCKED
		$CollisionShape3D.position = COLLISION_ACTIVE
	else:
		state = UNBLOCKED
		$Vine.position = UNBLOCKED
		$CollisionShape3D.position = COLLISION_INACTIVE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global.fast_mode:
		speed_mult = FAST_MODE_SCALE
	else:
		speed_mult = REGULAR_MODE_SCALE
	$Vine.position = lerp($Vine.position, state, LERP_RATE * speed_mult * delta)


func _activated():
	if state == BLOCKED:
		state = UNBLOCKED
		$CollisionShape3D.position = COLLISION_INACTIVE
	else:
		state = BLOCKED
		$CollisionShape3D.position = COLLISION_ACTIVE
