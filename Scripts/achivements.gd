extends Panel

onready var achivementsNodePath = get_node("/root/GameManager/UiCanvas/achivements")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")

var reward1 = 100
var isR1Claimed = false
var reward2 = 1000
var isR2Claimed = false
var reward3 = 2000
var isR3Claimed = false

func _ready():pass


func _on_checkAchivements_timeout():
	if globals.money >= 100 && !isR1Claimed:
		$ScrollContainer/VBoxContainer/a1/a1.disabled = 0
	else :
		$ScrollContainer/VBoxContainer/a1/a1.disabled = 1

	if globals.money >= 1000 && !isR2Claimed:
		$ScrollContainer/VBoxContainer/a2/a2.disabled = 0
	else:
		$ScrollContainer/VBoxContainer/a2/a2.disabled = 1

	if globals.money >= 2000 && !isR3Claimed:
		$ScrollContainer/VBoxContainer/a3/a3.disabled = 0
	else:
		$ScrollContainer/VBoxContainer/a3/a3.disabled = 1

func _on_close_pressed():
	achivementsNodePath.visible = 0
	var tempBoolean = false
	cameraNodePath.setAchievementsState(tempBoolean)


func _on_a1_pressed():
	globals.addToMoney(reward1)
	$ScrollContainer/VBoxContainer/a1/a1.disabled = 1
	$ScrollContainer/VBoxContainer/a1/a1/rewardCount.text = "Claimed"
	isR1Claimed = true


func _on_a2_pressed():
	globals.addToMoney(reward2)
	$ScrollContainer/VBoxContainer/a2/a2.disabled = 1
	$ScrollContainer/VBoxContainer/a2/a2/rewardCount.text = "Claimed"
	isR2Claimed = true
