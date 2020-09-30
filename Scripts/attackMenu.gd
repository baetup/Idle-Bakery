extends TextureRect

var targetVillage = ""
var bowmenDuration = ""
var spearmanDuration =""
var lightCavalryDuration = ""
var attackingTroops = 0

func ui(village):
	$label.text = "Attack " + s_villages.get(village).type
	targetVillage = village
	$grid/troop/totalAmount/actualAmount.text = str(s_army.avaloniaBowman.count)
	$grid/troop/bowmenAmount.max_value = s_army.avaloniaBowman.count
	$movementDuration/actualDuration.text = "0 sec"


func _on_closeAttackMenu_pressed():
	$".".hide()


func _on_bowmenAmount_value_changed(value):
	bowmenDuration = calculateDistance() * s_army.avaloniaBowman.speed
	$movementDuration/actualDuration.text = str(bowmenDuration) + " sec"
	attackingTroops += $grid/troop/bowmenAmount.value

func calculateDistance():
	var targetX = s_villages.get(targetVillage).xCoord
	var targetY = s_villages.get(targetVillage).yCoord
	if targetX < 0:
		targetX *= -1
	if targetY < 0 :
		targetY *= -1
	var cellDiff = targetX + targetY
	return cellDiff



func _on_attack_pressed():
	if attackingTroops > 0 :
		pass
