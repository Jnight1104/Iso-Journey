extends Area3D

@onready var global = get_node("/root/Global")
signal press_signal
signal release_signal

# Called when the node enters the scene tree for the first time.
func _ready():
	$Unpressed.show()
	$Pressed.hide()
	if global.level == 1:
		press_signal.connect(get_node("/root/Level/Win_collectible")._unlocked)
		release_signal.connect(get_node("/root/Level/Win_collectible")._locked)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _pressed(body):
	$Pressed.show()
	$Unpressed.hide()
	press_signal.emit()


func _released(body):
	$Unpressed.show()
	$Pressed.hide()
	release_signal.emit()
