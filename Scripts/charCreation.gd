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
		$paper/thirdStep/error.text = ""
		if new_text.length() < 13 :
			$paper/thirdStep/error.text = ""
			username = new_text
			isOk = true
		else:
			$paper/thirdStep/error.text = "Nickname too long"
	else:
		$paper/thirdStep/error.text = "Nickname too short"

func _on_next_pressed():
	$paper/secondStep.visible = 0
	$paper/thirdStep.visible = 1

func _on_next2_pressed():
	if isOk == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/GameManager.tscn")
		globals.setUsername(username)

func setAvatarConnections():
	for x in $paper/secondStep/GridContainer.get_children():
		x.connect("pressed", self, "setAvatar",[x.get_normal_texture(), x.get_name()])


func setAvatar(avatarPath, name):
	
	for x in $paper/secondStep/GridContainer.get_children():
		if x.get_name() != name:
			x.pressed = false
	
	#set player gender
	if "mas" in name: #mas from masculin
		S_castle.setPlayerGender("male")
	elif "fem" in name: #fem from feminin
		S_castle.setPlayerGender("female")
	else:
		S_castle.setPlayerGender("other")
	
	#set avatar image
	avatar = avatarPath.get_load_path()
	globals.setAvatar(avatar)
