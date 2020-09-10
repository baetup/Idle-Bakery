extends Panel

onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var shopBtn = $shopBtn
onready var supervisorBtn = $supervisorsBtn


func _on_close_pressed():
	$".".visible = 0
	cameraNodePath.setStoreState(false)

func _on_supervisorsBtn_pressed():
	$supervisorPanel.show()
	$ScrollContainer.hide()
	setButtonState("enable", supervisorBtn)
	setButtonState("disabled", shopBtn)


func _on_shopBtn_pressed():
	$supervisorPanel.hide()
	$ScrollContainer.show()
	setButtonState("enable", shopBtn)
	setButtonState("disable", supervisorBtn)

func setButtonState(state : String, button : TextureButton):
	if state == "enable":
		button.set_normal_texture(load("res://Image-assets/title blue-no-text.png"))
	else:
		button.set_normal_texture(load("res://Image-assets/title grey-no-text.png"))
