extends Panel

onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var shopBtn = $shopBtn
onready var supervisorBtn = $supervisorsBtn
onready var mainBuildingsCollider = get_node("/root/GameManager/villageAvalonia/buttonsCollider")

func _ready():
	supervisorBtn.material.set_shader_param('grayscale', true)

func _on_close_pressed():
	$".".visible = 0
	cameraNodePath.setStoreState(false)
	mainBuildingsCollider.showColliders()

func _on_supervisorsBtn_pressed():
	$supervisorPanel.show()
	$ScrollContainer.hide()
	supervisorBtn.material.set_shader_param('grayscale', false)
	shopBtn.material.set_shader_param('grayscale', true)

func _on_shopBtn_pressed():
	$supervisorPanel.hide()
	$ScrollContainer.show()
	shopBtn.material.set_shader_param('grayscale', false)
	supervisorBtn.material.set_shader_param('grayscale', true)
