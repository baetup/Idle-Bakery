extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetProduct = "breadAvalonia"
var unlockCost = globals.money * 0.8
export var isProducingPossible = true

func _ready():
	restartProductionOnLoad()
	UpdateUI()

func UpdateUI():
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).icon))
	$productCountLabel.text= str(globals.get(targetProduct).quantity)
	$levelCount.text = str(globals.get(targetProduct).bakeryProductLevel)
	$durationLabel.text = "%.1f" % ($bakeTimer.time_left) + "s"
	$bakeTimer.wait_time = globals.get(targetProduct).bakeTime
	$research/upgradeCost.text = "%.2f" % (globals.get(targetProduct).bakeryLevelCost)
	unlockCost = globals.money * 0.8
	
	#disable upgrade button if not enough money
	if globals.money < globals.get(targetProduct).bakeryLevelCost:
		$research.disabled = 1
	else:
		$research.disabled = 0
		

	#Checking if we have needed ingredients	
	if globals.get(targetProduct).ingredients[0].quantity > 0:

		$productIcon.disabled = 0
		isProducingPossible = true
		$productIcon/productIcon/productionStop.visible = 0
	else:
		isProducingPossible = false
		$bakeTimer.set_paused(true)
		$progressTimer.set_paused(true)
		$productIcon.disabled = 1
		$productIcon/productIcon/productionStop.visible = 1
		
	#restart baking process after ingredients become available again
	if isProducingPossible && $bakeTimer.is_paused():
		$bakeTimer.set_paused(false)
		$progressTimer.set_paused(false)

	#checking if the product is unlocked
	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0

	#checking when to show particles on product
	if globals.get(targetProduct)._get_has_bakery_supervisor() == false && !($bakeTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false) && isProducingPossible:
		$productIcon/Particles2D.visible = 1

	else:
		$productIcon/Particles2D.visible = 0


	$unlockPanel/costLabel.text = str(unlockCost)
	$unlockPanel/productName.text = globals.get(targetProduct).name
	unlockCost = globals.money * 0.9

func _on_checkUi_timeout():
	UpdateUI()

func _on_bakeTimer_timeout():
	if globals.get(targetProduct)._get_has_bakery_supervisor() && isProducingPossible:
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
		if globals.get(targetProduct).bakeryProductLevel == 8:
			globals.get(targetProduct).setBakeTimeMult(0.69)
		if globals.get(targetProduct).bakeryProductLevel == 22:
			globals.get(targetProduct).setBakeTimeMult(0.82)
		if globals.get(targetProduct).bakeryProductLevel == 35:
			globals.get(targetProduct).setBakeTimeMult(0.95)
	
		globals.get(targetProduct).addBakeryProductLevel()
		globals.subFromMoney(globals.get(targetProduct).bakeryLevelCost)
		globals.get(targetProduct).setBakeryLevelCost()
		globals.get(targetProduct).setBakeTime()
		setBakeSpeed()
	UpdateUI()

func setBakeSpeed():
	$bakeTimer.wait_time = globals.get(targetProduct).bakeTime

func onBakeryHiredSupervisor():
	globals.get(targetProduct).set_has_bakery_supervisor(true)
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

func _on_info_pressed():
	$ingredientPop.visible = 1
	
	for x in globals.get(targetProduct).ingredients:
		$ingredientPop/vbox.add_child(TextureRect.new())
	
	for child in $ingredientPop/vbox.get_children():
		child.add_child(Label.new())
	
	var temp = 0
	for child in $ingredientPop/vbox.get_children():
		child.set_texture(load(globals.get(targetProduct).ingredients[temp].icon))
		
		var tempHolder = child.get_children()
		for y in tempHolder:
			y.set_text(globals.get(targetProduct).ingredients[temp].name)
			y.anchor_left = 0.5
			y.anchor_top = 1
			y.anchor_right = 0.5
			y.anchor_bottom = 1
			y.margin_left = -20
			y.margin_top = 0
			y.margin_right = 19
			y.margin_bottom = 16
		temp += 1

func _on_ingredientPop_pressed():
	for x in $ingredientPop/vbox.get_children():
		$ingredientPop/vbox.remove_child(x)
		x.queue_free()
	$ingredientPop.visible = 0
	
func restartProductionOnLoad():
	if globals.get(targetProduct)._get_has_bakery_supervisor():
		$bakeTimer.start()
		$progressTimer.start()
		$bakeTimer.autostart = 1
		$progressTimer.autostart = 1
		$productIcon.disabled = 1

