extends Panel


onready var storeNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/store")
onready var upgradesNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesStore")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_shopBtn_pressed():
	upgradesNodePath.visible = 0
	storeNodePath.visible = 1
	
	#Sending boolean var to camera to stop panning
	var tmp = false
	cameraNodePath.setUpgradesStoreState(tmp)
	var tmp2 = true
	cameraNodePath.setStoreState(tmp2)

func _on_close_pressed():
	upgradesNodePath.visible = 0
	
	#Sending boolean var to camera to stop panning
	var tmp = false
	cameraNodePath.setUpgradesStoreState(tmp)
