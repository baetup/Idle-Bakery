extends Control


onready var colliders = get_node("/root/GameManager/villageAvalonia/buttonsCollider")


func _ready():
	ui()

func ui():
	$panelBkgr/longBowmanCount.text = "Longbows: " + str(s_army.avaloniaLB.count)
	$panelBkgr/bowmanCount.text = "Bowmen: " + str(s_army.avaloniaBowman.count)

func _on_closeArchery_pressed():
	$".".hide()
	colliders.showColliders()
	colliders.showSecondaryColliders()
