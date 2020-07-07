extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
onready var storeNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/store")
export var targetProduct = "breadAvalonia"
var isSellingPossible = false


func _ready():
	UpdateUI()

func UpdateUI():
	$productCountLabel.text= str(globals.get(targetProduct).productCount)
	$levelCount.text = str(globals.get(targetProduct).storeLevelCount)

func inLineTimer(time):
	yield(get_tree().create_timer(time), "timeout")

func _on_saleProduct_pressed():
	if globals.get(targetProduct).productCount > 0 && globals.get(targetProduct).storeLevelCount == 0 && globals.money >= globals.get(targetProduct).storeLevelCost:
		globals.get(targetProduct).addStoreProductLevel(1)
		globals.subFromMoney(globals.get(targetProduct).storeLevelCount)
		globals.get(targetProduct).setStoreLevelCost(0.25)
		isSellingPossible = true
	elif globals.get(targetProduct).storeLevelCount >= 1 && globals.money >= globals.get(targetProduct).storeLevelCost :
		isSellingPossible = true
		globals.get(targetProduct).addStoreProductLevel(1)
		globals.subFromMoney(globals.get(targetProduct).storeLevelCost)
		globals.get(targetProduct).setStoreLevelCost(0.25)

	UpdateUI()

func _on_saleTimer_timeout():
	$progressBar.set("value", 0)
	if globals.get(targetProduct).productCount > 0 && isSellingPossible == true :
		globals.addToMoney(globals.get(targetProduct).sellPrice * globals.get(targetProduct).sellAmount)
		globals.get(targetProduct).removeFromProductCount(globals.get(targetProduct).sellAmount)
		inventoryNodePath.removeItem()
		inventoryNodePath.checkAvailableItems()
		inventoryNodePath.setItems()
			
	else:
		isSellingPossible = false
		$progressTimer.stop()

	if isSellingPossible == false && globals.get(targetProduct).productCount > 0 :
		isSellingPossible = true
		$progressTimer.start()
		$saleTimer.start()

	UpdateUI()

func _on_progressTimer_timeout():
	var current_progress = ($saleTimer.wait_time - $saleTimer.time_left) / $saleTimer.wait_time 
	$progressBar.set("value", current_progress)

func _on_close_pressed():
	storeNodePath.visible = 0

func onHiredSupervisor():
	$saleTimer.start()
	$progressTimer.start()
	$saleTimer.autostart = 1
	$progressTimer.autostart = 1

func _on_productIcon_pressed():
	$saleTimer.start()
	
