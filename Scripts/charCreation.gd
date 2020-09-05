extends Node2D

# !!! The texture buttons names containing the avatar should not be changed !

var username = "test"
var avatar = ""
var isOk = false #just a username length checker

func _ready():
	setAvatarConnections()

func _on_introText2_gui_input(event):
	if event is InputEventScreenTouch:
		$paper/firstStep.visible = 0
		$paper/secondStep.visible = 1

func _on_input_text_changed(new_text):
	if new_text.length() > 2:
		$paper/secondStep/error.text = ""
		if new_text.length() < 13 :
			$paper/secondStep/error.text = ""
			username = new_text
			isOk = true
		else:
			$paper/secondStep/error.text = "Nickname too long"
	else:
		$paper/secondStep/error.text = "Nickname too short"

func _on_next_pressed():
	$paper/secondStep.visible = 0
	if isOk == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/GameManager.tscn")
		globals.setUsername(username)
	save_load.preConditions['playedBefore'] = true
	save_load.savePreconditions()
	
	save_load.save_resources()
	globals.resource_path = "user://"
	ingredients.resource_path = "user://"



func setAvatarConnections():
	#connection button signals
	for x in $paper/secondStep/GridContainer.get_children():
		x.connect("pressed", self, "setAvatar",[x.get_normal_texture(), x.get_name()])


func setAvatar(avatarPath, name):
	
	#allowing only one avatar to be selected
	for eachChild in $paper/secondStep/GridContainer.get_children():
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
