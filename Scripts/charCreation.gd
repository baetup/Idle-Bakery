extends Node2D

var username = "test"
var avatar = ""
var isOk = false

func _on_introText2_gui_input(event):
	if event is InputEventScreenTouch:
		$paper/firstStep.visible = 0
		$paper/secondStep.visible = 1

func _on_input_text_changed(new_text):
	if new_text.length() > 2:
		$paper/thirdStep/error.text = ""
		if new_text.length() < 13 :
			$paper/thirdStep/error.text = ""
			username = new_text
			isOk = true
		else:
			$paper/thirdStep/error.text = "Nickname too long"
	else:
		$paper/thirdStep/error.text = "Nickname too short"

func _on_TextureButton2_pressed():
	avatar = "res://Image-assets/charPanel-female.png"
	globals.setAvatar(avatar)

func _on_next_pressed():
	$paper/secondStep.visible = 0
	$paper/thirdStep.visible = 1

func _on_next2_pressed():
	if isOk == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/GameManager.tscn")
		globals.setUsername(username)
