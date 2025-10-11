extends Area3D

@onready var global = get_node("/root/Global")
const VINE1: String = "Vine1"
const VINE2: String = "Vine2"
const VINE3: String = "Vine3"
const VINE4: String = "Vine4"
const VINE5: String = "Vine5"
const VINE6: String = "Vine6"
const VINE7: String = "Vine7"
const VINE8: String = "Vine8"
const VINE9: String = "Vine9"
const VINE10: String = "Vine10"
const VINE11: String = "Vine11"
const VINE12: String = "Vine12"
const VINE13: String = "Vine13"
const VINE14: String = "Vine14"
const VINE15: String = "Vine15"
const BUTTON1: String = "Button1"
const BUTTON2: String = "Button2"
const BUTTON3: String = "Button3"
const BUTTON4: String = "Button4"
const BUTTON5: String = "Button5"
const BUTTON6: String = "Button6"
const BUTTON7: String = "Button7"
const BUTTON8: String = "Button8"
const BUTTON9: String = "Button9"
const BUTTON10: String = "Button10"
const BUTTON11: String = "Button11"
const BUTTON12: String = "Button12"
const BUTTON13: String = "Button13"
const BUTTON14: String = "Button14"
const BUTTON15: String = "Button15"
var vine_group: String = ""
signal press_signal


# Called when the node enters the scene tree for the first time.
func _ready():
	$Unpressed.show()
	$Pressed.hide()
	if self.is_in_group(BUTTON1):
		vine_group = VINE1
	elif self.is_in_group(BUTTON2):
		vine_group = VINE2
	elif self.is_in_group(BUTTON3):
		vine_group = VINE3
	elif self.is_in_group(BUTTON4):
		vine_group = VINE4
	elif self.is_in_group(BUTTON5):
		vine_group = VINE5
	elif self.is_in_group(BUTTON6):
		vine_group = VINE6
	elif self.is_in_group(BUTTON7):
		vine_group = VINE7
	elif self.is_in_group(BUTTON8):
		vine_group = VINE8
	elif self.is_in_group(BUTTON9):
		vine_group = VINE9
	elif self.is_in_group(BUTTON10):
		vine_group = VINE10
	elif self.is_in_group(BUTTON11):
		vine_group = VINE11
	elif self.is_in_group(BUTTON12):
		vine_group = VINE12
	elif self.is_in_group(BUTTON13):
		vine_group = VINE13
	elif self.is_in_group(BUTTON14):
		vine_group = VINE14
	elif self.is_in_group(BUTTON15):
		vine_group = VINE15
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
	press_signal.emit()
