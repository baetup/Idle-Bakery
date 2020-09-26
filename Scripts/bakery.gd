extends Panel

onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var bakeryBtn = $bakeryBtn
onready var supervisorBtn = $supervisorsBtn
onready var mainBuildingsCollider = get_node("/root/GameManager/villageAvalonia/buttonsCollider")


export var targetBakery = "avaloniaBakery"

func _ready():
	supervisorBtn.material.set_shader_param('grayscale', true)

func _on_close_bakery_pressed():
	$".".visible = 0
	cameraNodePath.setBakeryState(false)
	mainBuildingsCollider.showColliders()


func _on_supervisorsBtn_pressed():
	$supervisorPanel.show()
	$productScroll.hide()
	bakeryBtn.material.set_shader_param("grayscale", true)
	supervisorBtn.material.set_shader_param("grayscale", false)

	
func _on_bakeryBtn_pressed():
	$supervisorPanel.hide()
	$productScroll.show()
	supervisorBtn.material.set_shader_param("grayscale", true)
	bakeryBtn.material.set_shader_param("grayscale", false)
