extends Panel

onready var playBtnNodePath = get_node("/root/main_menu/vbox/play")
onready var optionsBtnNodePath = get_node("/root/main_menu/vbox/options")
onready var exitBtnNodePath = get_node("/root/main_menu/vbox/exit")
onready var optionsNodePath = get_node("/root/main_menu/optionsModal")

func _ready():
	$volumeSlider.value = db2linear(mainTheme.volume_db)


# warning-ignore:unused_argument
func _on_volumeSlider_value_changed(value):
	mainTheme.volume_db = linear2db($volumeSlider.value)


func _on_save_pressed():
	playBtnNodePath.visible = 1
	optionsBtnNodePath.visible = 1
	exitBtnNodePath.visible = 1
	optionsNodePath.visible = 0
