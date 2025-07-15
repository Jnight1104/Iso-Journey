extends Area3D

@onready var global = get_node("/root/Global")
signal press_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _pressed(body):
	print("boop")
	if global.level == 1:
		press_signal.connect(get_node("/root/Level/Win_collectible")._win)
		press_signal.emit()
