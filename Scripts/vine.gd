extends StaticBody3D

@onready var global = get_node("/root/Global")
const BLOCKED: Vector3 = Vector3(0, 1.19, 0)
const UNBLOCKED: Vector3 = Vector3(0, -1, 0)
const FAST_MODE_SCALE: float = 2.0
const REGULAR_MODE_SCALE: float = 1.0
const LERP_RATE: float = 10
var state: Vector3 = BLOCKED
var speed_mult: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	if self.is_in_group("Vine1"):
		state = BLOCKED
		$CollisionShape3D.disabled = false
	elif self.is_in_group("Vine2"):
		state = UNBLOCKED
		$CollisionShape3D.disabled = true
	elif self.is_in_group("Vine3"):
		state = BLOCKED
		$CollisionShape3D.disabled = false
	elif self.is_in_group("Vine4"):
		state = UNBLOCKED
		$CollisionShape3D.disabled = true


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
		$CollisionShape3D.disabled = true
	else:
		state = BLOCKED
		$CollisionShape3D.disabled = false
