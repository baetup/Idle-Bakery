extends Node

func _ready():
	print(save_load.preConditions['playedBefore'])
	playedBeforeCheck()

func _on_play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/charCreation.tscn")

func _on_options_pressed():
	$play.visible = 0
	$options.visible = 0
	$exit.visible = 0
	$optionsModal.visible = 1

func _on_exit_pressed():
	get_tree().quit()

func playedBeforeCheck():
	if save_load.preConditions['playedBefore'] == true:
		$play/playLabel.text = "Continue"
		$play.disconnect("pressed", self, "_on_play_pressed")
		$play.connect("pressed",self,"_on_continue_pressed")
		
func _on_continue_pressed():
	save_load.load_data()
	get_tree().change_scene("res://Scenes/GameManager.tscn")
	
