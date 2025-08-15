extends Area3D

@onready var global = get_node("/root/Global")
@onready var appearance: Node = $Mesh
const TRANSPARENT_COLOUR: Color = Color(1, 0.788, 0.226, 0.53)
const OPAQUE_COLOUR: Color = Color(1, 0.788, 0.226, 1)
const SPIN_SPEED: float = 0.5
var unlocked: bool = false
signal win


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connects the win signal to the necessary nodes
	win.connect(get_node("/root/Level/Player")._win)
	win.connect(get_node("/root/Level/Win_screen")._win)
	win.connect(get_node("/root/Level/Pause_menu")._win)
	# Makes the initial appearance transparent
	appearance.material_override.albedo_color = TRANSPARENT_COLOUR


func _process(delta):
	# Constantly rotates the collectible over time when the game isn't paused
	if not global.paused:
		rotation.y += SPIN_SPEED * delta


func _collected(body):
	# Triggers game winning sequence when unlocked and collected
	if body.is_in_group("Player") and unlocked:
		win.emit()
		queue_free()


func _unlocked():
	# Turns the collectible opaque when win conditions are met
	appearance.material_override.albedo_color = OPAQUE_COLOUR
	unlocked = true


func _locked():
	# Turns the collectible transparent when win conditions are not met
	appearance.material_override.albedo_color = TRANSPARENT_COLOUR
	unlocked = false
