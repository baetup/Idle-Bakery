extends Node2D

export var targetBuilding = ""

onready var buildingName = $income/bkgr/name
onready var productionRate = $income/bkgr/productionRate
onready var produceTimer = $income/produceTimer
onready var costLabel = $unlockBtn/btnBkgr/costLabel

onready var incomeWindow = $income
onready var unlockBtn = $unlockBtn

var canBuy = false
var isOpen = false


func _ready():
	ui()

func ui():
	if s_buildings.get(targetBuilding).isBought:
		$unlockBtn.hide()
		
		$income/produceTimer.start()
		$income/progressTimer.start()
		$income/produceTimer.autostart = 1
		$income/progressTimer.autostart = 1
		
		if s_buildings.get(targetBuilding).name == "Manor":
			$billboards/manorBill.show()
		elif s_buildings.get(targetBuilding).name == "Cottage":
			$billboards/cottage1Bill.show()
		elif s_buildings.get(targetBuilding).name == "Small Cottage":
			$billboards/cottage2Bill.show()
		elif s_buildings.get(targetBuilding).name == "Barracks":
			$billboards/manorBill.show()
		elif s_buildings.get(targetBuilding).name == "Archery Range":
			$billboards/manorBill.show()
		elif s_buildings.get(targetBuilding).name == "Estate":
			$billboards/manorBill.show()
		elif s_buildings.get(targetBuilding).name == "Animal Farm":
			$billboards/animalFarmBill.show()
		elif s_buildings.get(targetBuilding).name == "Stables":
			$billboards/stableBill.show()

	buildingName.text = s_buildings.get(targetBuilding).name
	productionRate.text = "%.2f" % s_buildings.get(targetBuilding).incomeAmount + " / " + "%.2f" % s_buildings.get(targetBuilding).incomeTime + " sec"
	produceTimer.wait_time = s_buildings.get(targetBuilding).incomeTime
	costLabel.text = "%.2f" %  s_buildings.get(targetBuilding).cost



func _on_checkUi_timeout():
	if globals.money >= s_buildings.get(targetBuilding).cost:
		canBuy = true
		$unlockBtn/btnBkgr.material.set_shader_param('grayscale', false)
	else :
		$unlockBtn/btnBkgr.material.set_shader_param('grayscale', true)
		canBuy = false
		

func _on_Buy_Buildings():
	if canBuy && s_buildings.get(targetBuilding).isBought == false:
		$checkUi.autostart = 0
		$checkUi.stop()
		globals.subFromMoney(s_buildings.get(targetBuilding).cost)
		s_buildings.get(targetBuilding).set_isBought(true)
		
		if s_buildings.get(targetBuilding).name == "Manor":
			$billboards/manorBill.show()
		elif s_buildings.get(targetBuilding).name == "Cottage":
			$billboards/cottage1Bill.show()
		
		unlockBtn.hide()
		incomeWindow.show()
		isOpen = true
		
		$income/produceTimer.start()
		$income/progressTimer.start()
		$income/produceTimer.autostart = 1
		$income/progressTimer.autostart = 1
		
	elif s_buildings.get(targetBuilding).isBought :
		if isOpen:
			isOpen = false
			incomeWindow.hide()
		else:
			isOpen = true
			incomeWindow.show()
	
	ui()

func _on_progressTimer_timeout():
	var current_progress = ($income/produceTimer.wait_time - $income/produceTimer.time_left) / $income/produceTimer.wait_time 
	$income/progressBarBody/progressBar.set("value", current_progress)


func _on_produceTimer_timeout():
	globals.addToMoney(s_buildings.get(targetBuilding).incomeAmount)
