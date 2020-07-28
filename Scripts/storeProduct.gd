extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
onready var notificationsPath = get_node("/root/GameManager/UiCanvas/notificationPanel")
export var targetProduct = "breadAvalonia"
var isSellingPossible = false
var hasSupervisor = false
var notification


func _ready():
	$saleTimer.wait_time = globals.get(targetProduct).sellTime
	UpdateUI()

func UpdateUI():
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).icon))
	$productCountLabel.text= str(globals.get(targetProduct).quantity)
	$levelCount.text = str(globals.get(targetProduct).storeProductLevelCount)
	$durationLabel.text = "%.1f" % ($saleTimer.time_left) + "s"
	$research/upgradeCost.text = "%.2f" % (globals.get(targetProduct).storeLevelCost)

	#disable upgrade button if not enough money
	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0

	#checking when to show particles on product
	if hasSupervisor == false && !($saleTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false) && globals.get(targetProduct).quantity > 0:
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
	if hasSupervisor && isSellingPossible:
		$progressBar.set("value", 0.00)
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)

	#the case when manually pressing the production icon
	else:
		$saleTimer.stop()
		$progressTimer.stop()
		$progressBar.set("value", 0.00)
		$productIcon.disabled = 0 
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)


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

#timer to show when an alert should appear
func _on_showNotifications_timeout():
	if globals.get(targetProduct).isUnlocked && isSellingPossible == false && hasSupervisor:
		notification = globals.notification.new("store", globals.get(targetProduct).originBakery, globals.get(targetProduct).name, true)
		globals.notificationArray.append(notification)
		notificationsPath.addNotifications()
		notificationsPath.setNotifications()

		$showNotifications.autostart = 0
		$showNotifications.stop()
		$hideNotifications.start()
		$hideNotifications.autostart = 1


func _on_hideNotifications_timeout():
	if isSellingPossible:
		var temp = 0
		for x in globals.notificationArray:
			if globals.notificationArray[temp].type == "store" && globals.notificationArray[temp].target == notification.target:
				globals.notificationArray.remove(temp)
			temp += 1
			notificationsPath.addNotifications()
			notificationsPath.setNotifications()

		$hideNotifications.autostart = 0
		$hideNotifications.stop()
		$showNotifications.start()
		$showNotifications.autostart = 1
