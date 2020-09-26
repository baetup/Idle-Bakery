extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetProduct = "breadAvalonia"
var isSellingPossible = false


func _ready():
	restartProductionOnLoad()
	UpdateUI()


func UpdateUI():
	$productName.text = globals.get(targetProduct).name
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).icon))
	$productCountLabel.text= str(globals.get(targetProduct).quantity)
	$levelCount.text = str(globals.get(targetProduct).storeProductLevel)
	$saleTimer.wait_time = globals.get(targetProduct).sellTime
	$durationLabel.text = "%.1f" % ($saleTimer.time_left) + "s"
	$research/upgradeCost.text = "%.1f" % (globals.get(targetProduct).storeLevelCost)


	#disable upgrade button if not enough money
	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0

	#checking when to show particles on product
	if globals.get(targetProduct)._get_has_store_supervisor() == false && !($saleTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false) && globals.get(targetProduct).quantity > 0:
		$productIcon/Particles2D.visible = 1
	else:
		$productIcon/Particles2D.visible = 0 

	$unlockPanel/productName.text = globals.get(targetProduct).name

	#checking if we have enough products to sell
	if globals.get(targetProduct).quantity > 0:
		$productIcon.disabled = 0
		isSellingPossible = true
	else:
		isSellingPossible = false
		$saleTimer.set_paused(true)
		$progressTimer.set_paused(true)
		$productIcon.disabled = 1
		
	#restart selling process after products become available again
	if isSellingPossible && $saleTimer.is_paused():
		$saleTimer.set_paused(false)
		$progressTimer.set_paused(false)

	#checking if I have enought money to upgrade
	if globals.money < globals.get(targetProduct).storeLevelCost:
		$research.disabled = 1
	else:
		$research.disabled = 0

func inLineTimer(time):
	yield(get_tree().create_timer(time), "timeout")


func _on_checkUi_timeout():
	UpdateUI()



func _on_productIcon_pressed():
	$saleTimer.start()
	$progressTimer.start()
	$saleTimer.autostart = 0
	$progressTimer.autostart = 0
	$productIcon.disabled = 1



func _on_saleTimer_timeout():
	if globals.get(targetProduct)._get_has_store_supervisor() && isSellingPossible:
		$progressBar.set("value", 0.00)
		globals.addToMoney(globals.get(targetProduct).sellPrice)
		globals.get(targetProduct).removeFromProductCount()

	#the case when manually pressing the production icon
	else:
		$saleTimer.stop()
		$progressTimer.stop()
		$progressBar.set("value", 0.00)
		$productIcon.disabled = 0 
		globals.get(targetProduct).removeFromProductCount()
		globals.addToMoney(globals.get(targetProduct).sellPrice)


	#removing product from inventory
	if globals.get(targetProduct).quantity == 0:
			inventoryNodePath.removeItem()
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()

	#updating product count after selling
	else: 
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()

	UpdateUI()

func _on_progressTimer_timeout():
	var current_progress = ($saleTimer.wait_time - $saleTimer.time_left) / $saleTimer.wait_time 
	$progressBar.set("value", current_progress)
	UpdateUI()

func _on_close_pressed():
	$".".visible = 0

func onStoreHiredSupervisor():
	globals.get(targetProduct).set_has_store_supervisor(true)
	$saleTimer.start()
	$progressTimer.start()
	$saleTimer.autostart = 1
	$progressTimer.autostart = 1
	$productIcon.disabled = 1


func _on_research_pressed():
	if globals.money >= globals.get(targetProduct).storeLevelCost :
		if globals.get(targetProduct).storeProductLevel == 8:
			globals.get(targetProduct).setSellTimeMult(0.69)
		if globals.get(targetProduct).storeProductLevel == 22:
			globals.get(targetProduct).setSellTimeMult(0.82)
		if globals.get(targetProduct).storeProductLevel == 35:
			globals.get(targetProduct).setSellTimeMult(0.95)
	
		globals.get(targetProduct).addStoreProductLevel()
		globals.subFromMoney(globals.get(targetProduct).storeLevelCost)
		globals.get(targetProduct).setStoreLevelCost()
		globals.get(targetProduct).setSellTime()
		globals.get(targetProduct).addToSellPrice()
		setSellSpeed()
	UpdateUI()

func setSellSpeed():
	$saleTimer.wait_time = globals.get(targetProduct).sellTime

func restartProductionOnLoad():
	if globals.get(targetProduct)._get_has_store_supervisor():
		$saleTimer.start()
		$progressTimer.start()
		$saleTimer.autostart = 1
		$progressTimer.autostart = 1
		$productIcon.disabled = 1
