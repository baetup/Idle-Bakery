extends CenterContainer

onready var worldMap = get_node("/root/GameManager/worldMap")

var targetVillage = ""
var bowmenDuration = ""
var lbDuration =""
var hcDuration = ""
var knightDuration = ""
var spManDuration = ""
var swManDuration = ""
var lcDuration = ""
var totalDuration = 0
var attackingTroops = 0

var insertedBowmen = 0
var insertedLB = 0
var insertedHC = 0
var insertedKnight = 0
var insertedSp = 0
var insertedSw = 0
var insertedLC = 0

var isBowmenInserted = false
var isLbInserted = false
var isHcInserted = false
var isKnightInserted = false
var isSpManInserted = false
var isSwManInserted = false
var isLcInserted = false

func showAttackMenu(village):
	targetVillage = village
	$".".show()
	$attackMenuBkgr/label.text = "Attack " + s_villages.get(targetVillage).type

func _ready():
	ui()

func ui():
	updateTroopsAmount()
	$attackMenuBkgr/movementDuration/actualDuration.text = "0 sec"

func updateTroopsAmount():
	#bowmen
	$attackMenuBkgr/ScrollContainer/troopsBox/bowman/details/troopName.text = s_army.avaloniaBowman.name
	$attackMenuBkgr/ScrollContainer/troopsBox/bowman/details/owned/actualOwned.text = str(s_army.avaloniaBowman.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/bowman/details/bowmenInput.max_value = s_army.avaloniaBowman.count
	$attackMenuBkgr/ScrollContainer/troopsBox/bowman/details/bowmenInput.value = insertedBowmen
	
	#lb
	$attackMenuBkgr/ScrollContainer/troopsBox/lb/details/troopName.text = s_army.avaloniaLB.name
	$attackMenuBkgr/ScrollContainer/troopsBox/lb/details/owned/actualOwned.text = str(s_army.avaloniaLB.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/lb/details/lbInput.max_value = s_army.avaloniaLB.count
	$attackMenuBkgr/ScrollContainer/troopsBox/lb/details/lbInput.value = insertedLB
	
	#hc
	$attackMenuBkgr/ScrollContainer/troopsBox/hc/details/troopName.text = s_army.avaloniaHC.name
	$attackMenuBkgr/ScrollContainer/troopsBox/hc/details/owned/actualOwned.text = str(s_army.avaloniaHC.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/hc/details/hcInput.max_value = s_army.avaloniaHC.count
	$attackMenuBkgr/ScrollContainer/troopsBox/hc/details/hcInput.value = insertedHC
	
	#knight
	$attackMenuBkgr/ScrollContainer/troopsBox/knight/details/troopName.text = s_army.avaloniaKnight.name
	$attackMenuBkgr/ScrollContainer/troopsBox/knight/details/owned/actualOwned.text = str(s_army.avaloniaKnight.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/knight/details/knightInput.max_value = s_army.avaloniaKnight.count
	$attackMenuBkgr/ScrollContainer/troopsBox/knight/details/knightInput.value = insertedKnight
	
	
	#spMan
	$attackMenuBkgr/ScrollContainer/troopsBox/spMan/details/troopName.text = s_army.avaloniaSpMan.name
	$attackMenuBkgr/ScrollContainer/troopsBox/spMan/details/owned/actualOwned.text = str(s_army.avaloniaSpMan.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/spMan/details/spInput.max_value = s_army.avaloniaSpMan.count
	$attackMenuBkgr/ScrollContainer/troopsBox/spMan/details/spInput.value = insertedSp
	
	#swMan
	$attackMenuBkgr/ScrollContainer/troopsBox/swMan/details/troopName.text = s_army.avaloniaSwMan.name
	$attackMenuBkgr/ScrollContainer/troopsBox/swMan/details/owned/actualOwned.text = str(s_army.avaloniaSwMan.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/swMan/details/swInput.max_value = s_army.avaloniaSwMan.count
	$attackMenuBkgr/ScrollContainer/troopsBox/swMan/details/swInput.value = insertedSw
	
	#lc
	$attackMenuBkgr/ScrollContainer/troopsBox/lc/details/troopName.text = s_army.avaloniaLC.name
	$attackMenuBkgr/ScrollContainer/troopsBox/lc/details/owned/actualOwned.text = str(s_army.avaloniaLC.count)
	$attackMenuBkgr/ScrollContainer/troopsBox/lc/details/lcInput.max_value = s_army.avaloniaLC.count
	$attackMenuBkgr/ScrollContainer/troopsBox/lc/details/lcInput.value = insertedLC
	

func _on_closeAttackMenu_pressed():
	resetAttackMenu()
	$".".hide()
	worldMap.enableWorldMapCollisions()

func resetAttackMenu():
	bowmenDuration = 0
	lbDuration = 0
	knightDuration = 0
	spManDuration = 0
	swManDuration = 0
	hcDuration = 0
	lcDuration = 0
	totalDuration = 0
	
	isBowmenInserted = false
	isLbInserted = false
	isHcInserted = false
	isKnightInserted = false
	isSpManInserted = false
	isSwManInserted = false
	isLcInserted = false
	
	insertedBowmen = 0
	insertedLB = 0
	insertedHC = 0
	insertedKnight = 0
	insertedSp = 0
	insertedSw = 0
	insertedLC = 0
	
	updateAttackingTroopsAmount()
	updateTroopsAmount()
	ui()

func calculateDistance():
	var targetX = s_villages.get(targetVillage).xCoord
	var targetY = s_villages.get(targetVillage).yCoord
	if targetX < 0:
		targetX *= -1
	if targetY < 0 :
		targetY *= -1
	var cellDiff = targetX + targetY
	return cellDiff



func updateAttackingTroopsAmount():
	attackingTroops = insertedBowmen + insertedHC + insertedKnight + insertedLB + insertedLC + insertedSp + insertedSw

func _on_bowmenInput_value_changed(value):
	insertedBowmen = value
	if isBowmenInserted == false:
		bowmenDuration = calculateDistance() * s_army.avaloniaBowman.speed
		totalDuration += bowmenDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isBowmenInserted = true
	if value == 0:
		isBowmenInserted = false
		totalDuration -= bowmenDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()


func _on_lbInput_value_changed(value):
	insertedLB = value
	if isLbInserted == false:
		lbDuration = calculateDistance() * s_army.avaloniaLB.speed
		totalDuration += lbDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isLbInserted = true
	if value == 0:
		isLbInserted = false
		totalDuration -= lbDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()

func _on_hcInput_value_changed(value):
	insertedHC = value
	if isHcInserted == false:
		hcDuration = calculateDistance() * s_army.avaloniaHC.speed
		totalDuration += hcDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isHcInserted = true
	if value == 0:
		isHcInserted = false
		totalDuration -= hcDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()

func _on_knightInput_value_changed(value):
	insertedKnight = value
	if isKnightInserted == false:
		knightDuration = calculateDistance() * s_army.avaloniaKnight.speed
		totalDuration += knightDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isKnightInserted = true
	if value == 0:
		isKnightInserted = false
		totalDuration -= knightDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()

func _on_spInput_value_changed(value):
	insertedSp = value
	if isSpManInserted == false:
		spManDuration = calculateDistance() * s_army.avaloniaSpMan.speed
		totalDuration += spManDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isSpManInserted = true
	if value == 0:
		isSpManInserted = false
		totalDuration -= spManDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()

func _on_swInput_value_changed(value):
	insertedSw = value
	if isSwManInserted == false:
		swManDuration = calculateDistance() * s_army.avaloniaSwMan.speed
		totalDuration += swManDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isSwManInserted = true
	if value == 0:
		isSwManInserted = false
		totalDuration -= swManDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()


func _on_lcInput_value_changed(value):
	insertedLC = value
	if isLcInserted == false:
		lcDuration = calculateDistance() * s_army.avaloniaLC.speed
		totalDuration += lcDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)
	if value > 0:
		isLcInserted = true
	if value == 0:
		isLcInserted = false
		totalDuration -= lcDuration
		$attackMenuBkgr/movementDuration/actualDuration.text = timeCalculus.calculate(totalDuration)		
	updateAttackingTroopsAmount()


func _on_pre_attackBtn_pressed():
	$attackMenuBkgr.show()
	$pre_attackMenuBkgr.hide()


func _on_attack_pressed():
	if attackingTroops > 0 :
		pass

func _on_close_preMenu_pressed():
	$".".hide()
