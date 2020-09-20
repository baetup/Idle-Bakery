extends Node2D

# !!! The texture buttons names containing the avatar should not be changed !

var username = "test"
var avatar = ""
var isOk = false #just a username length checker
var isAvatarSelected = false

func _ready():
	setAvatarConnections()

func _on_input_text_changed(new_text):
	if new_text.length() > 2:
		$center/paper/fourthStep/error.text = ""
		if new_text.length() < 17 :
			$center/paper/fourthStep/error.text = ""
			username = new_text
			isOk = true
		else:
			$center/paper/fourthStep/error.text = "Nickname too long"
	else:
		$center/paper/fourthStep/error.text = "Nickname too short"

func _on_next_pressed():
	
	if isOk && isAvatarSelected:
		$center/paper/fourthStep.visible = 0
		get_tree().change_scene("res://Scenes/GameManager.tscn")
		username.to_upper()
		globals.setUsername(username)
		save_load.preConditions['playedBefore'] = true
		save_load.savePreconditions()
		save_load.save_resources()
		globals.resource_path = "user://"
		ingredients.resource_path = "user://"
		s_upgrades.resource_path = "user://"
		s_fish.resource_path = "user://"
		s_hunting.resource_path = "user://"
	else:
		$center/paper/fourthStep/error.text = "Nickname too short or avatar not selected"

func setAvatarConnections():
	#connection button signals
	for x in $center/paper/fourthStep/GridContainer.get_children():
		x.connect("pressed", self, "setAvatar",[x.get_normal_texture(), x.get_name()])


func setAvatar(avatarPath, name):
	
	isAvatarSelected = true
	#allowing only one avatar to be selected
	for eachChild in $center/paper/fourthStep/GridContainer.get_children():
		if eachChild.get_name() != name:
			eachChild.pressed = false

	#set player gender
	if "mas" in name: #mas from masculin
		globals.setPlayerGender("male")
	elif "fem" in name: #fem from feminin
		globals.setPlayerGender("female")
	else:
		globals.setPlayerGender("other")

	#set avatar image
	avatar = avatarPath.get_load_path()
	globals.setAvatar(avatar)


func _on_firstNext_pressed():
	$center/paper/secondStep.show()
	$center/paper/firstStep.hide()


func _on_aNoble_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_aMerchant_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_aHunter_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_aThief_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_aFisher_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_aFarmer_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()


func _on_apprentice_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()


func _on_servant_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()


func _on_streetThief_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()


func _on_circusTrainee_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()
