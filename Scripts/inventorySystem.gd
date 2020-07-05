extends Control

var invSlot = load("res://Scenes/inventorySlot.tscn") #loading the inventory slot into this scene to instantiate it according to the number of inventorySlots
var inventorySlots = 14 # current available slots in the inventory ( can be increased)
var availableitems =[] # holds the items that exist (have product count > 0)
var inventorySlotIndexes=[] #holds the references for the children in the scene tree


func _ready():
	addSlots()
	checkAvailableItems()
	setIndexes()
	setItems()

#Checking what products have > 0 productCount
func checkAvailableItems():
	var temp = 0
	for x in globals.arrayOfProducts:
		if globals.arrayOfProducts[temp].productCount > 0:
			availableitems.append(globals.arrayOfProducts[temp])
			temp =+ 1

#Creating the available inventory slots
func addSlots():
	for x in inventorySlots:
		$bkgr/scroll/grid.add_child(invSlot.instance())

#Giving inventory slot instances indexes
func setIndexes():
	var temp = ""
	var temp2 = 0
	for i in inventorySlots:
		var gridChildren = $bkgr/scroll/grid.get_children()
		gridChildren[temp2].setIndex(temp2)
		inventorySlotIndexes.append(gridChildren[temp2])
		temp2 += 1
		temp = "inventorySlot" + str(temp2)

#Adding the actual items in the inventory
func setItems():
	var temp = 0
	for i in availableitems:
		inventorySlotIndexes[temp].setProductIcon(availableitems[temp].productIcon)
		inventorySlotIndexes[temp].setProductCount(availableitems[temp].productCount) 
		temp += 1
