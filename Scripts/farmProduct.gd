extends Control

onready var inventoryNodePath = get_node("/root/GameManager/UiCanvas/inventorySystem")
export var targetIngredient = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	UpdateUI()

func UpdateUI():
	$name.text = ingredients.get(targetIngredient).name
	$quantity.text = str(shortenMoney.short(ingredients.get(targetIngredient).quantity))
	$levelCount.text = str(ingredients.get(targetIngredient).level)
	$produceIcon/icon.set_texture(load(ingredients.get(targetIngredient).icon))
	$farmTimer.wait_time = ingredients.get(targetIngredient).produceTime
	$durationLabel.text = "%.1f" % ($farmTimer.time_left) + "s"
	$research/upgradeCost.text = str(shortenMoney.short(ingredients.get(targetIngredient).levelCost))

	if ingredients.get(targetIngredient).levelCost > globals.money:
		$research.disabled = 1
	else:
		$research.disabled = 0

func _on_checkUi_timeout():
	UpdateUI()

func _on_progressTimer_timeout():
	var current_progress = ($farmTimer.wait_time - $farmTimer.time_left) / $farmTimer.wait_time 
	$progressBarBody/progressBar.set("value", current_progress)
	UpdateUI()

func _on_farmTimer_timeout():
	$progressBarBody/progressBar.set("value", 0.00)
	$farmTimer.stop()
	$progressTimer.stop()
	ingredients.get(targetIngredient).addQuantity(ingredients.get(targetIngredient).level * ingredients.get(targetIngredient).produceAmount)
	$produceIcon.disabled = 0
	UpdateUI()
	
	#Updating inventory for producing
	inventoryNodePath.checkAvailableItems()
	inventoryNodePath.setItems()

func _on_produceIcon_pressed():
	$farmTimer.start()
	$progressTimer.start()
	$produceIcon.disabled = 1
	UpdateUI()

func _on_research_pressed():
	if globals.money >= ingredients.get(targetIngredient).levelCost:
		
		#modifying the produce time multiplier to decrease faster
		if ingredients.get(targetIngredient).level == 8:
			ingredients.get(targetIngredient).setProduceTimeMult(0.69)
		if ingredients.get(targetIngredient).level == 22:
			ingredients.get(targetIngredient).setProduceTimeMult(0.82)
		if ingredients.get(targetIngredient).level == 35:
			ingredients.get(targetIngredient).setProduceTimeMult(0.95)
	
		ingredients.get(targetIngredient).level += 1
		globals.subFromMoney(ingredients.get(targetIngredient).levelCost)
		ingredients.get(targetIngredient).setProduceAmount()
		ingredients.get(targetIngredient).setLevelCost()
		ingredients.get(targetIngredient).setProduceTime()
		
