extends Panel

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetProduct = "breadAvalonia"
var hasSupervisor = false
var unlockCost = globals.money * 0.9

func _ready():
	$bakeTimer.wait_time = globals.get(targetProduct).bakeTime
	UpdateUI()

func UpdateUI():
	$productIcon/productIcon.set_texture(load(globals.get(targetProduct).productIcon))
	$productCountLabel.text= str(globals.get(targetProduct).quantity)
	$levelCount.text = str(globals.get(targetProduct).bakeryProductLevel)
	$durationLabel.text = "%.1f" % ($bakeTimer.time_left) + "s"
	$progressBar/amount.text = str(globals.get(targetProduct).produceAmount)
	$research/upgradeCost.text = "%.2f" % (globals.get(targetProduct).bakeryLevelCost)
	
	if globals.get(targetProduct).isUnlocked == false:
		$unlockPanel.visible = 1
	else:
		$unlockPanel.visible = 0
		
	if hasSupervisor == false && !($bakeTimer.time_left > 0) && !(globals.get(targetProduct).isUnlocked == false):
		$productIcon/Particles2D.visible = 1
	else:
		$productIcon/Particles2D.visible = 0 
	
	$unlockPanel/costLabel.text = str(unlockCost)
	$unlockPanel/productName.text = globals.get(targetProduct).productName
	



func _on_checkUi_timeout():
	UpdateUI()
	if globals.money < globals.get(targetProduct).bakeryLevelCost:
		$research.disabled = 1
	else:
		$research.disabled = 0
	unlockCost = globals.money * 0.9


func _on_bakeTimer_timeout():
	if hasSupervisor == true:
		$progressBar.set("value", 0.00)
		globals.get(targetProduct).addToProductCount(globals.get(targetProduct).produceAmount)
		if globals.get(targetProduct).quantity > 0:
			inventoryNodePath.checkAvailableItems()
			inventoryNodePath.setItems()
	else:
		$bakeTimer.stop()
		$progressTimer.stop()
		$progressBar.set("value", 0.00)
		globals.get(targetProduct).addToProductCount(globals.get(targetProduct).produceAmount)
		$productIcon.disabled = 0 
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
		globals.get(targetProduct).setProduceAmount(2)
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
