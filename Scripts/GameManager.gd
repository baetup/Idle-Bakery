extends Node

var moneyLabel = ""
onready var charPanelNodePath = get_node("/root/GameManager/UiCanvas/charPanel")
onready var prestigeBarNodePath = get_node("/root/GameManager/UiCanvas/charPanel/prestigeBar")
onready var prestigeLevelNodePath = get_node("/root/GameManager/UiCanvas/charPanel/prestigeLevelLabel/prestigeLevel")
onready var charPointsNodePath = get_node("/root/GameManager/UiCanvas/charPanel/charPointsLabel/charPoints")
onready var worldMapNodePath = get_node("/root/GameManager/worldMap")
onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
onready var buildingsBtns = get_node("/root/GameManager/villageAvalonia/incomeBuildings")
onready var buildingsColliders = get_node("/root/GameManager/villageAvalonia/buttonsCollider")
onready var battleTimer = get_node("/root/GameManager/worldMap/canvas/attackMenu/battleTimer")

var cameraZoomRate = Vector2(0.2, 0.2)
var avatar = globals.avatar
var areBuildingsOn = true

func _ready():
	inventoryNodePath.checkAvailableItems()
	inventoryNodePath.setItems()
	UpdateUI()

func _process(delta):
	if s_army.battleInProgess :
		$UiCanvas/battleDetails/timeInfo.text = "Time until battle: " + str(timeCalculus.calculate(battleTimer.time_left))


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT || what == MainLoop.NOTIFICATION_CRASH || what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST || what == NOTIFICATION_EXIT_TREE || what == NOTIFICATION_WM_QUIT_REQUEST :
		save_load.save_data()
		save_load.save_resources()


func UpdateUI():
	$UiCanvas/charPanelBtn/charNameBkgr/charName.text = globals.username
	$UiCanvas/charPanelBtn.set_normal_texture(load(avatar))
	

func _on_updateUi_timeout():
	moneyLabel = shortenMoney.short(globals.money)
	$UiCanvas/moneyLabel.text = moneyLabel

func setPrestigeLevel(buildingCost, buildingExp):
	globals.subFromMoney(buildingCost)
	if buildingExp >= globals.neededExp: # Leveled UP
		globals.curExp = globals.curExp +  buildingExp - globals.neededExp
		prestigeBarNodePath.value = globals.curExp
		globals.prestigeLevel += 1
		globals.charPoints += 1
		charPanelNodePath.checkForCharPoints()

		globals.neededExp = globals.neededExp * 2
		prestigeBarNodePath.max_value = globals.neededExp
		prestigeLevelNodePath.text = str(globals.prestigeLevel)
		charPointsNodePath.text = str(globals.charPoints)

	else: # Didnt level UP
		globals.curExp = globals.curExp + buildingExp
		prestigeBarNodePath.value = globals.curExp
	
func _on_achivementsButton_pressed():
	$UiCanvas/achivements.visible = 1
	var tempBoolean = true
	$Camera2D.setAchievementsState(tempBoolean)

func _on_charPanelBtn_pressed():
	$UiCanvas/charPanel.visible = 1

func _on_options_pressed():
	$UiCanvas/ingameOptions.visible = 1

func _on_worldMapBtn_pressed():
	$UiCanvas/ColorRect.visible = true
	$UiCanvas/ColorRect/AnimationPlayer.play("fade-in")
	var t = Timer.new()
	t.set_wait_time(0.4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$Camera2D.getLastLocation(false, true)
	$Camera2D.getRootScreen("worldMap")
	$Camera2D.setCameraLimits("worldMap")
	$villageAvalonia.visible = 0
	$worldMap.visible = 1
	$UiCanvas/ColorRect/AnimationPlayer.play("fade-out")
	var t2 = Timer.new()
	t2.set_wait_time(0.5)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	$UiCanvas/ColorRect.visible = false
	
	#disabling village collisions
	get_node("/root/GameManager/villageAvalonia/buttonsCollider").hideColliders()
	get_node("/root/GameManager/villageAvalonia/buttonsCollider").hideSecondaryColliders()
	
	worldMapNodePath.enableWorldMapCollisions()


func _on_inventoryButton_pressed():
	$UiCanvas/inventorySystem.visible = 1
	inventoryNodePath.checkAvailableItems()
	inventoryNodePath.setItems()

func _on_dayCounter_timeout():
	globals.day += 1

func _on_notifications_pressed():
	$UiCanvas/notificationPanel.visible = 1

func reopenWindows(window):
	get_node(window).visible = 1


func _on_buildings_pressed():
	if areBuildingsOn :
		areBuildingsOn = false
		buildingsBtns.hide()
		buildingsColliders.hideSecondaryColliders()
		$UiCanvas/buildings.material.set_shader_param("grayscale", true)
	else:
		areBuildingsOn = true
		buildingsBtns.show()
		buildingsColliders.showSecondaryColliders()
		$UiCanvas/buildings.material.set_shader_param("grayscale", false)


func _on_battleNotification_pressed():
	$UiCanvas/battleDetails.show()
	$UiCanvas/battleDetails/info.text = s_army.battleDetails
	$UiCanvas/battleDetails/timeInfo.text = str(timeCalculus.calculate(s_army.battleTimer))
	buildingsColliders.hideColliders()
	buildingsColliders.hideSecondaryColliders()


func _on_close_battleDetails_pressed():
	$UiCanvas/battleDetails.hide()
	if $Camera2D.rootScreen == "village":
		buildingsColliders.showColliders()
		buildingsColliders.showSecondaryColliders()
	elif $Camera2D.rootScreen == "worldMap":
		$worldMap.enableWorldMapCollisions()
