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

#Button that starts the game !
func _on_next_pressed():
	
	if isOk && isAvatarSelected:
		$center/paper/fourthStep.visible = 0
		get_tree().change_scene("res://Scenes/GameManager.tscn")
		username.to_upper()
		globals.setUsername(username)
		save_load.preConditions['playedBefore'] = true
		applyFatherMerchantBonus()
		applyFatherHunterBonus()
		applyFatherThiefBonus()
		applyFatherFishingBonus()
		applyFatherFarmerBonus()
		applyYouthSThief()
		applyYouthServant()
		applyYouthApprenticeBonus()
		save_load.savePreconditions()
		save_load.save_resources()
		globals.resource_path = "user://"
		ingredients.resource_path = "user://"
		s_buildings.resource_path = "user://"
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

#First charCretion Step
func _on_firstNext_pressed():
	$center/paper/secondStep.show()
	$center/paper/firstStep.hide()


func _on_aNoble_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherNoble = true


func _on_aMerchant_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherMerchant = true


func _on_aHunter_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherHunter = true


func _on_aThief_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherThief = true

func _on_aFisher_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherAngler = true


func _on_aFarmer_pressed():
	$center/paper/secondStep.hide()
	$center/paper/thirdStep.show()
	globals.fatherFarmer = true


func _on_apprentice_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()
	globals.youthApprentice = true

func _on_servant_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()
	globals.youthServant = true


func _on_streetThief_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()
	globals.youthStreetThief = true

func _on_circusTrainee_pressed():
	$center/paper/thirdStep.hide()
	$center/paper/fourthStep.show()
	globals.youthCircusTrainee = true

func applyFatherMerchantBonus():
	if globals.fatherMerchant:
		for product in globals.arrayOfProducts:
			product.sellTime = product.sellTime - (product.sellTime * 0.05)
	
	
func applyFatherHunterBonus():
	if globals.fatherHunter:
		s_hunting.huntingTime = s_hunting.huntingTime - (s_hunting.huntingTime * 0.05)

func applyFatherThiefBonus():
	if globals.fatherThief:
		globals.breadAvalonia.addToProductCount(100)

func applyFatherFishingBonus():
	if globals.fatherAngler:
		s_fish.fishingTime = s_fish.fishingTime -  (s_fish.fishingTime * 0.05)

func applyFatherFarmerBonus():
	if globals.fatherFarmer:
		for ingredient in globals.arrayOfIngredients :
			ingredient.produceTime = ingredient.produceTime - (ingredient.produceTime * 0.05)

func applyYouthApprenticeBonus():
	if globals.youthApprentice:
		for x in s_upgrades.arrayOfUpgrades:
			x.cost = x.cost - (x.cost * 0.05)

func applyYouthSThief():
	if globals.youthStreetThief:
		for x in globals.arrayOfProducts:
			x.sellPrice = x.sellPrice + ( x.sellPrice * 0.05)
	
func applyYouthServant():
	if globals.youthServant:
		for x in s_buildings.buildingArray:
			x.cost = x.cost - (x.cost * 0.05)
