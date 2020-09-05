extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	updateUi()

func updateUi():
	pass

func _on_checkUi_timeout():
	updateUi()


func _on_upgradesButton_pressed():
	$upgradesBkgr.visible = 1
	$upgradesBtnBkgr.set_texture(load("res://Image-assets/title blue-no-text.png"))
	$farmBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$farmBkgr.visible = 0

func _on_farmButton_pressed():
	$farmBkgr.visible = 1
	$farmBtnBkgr.set_texture(load("res://Image-assets/title blue-no-text.png"))
	$upgradesBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$upgradesBkgr.visible = 0


func _on_close_pressed():
	$".".visible = 0
