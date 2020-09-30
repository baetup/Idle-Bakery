extends Node2D

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
var isProducing = false

func _ready():
	ui()


func ui():
	$fishTimer.wait_time = s_fish.fishingTime
	$fisheryBtn/levelBkgr/levelCost.text = str(shortenMoney.short(s_fish.fishingLevelCost))
	$fisheryBtn/levelBkgr/levelCount.text = str(s_fish.fishingLevel)

func _on_fisheryBtn_pressed():
	if isProducing == false:
		isProducing = true
		$fisheryBtn/progressBarBody.show()
		$fishTimer.start()
		$progressTimer.start()
		$fishTimer.autostart = 0
		$progressTimer.autostart = 0
		$fisheryBtn.material.set_shader_param('grayscale', true)

func _on_progressTimer_timeout():
	var current_progress = ($fishTimer.wait_time - $fishTimer.time_left) / $fishTimer.wait_time 
	$fisheryBtn/progressBarBody/progressBar.set("value", current_progress)
	ui()


func _on_fishTimer_timeout():
	isProducing = false
	$fishTimer.stop()
	$progressTimer.stop()
	$fisheryBtn/progressBarBody/progressBar.set("value", 0.00)
	$fisheryBtn.material.set_shader_param('grayscale', false)
	$fisheryBtn/progressBarBody.hide()
	retrieveFish()

func retrieveFish():
	var villageName = $".".owner.name

	if villageName == "villageAvalonia":
		for x in 2:
			var rand_index : int = randi() % s_fish.avaloniaFishArr.size()
			var maxAmount = s_fish.avaloniaFishArr[rand_index].maxAmount
			var minAmount = s_fish.avaloniaFishArr[rand_index].minAmount
			var randomAmount = randi() % (maxAmount - minAmount  + 1) + minAmount
			s_fish.avaloniaFishArr[rand_index].addQuantity(randomAmount)
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()


func _on_upgradefishery_pressed():
	if globals.money >= s_fish.fishingLevelCost:
		globals.subFromMoney(s_fish.fishingLevelCost)
		s_fish.fishingLevel += 1
		s_fish.setFishingLevelCost()
		s_fish.set_fishing_time()
		
		#increase the max amount of all fishes
		for fish in s_fish.avaloniaFishArr:
			fish.setFishMaxAmount()
		
		ui()
