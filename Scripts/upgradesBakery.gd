extends Panel

onready var bakeryNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery")
onready var upgradesBakeryNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesBakery")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")

func _on_bakeryButton_pressed():
	bakeryNodePath.visible = 1
	upgradesBakeryNodePath.visible = 0
	
	#Sending boolean var to camera to stop panniing
	var tmp = false
	cameraNodePath.setUpgradesBakeryState(tmp)
	var tmp2 = true
	cameraNodePath.setBakeryState(tmp2)

func _on_close_pressed():
	upgradesBakeryNodePath.visible = 0
	bakeryNodePath.visible = 0
	
	#Sending boolean var to camera to stop panning
	var tmp = false
	cameraNodePath.setUpgradesBakeryState(tmp)
	
