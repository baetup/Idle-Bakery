extends Panel

onready var storeNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/store")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var upgradesNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesStore")

func _on_close_pressed():
	storeNodePath.visible = 0
	var tempBoolean = false
	cameraNodePath.setStoreState(tempBoolean)

func _on_upgradesBtn_pressed():
	storeNodePath.visible = 0
	upgradesNodePath.visible = 1

	#Sending boolean var to camera to stop panning
	var tmp = false
	cameraNodePath.setStoreState(tmp)
	var tmp2 = true
	cameraNodePath.setUpgradesStoreState(tmp2)

func _on_openSupervisors_pressed():
	$supervisorPanel.visible = 1
