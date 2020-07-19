extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetProduct = "breadAvalonia"
var isSellingPossible = false
var hasSupervisor = false


func _ready():
	$saleTimer.wait_time = globals.get(targetProduct).sellTime
	UpdateUI()

func UpdateUI():
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).productIcon))
	$productCountLabel.text= str(globals.get(targetProduct).productCount)
	$levelCount.text = str(globals.get(targetProduct).storeProductLevelCount)
	$durationLabel.text = "%.1f" % ($saleTimer.time_left) + "s"
	$research/upgradeCost.text = "%.2f" % (globals.get(targetProduct).storeLevelCost)

	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0

	if hasSupervisor == false && !($saleTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false) && globals.get(targetProduct).productCount > 0:
		$productIcon/Particles2D.visible = 1
	else:
		$productIcon/Particles2D.visible = 0 

	$unlockPanel/productName.text = globals.get(targetProduct).productName

func inLineTimer(time):
	yield(get_tree().create_timer(time), "timeout")


func _on_checkUi_timeout():

	if globals.money < globals.get(targetProduct).storeLevelCost:
		$research.disabled = 1
	else:
		$research.disabled = 0
	UpdateUI()



func _on_productIcon_pressed():
	if globals.get(targetProduct).productCount > 0:
		$saleTimer.start()
		$progressTimer.start()
		$saleTimer.autostart = 0
		$progressTimer.autostart = 0
		$productIcon.disabled = 1



func _on_saleTimer_timeout():
	if hasSupervisor == true && globals.get(targetProduct).productCount > 0 && isSellingPossible == true:
		$progressBar.set("value", 0.00)
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)
		if globals.get(targetProduct).productCount == 0:
			inventoryNodePath.removeItem()
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
		else:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()


	elif hasSupervisor == false && globals.get(targetProduct).productCount > 0 && isSellingPossible == true:
		$saleTimer.stop()
		$progressTimer.stop()
		$progressBar.set("value", 0.00)
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)
		$productIcon.disabled = 0 
		if globals.get(targetProduct).productCount == 0:
			inventoryNodePath.removeItem()
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
		else:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
		
	elif !(globals.get(targetProduct).productCount > 0):
		isSellingPossible = false
		$progressTimer.stop()


	if isSellingPossible == false && globals.get(targetProduct).productCount > 0 :
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)
		isSellingPossible = true
		if globals.get(targetProduct).productCount == 0:
			inventoryNodePath.removeItem()
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
		else:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
		$progressTimer.start()
		$saleTimer.start()


	UpdateUI()

func _on_progressTimer_timeout():
	var current_progress = ($saleTimer.wait_time - $saleTimer.time_left) / $saleTimer.wait_time 
	$progressBar.set("value", current_progress)
	UpdateUI()

func _on_close_pressed():
	$".".visible = 0

func onHiredSupervisor():
	hasSupervisor = true
	$saleTimer.start()
	$progressTimer.start()
	$saleTimer.autostart = 1
	$progressTimer.autostart = 1
	$productIcon.disabled = 1


func _on_research_pressed():
	if globals.money >= globals.get(targetProduct).storeLevelCost :
		globals.get(targetProduct).addStoreProductLevel(1)
		globals.subFromMoney(globals.get(targetProduct).storeLevelCost)
		globals.get(targetProduct).setStoreLevelCost(0.25)
		setSellSpeed()
	UpdateUI()

func setSellSpeed():
	globals.get(targetProduct).setSellTime()
	$saleTimer.wait_time = globals.get(targetProduct).sellTime


