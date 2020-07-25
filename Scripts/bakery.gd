extends Panel

onready var bakeryNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery")
onready var upgradesBakeryNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesBakery")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")

export var targetBakery = "avaloniaBakery"


func _on_close_pressed():
	$".".visible = 0
	var tempBoolean = false
	cameraNodePath.setBakeryState(tempBoolean)

func _on_upgradesButton_pressed():
	upgradesBakeryNodePath.visible = 1
	bakeryNodePath.visible = 0

	#Sending boolean var to camera to block panning
	var tmp = false
	cameraNodePath.setBakeryState(tmp)
	var tmp2 = true
	cameraNodePath.setUpgradesBakeryState(tmp2)


func _on_openSupervisors_pressed():
	$supervisorPanel.visible = 1
