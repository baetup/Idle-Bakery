extends Node

func _ready():
	playedBeforeCheck()

func _on_play_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/charCreation.tscn")

func _on_options_pressed():
	$vbox/play.visible = 0
	$vbox/options.visible = 0
	$vbox/exit.visible = 0
	$optionsModal.visible = 1

func _on_exit_pressed():
	get_tree().quit()

func playedBeforeCheck() -> void:
	if save_load.preConditions['playedBefore'] == true:
		$vbox/play/playLabel.text = "Continue".to_upper()
		$vbox/play.disconnect("pressed", self, "_on_play_pressed")
		$vbox/play.connect("pressed",self,"_on_continue_pressed")
		
func _on_continue_pressed():
	globals.resource_path = "user://"
	ingredients.resource_path = "user://"
	s_upgrades.resource_path = "user://"
	s_fish.resource_path = "user://"
	s_hunting.resource_path = "user://"
	s_buildings.resource_path = "user://"
	s_army.resource_path = "user://"
	s_villages.resource_path = "user://"
	save_load.load_data()
	
	s_hunting.loadResource()
	s_fish.loadResource()
	ingredients.loadResource()
	globals.loadResource()
	s_upgrades.loadResource()
	s_buildings.loadResource()
	s_army.load_resource()
	s_villages.load_resource()


	
	get_tree().change_scene("res://Scenes/GameManager.tscn")
	
