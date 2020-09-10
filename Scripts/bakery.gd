extends Panel

onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var bakeryBtn = $bakeryBtn
onready var supervisorBtn = $supervisorsBtn


export var targetBakery = "avaloniaBakery"


func _on_close_bakery_pressed():
	$".".visible = 0
	cameraNodePath.setBakeryState(false)


func _on_supervisorsBtn_pressed():
	$supervisorPanel.show()
	$productScroll.hide()
	setButtonState("enable", supervisorBtn)
	setButtonState("disable", bakeryBtn)
	
func _on_bakeryBtn_pressed():
	$supervisorPanel.hide()
	$productScroll.show()
	setButtonState("disable", supervisorBtn)
	setButtonState("enable", bakeryBtn)

func setButtonState(state : String, button : TextureButton):
	if state == "enable":
		button.set_normal_texture(load("res://Image-assets/title blue-no-text.png"))
	else:
		button.set_normal_texture(load("res://Image-assets/title grey-no-text.png"))
	
