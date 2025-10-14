extends Area3D

@onready var global = get_node("/root/Global")
@onready var unpressed: Node = $Unpressed
@onready var pressed: Node = $Pressed
@onready var click_sound: Node = $Click_sound
signal press_signal
signal release_signal


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	unpressed.show()
	pressed.hide()
	global.objectives_reached = 0
	press_signal.connect(get_node("/root/Level/Win_collectible")._unlocked)
	release_signal.connect(get_node("/root/Level/Win_collectible")._locked)


func _pressed(_body):
	if global.sound_on:
		click_sound.play()
	pressed.show()
	unpressed.hide()
	if global.level == 1 or global.level == 6:
		press_signal.emit()
	elif global.level == 2 or global.level == 5:
		global.objectives_reached += 1
		if global.objectives_reached == 19:
			press_signal.emit()
	elif global.level == 3 or global.level == 7:
		global.objectives_reached += 1
		if global.objectives_reached == 4:
			press_signal.emit()
	elif global.level == 4:
		global.objectives_reached += 1
		if global.objectives_reached == 8:
			press_signal.emit()
	elif global.level == 9:
		global.objectives_reached += 1
		if global.objectives_reached == 3:
			press_signal.emit()


func _released(_body):
	if global.sound_on:
		click_sound.play()
	unpressed.show()
	pressed.hide()
	if global.level == 1 or global.level == 6:
		release_signal.emit()
	else:
		global.objectives_reached -= 1
		release_signal.emit()
