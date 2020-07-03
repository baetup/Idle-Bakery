extends Node2D

onready var ingameOptionsNodePath = get_node("/root/GameManager/UiCanvas/ingameOptions")

func _on_fakeBtn_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/main_menu.tscn")

func _on_fakeBtnResume_pressed():
	ingameOptionsNodePath.visible = 0

func _on_soundBtn_pressed():
	if mainTheme.stream_paused == false:
		$soundBtn.set_normal_texture(load ("res://Image-assets/no-sound.png"))
		mainTheme.stream_paused = true
	elif mainTheme.stream_paused == true:
		$soundBtn.set_normal_texture(load ("res://Image-assets/sound-on.png"))
		mainTheme.stream_paused = false

