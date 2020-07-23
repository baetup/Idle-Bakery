extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetProduct = "breadAvalonia"
var hasSupervisor = false
var unlockCost = globals.money * 0.9
var isProducingPossible = false

func _ready():
	UpdateUI()

func UpdateUI():
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).icon))
	$productCountLabel.text= str(globals.get(targetProduct).quantity)
	$levelCount.text = str(globals.get(targetProduct).bakeryProductLevel)
	$durationLabel.text = "%.1f" % ($bakeTimer.time_left) + "s"
	$bakeTimer.wait_time = globals.get(targetProduct).bakeTime
	$research/upgradeCost.text = "%.2f" % (globals.get(targetProduct).bakeryLevelCost)
	
	if globals.money < globals.get(targetProduct).bakeryLevelCost:
		$research.disabled = 1
	else:
		$research.disabled = 0
		
	#Checking if we have needed ingredients
	var temp = 0
	for x in globals.get(targetProduct).ingredients:
		if globals.get(targetProduct).ingredients[temp].quantity > 0:
			$productIcon.disabled = 0
			isProducingPossible = true
			temp = temp + 1
		else:
			isProducingPossible = false
			$productIcon.disabled = 1
	
	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0
		
	if hasSupervisor == false && !($bakeTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false) && isProducingPossible:
		$productIcon/Particles2D.visible = 1
	else:
		$productIcon/Particles2D.visible = 0 
	
	$unlockPanel/costLabel.text = str(unlockCost)
	$unlockPanel/productName.text = globals.get(targetProduct).name
	unlockCost = globals.money * 0.9


func _on_checkUi_timeout():
	UpdateUI()


func _on_bakeTimer_timeout():
	if hasSupervisor == true && isProducingPossible:
		$progressBar.set("value", 0.00)
		globals.get(targetProduct).addToProductCount(globals.get(targetProduct).produceAmount)
		
		#removing ingredients after baking
		var temp = 0
		for x in globals.get(targetProduct).ingredients:
			globals.get(targetProduct).ingredients[temp].removeQuantity(1)
			#Updating inventory for removing the ingredient
			if globals.get(targetProduct).ingredients[temp].quantity == 0:
				inventoryNodePath.removeItem()
				inventoryNodePath.checkAvailableItems()
				inventoryNodePath.setItems()
			temp = temp + 1
		
		#Updating inventory for producing
		if globals.get(targetProduct).quantity > 0:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()

	else: #the case when manually pressing the production icon
		$bakeTimer.stop()
		$progressTimer.stop()
		$progressBar.set("value", 0.00)
		$productIcon.disabled = 0 
		globals.get(targetProduct).addToProductCount(globals.get(targetProduct).produceAmount)
		
		#removing ingredients after baking
		var temp = 0
		for x in globals.get(targetProduct).ingredients:
			globals.get(targetProduct).ingredients[temp].removeQuantity(1)
			#Updating inventory for removing the ingredient
			if globals.get(targetProduct).ingredients[temp].quantity == 0:
				inventoryNodePath.removeItem()
				inventoryNodePath.checkAvailableItems()
				inventoryNodePath.setItems()
			temp = temp + 1

		#Updating inventory
		if globals.get(targetProduct).quantity > 0:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
	UpdateUI()

func _on_progressTimer_timeout():
	var current_progress = ($bakeTimer.wait_time - $bakeTimer.time_left) / $bakeTimer.wait_time 
	$progressBar.set("value", current_progress)
	UpdateUI()

func _on_research_pressed():
	if globals.money >= globals.get(targetProduct).bakeryLevelCost :
		globals.get(targetProduct).addBakeryProductLevel(1)
		globals.subFromMoney(globals.get(targetProduct).bakeryLevelCost)
		globals.get(targetProduct).setBakeryLevelCost(0.25)
		setBakeSpeed()
	UpdateUI()

func setBakeSpeed():
	globals.get(targetProduct).setBakeTime()
	$bakeTimer.wait_time = globals.get(targetProduct).bakeTime


func onHiredSupervisor():
	hasSupervisor = true
	$bakeTimer.start()
	$progressTimer.start()
	$bakeTimer.autostart = 1
	$progressTimer.autostart = 1
	$productIcon.disabled = 1

func _on_productIcon_pressed():
	$bakeTimer.start()
	$progressTimer.start()
	$bakeTimer.autostart = 0
	$progressTimer.autostart = 0
	$productIcon.disabled = 1

func _on_unlockBtn_pressed():
	globals.subFromMoney(unlockCost)
	globals.get(targetProduct).setIsUnlocked(true)
	$unlockPanel.visible = 0
