extends Panel

onready var charPanelNodePath = get_node("/root/GameManager/UiCanvas/charPanel")
onready var charPanelBtnNodePath = get_node("/root/GameManager/UiCanvas/charPanelBtn")

var pointsSpent = 0
var pointsSpentCun = 0
var pointsSpentChr = 0
var pointsSpentInt = 0
var pointsSpentInv = 0

func _ready():
	UpdateUi()
	checkForCharPoints()
	canRevertPoints()
	
func UpdateUi():
	$panelTitle/username.text = globals.username
	$avatar/avatarImage.set_texture(load(globals.avatar))
	$prestigeLevelLabel/prestigeLevel.text = str(globals.prestigeLevel)
	$traitsContainer/cunLabel/cun.text= str(globals.cunStat)
	$traitsContainer/chrLabel/chr.text= str(globals.chrStat)
	$traitsContainer/intLabel/int.text= str(globals.intStat)
	$traitsContainer/invLabel/inv.text= str(globals.invStat)
	$charPointsLabel/charPoints.text = str(globals.charPoints)
	checkForCharPoints()
	
func _on_save_pressed():
	charPanelNodePath.visible = 0
	pointsSpent = 0
	pointsSpentCun = 0
	pointsSpentChr = 0
	pointsSpentInt = 0
	pointsSpentInv = 0
	canRevertPoints()

func checkForCharPoints():
	if globals.charPoints > 0:
		$traitsContainer/chrLabel/addStat.disabled = 0
		$traitsContainer/cunLabel/addStat.disabled = 0
		$traitsContainer/intLabel/addStat.disabled = 0
		$traitsContainer/invLabel/addStat.disabled = 0
	else:
		$traitsContainer/chrLabel/addStat.disabled = 1
		$traitsContainer/cunLabel/addStat.disabled = 1
		$traitsContainer/intLabel/addStat.disabled = 1
		$traitsContainer/invLabel/addStat.disabled = 1

func canRevertPoints():
	if pointsSpent > 0:
		$charPointsLabel/revertPoints.visible = 1
	else:
		$charPointsLabel/revertPoints.visible = 0

func _on_addStatCun_pressed():
	globals.charPoints = globals.charPoints - 1
	pointsSpent += 1
	pointsSpentCun += 1
	globals.cunStat += 1
	checkForCharPoints()
	canRevertPoints()
	UpdateUi()

func _on_addStatChr_pressed():
	globals.charPoints = globals.charPoints - 1
	pointsSpent += 1
	pointsSpentChr += 1
	globals.chrStat += 1
	checkForCharPoints()
	canRevertPoints()
	UpdateUi()

func _on_addStatInt_pressed():
	globals.charPoints = globals.charPoints - 1
	pointsSpent += 1
	pointsSpentInt += 1
	globals.intStat += 1
	checkForCharPoints()
	canRevertPoints()
	UpdateUi()

func _on_addStatInv_pressed():
	globals.charPoints = globals.charPoints - 1
	pointsSpent += 1
	pointsSpentInv += 1
	globals.invStat += 1
	checkForCharPoints()
	canRevertPoints()
	UpdateUi()

func _on_revertPoints_pressed():
	globals.charPoints = globals.charPoints + pointsSpent
	pointsSpent = 0
	checkForCharPoints()
	$charPointsLabel/revertPoints.visible = 0
	globals.cunStat -= pointsSpentCun
	pointsSpentCun = 0
	globals.chrStat -= pointsSpentChr
	pointsSpentChr = 0
	globals.intStat -= pointsSpentInt
	pointsSpentInt = 0
	globals.invStat -= pointsSpentInv
	pointsSpentInv = 0
	UpdateUi()

func _on_cunInfo_pressed():
	$cunPop.popup()

func _on_chrInfo_pressed():
	$chrPop.popup()

func _on_intInfo_pressed():
	$intPop.popup()

func _on_invInfo_pressed():
	$invPop.popup()
