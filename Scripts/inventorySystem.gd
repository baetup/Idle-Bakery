extends Control

var invSlot = load("res://Scenes/inventorySlot.tscn") #loading the inventory slot into this scene to instantiate it according to the number of inventorySlots
var inventorySlots = 24 # current available slots in the inventory ( can be increased)
var availableitems =[] # holds the items that exist (have product count > 0)
var inventorySlotIndexes=[] #holds the references for the children in the scene tree
var addNewSlots = 3
var addNewSlotsCost = 10


func _ready():
	addDefaultSlots()
	checkAvailableItems()
	setIndexes()
	setItems()

#Checking what products have > 0 productCount
func checkAvailableItems():
	var temp = 0
	for x in globals.arrayOfProducts:
		if globals.arrayOfProducts[temp].productCount > 0 && (availableitems.has(globals.arrayOfProducts[temp]) == false):
			availableitems.push_back(globals.arrayOfProducts[temp])
		temp =+ 1
	


#Creating the available inventory slots
func addDefaultSlots():
	for x in inventorySlots:
		$bkgr/scroll/grid.add_child(invSlot.instance())

#Giving inventory slot instances indexes
func setIndexes():
	var temp2 = 0
	for i in inventorySlots:
		var gridChildren = $bkgr/scroll/grid.get_children()
		inventorySlotIndexes.append(gridChildren[temp2])
		inventorySlotIndexes[temp2].setIndex(temp2)
		inventorySlotIndexes[temp2].set_name("inventorySlot" + str(temp2))
		temp2 += 1
	inventorySlotIndexes.resize(inventorySlots-3)
	print(inventorySlotIndexes.size())

#Adding the actual items in the inventory
func setItems():
	var temp = 0
	var temp2 = 0
	for i in availableitems:
		inventorySlotIndexes[temp].setProductCount(availableitems[temp].productCount)
		inventorySlotIndexes[temp].setProductIcon(availableitems[temp].productIcon)
		inventorySlotIndexes[temp].setProductName(availableitems[temp].productName)
		temp += 1
	if availableitems.size() < inventorySlotIndexes.size():
		while (temp2 + availableitems.size()) < inventorySlotIndexes.size():
			for x in (inventorySlotIndexes.size()-availableitems.size()):
				inventorySlotIndexes[temp2+availableitems.size()].setProductCount("")
				inventorySlotIndexes[temp2+availableitems.size()].removeProductIcon()
				inventorySlotIndexes[temp2+availableitems.size()].setProductName("")
				temp2 += 1

func removeItem():
	var temp = 0
	for x in availableitems:
		if availableitems[temp].productCount == 0:
			availableitems.remove(temp)
			inventorySlotIndexes[temp].removeProductIcon()
			inventorySlotIndexes[temp].setProductCount("")
			inventorySlotIndexes[temp].setProductName("")
			checkAvailableItems()
			setItems()
		temp += 1

func _on_close_pressed():
	$".".visible = 0

func _on_addSlotsGold_pressed():
	if globals.money >= addNewSlotsCost : 
		globals.subFromMoney(addNewSlotsCost)
		for x in addNewSlots:
			$bkgr/scroll/grid.add_child(invSlot.instance())
		inventorySlots = inventorySlots + addNewSlots
	checkAvailableItems()
	setIndexes()
	setItems()


func _on_addSlots_pressed():
	$addSlotsPanel.visible = 1
