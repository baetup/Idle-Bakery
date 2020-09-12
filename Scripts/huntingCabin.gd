extends Control

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")

func _ready():
	ui()


func ui():
	$huntingTimer.wait_time = s_hunting.huntingTime
	$huntingBtn/levelBkgr/levelCost.text = shortenMoney.shortenMoney(s_hunting.huntingLevelCost)
	$huntingBtn/levelBkgr/levelCount.text = str(s_hunting.huntingLevel)

func _on_huntingBtn_pressed():
	$huntingBtn/progressBarBody.show()
	$huntingTimer.start()
	$progressTimer.start()
	$huntingTimer.autostart = 0
	$progressTimer.autostart = 0
	$huntingBtn.disabled = 1

func _on_progressTimer_timeout():
	var current_progress = ($huntingTimer.wait_time - $huntingTimer.time_left) / $huntingTimer.wait_time 
	$huntingBtn/progressBarBody/progressBar.set("value", current_progress)
	ui()


func _on_huntingTimer_timeout():
	$huntingTimer.stop()
	$progressTimer.stop()
	$huntingBtn/progressBarBody/progressBar.set("value", 0.00)
	$huntingBtn.disabled = 0
	$huntingBtn/progressBarBody.hide()
	retrieveMeat()

func retrieveMeat():
	var villageName = $".".owner.name

	if villageName == "villageAvalonia":
		for x in 2:
			var rand_index : int = randi() % s_hunting.avaloniaMeatArr.size()
			var maxAmount = s_hunting.avaloniaMeatArr[rand_index].maxAmount
			var minAmount = s_hunting.avaloniaMeatArr[rand_index].minAmount
			var randomAmount = randi() % (maxAmount - minAmount  + 1) + minAmount
			s_hunting.avaloniaMeatArr[rand_index].addQuantity(randomAmount)
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()


func _on_upgradehunting_pressed():
	if globals.money >= s_hunting.huntingLevelCost:
		globals.subFromMoney(s_hunting.huntingLevelCost)
		s_hunting.huntingLevel += 1
		s_hunting.setHuntingLevelCost()
		s_hunting.set_hunting_time()
		
		#increase the max amount of all fishes
		for meat in s_hunting.avaloniaMeatArr:
			meat.setMeatMaxAmount()
		
		ui()
