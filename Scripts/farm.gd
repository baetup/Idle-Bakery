extends Control

onready var mainBuildingsCollider = get_node("/root/GameManager/villageAvalonia/buttonsCollider")

func _on_close_pressed():
	$".".visible = 0
	mainBuildingsCollider.showColliders()
