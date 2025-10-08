extends Area3D

@onready var global = get_node("/root/Global")
const VINE1: String = "Vine1"
const VINE2: String = "Vine2"
const VINE3: String = "Vine3"
const VINE4: String = "Vine4"
var vine_group: String = ""
signal press_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	$Unpressed.show()
	$Pressed.hide()
	if self.is_in_group("Button1"):
		vine_group = VINE1
	elif self.is_in_group("Button2"):
		vine_group = VINE2
	elif self.is_in_group("Button3"):
		vine_group = VINE3
	elif self.is_in_group("Button4"):
		vine_group = VINE4
	for node in get_node("/root/Level").get_children():
		if node.is_in_group(vine_group):
			press_signal.connect(node._activated)


func _pressed(body):
	if global.sound_on:
		$Click_sound.play()
	$Pressed.show()
	$Unpressed.hide()
	press_signal.emit()


func _released(body):
	if global.sound_on:
		$Click_sound.play()
	$Unpressed.show()
	$Pressed.hide()
