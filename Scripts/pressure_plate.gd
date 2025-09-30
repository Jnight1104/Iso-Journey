extends Area3D

@onready var global = get_node("/root/Global")
signal press_signal
signal release_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	$Unpressed.show()
	$Pressed.hide()
	global.objectives_reached = 0
	press_signal.connect(get_node("/root/Level/Win_collectible")._unlocked)
	release_signal.connect(get_node("/root/Level/Win_collectible")._locked)


func _pressed(_body):
	$Pressed.show()
	$Unpressed.hide()
	if global.level == 1:
		press_signal.emit()
	elif global.level == 2 or global.level == 5:
		global.objectives_reached += 1
		if global.objectives_reached == 19:
			press_signal.emit()
	elif global.level == 3:
		global.objectives_reached += 1
		if global.objectives_reached == 4:
			press_signal.emit()
	elif global.level == 4:
		global.objectives_reached += 1
		if global.objectives_reached == 8:
			press_signal.emit()


func _released(_body):
	$Unpressed.show()
	$Pressed.hide()
	if global.level == 1:
		release_signal.emit()
	else:
		global.objectives_reached -= 1
		release_signal.emit()
