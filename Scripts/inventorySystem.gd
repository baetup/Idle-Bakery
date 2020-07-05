extends Control

var invSlot = load("res://Scenes/inventorySlot.tscn")
var inventorySlots = 14

var availableitems =[]


func _ready():
	addSlots()
	sendInInventory()
	print(availableitems.size())

func sendInInventory():
	var temp = 0
	for x in globals.arrayOfProducts:
		if globals.arrayOfProducts[temp].productCount > 0:
			availableitems.append(globals.arrayOfProducts[temp])
			temp =+ 1

func addSlots():
	for x in inventorySlots:
		$bkgr/scroll/grid.add_child(invSlot.instance())
