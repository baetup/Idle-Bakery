extends Node

func _on_play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/GameManager.tscn")

func _on_options_pressed():
	$play.visible = 0
	$options.visible = 0
	$exit.visible = 0
	$optionsModal.visible = 1

func _on_exit_pressed():
	get_tree().quit()
