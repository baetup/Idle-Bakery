extends Control

var invSlot = load("res://Scenes/inventorySlot.tscn") #loading the inventory slot into this scene to instantiate it according to the number of inventorySlots
var inventorySlots = 18 # current available slots in the inventory ( can be increased only by multiple of 3 )
var availableitems =[] # holds the items that exist (have product count > 0)
var inventorySlotIndexes=[] #holds the references for the children in the scene tree
var addNewSlots = 3
var addNewSlotsCost = 10
var deleteMode = false


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
		temp += 1
	

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
	inventorySlotIndexes.resize(inventorySlots-3) # Resizing because the scroll container doesn't display the last row

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

#Closing the whole inventory
func _on_close_pressed():
	$".".visible = 0

#Adding new slots paying with gold
func _on_addSlotsGold_pressed():
	if globals.money >= addNewSlotsCost : 
		globals.subFromMoney(addNewSlotsCost)
		for x in addNewSlots:
			$bkgr/scroll/grid.add_child(invSlot.instance())
		inventorySlots = inventorySlots + addNewSlots
	checkAvailableItems()
	setIndexes()
	setItems()

#Pressing the add slots button that opens the addSlotsPanel
func _on_addSlots_pressed():
	$addSlotsPanel.visible = 1

func setDeleteCheckBoxVisibility():
	var temp = 0
	if deleteMode :
		for i in availableitems:
			inventorySlotIndexes[temp].setCheckboxVisibility(true)
			temp += 1
		
	else:
		for i in availableitems:
			inventorySlotIndexes[temp].setCheckboxVisibility(false)
			temp += 1

func _on_deleteItems_pressed():
	if deleteMode:
		deleteMode = false
		setDeleteCheckBoxVisibility()
		$checkUi.stop()
		$checkUi.autostart = 0

		if $deleteItems/garbageLabel.text == "Throw items":
			var temp = 0
			var tempItemCounter = availableitems.size() - 1
			for i in tempItemCounter :
				print("test")
				if inventorySlotIndexes[temp].getCheckboxState() == true:
					availableitems[temp].productCount  = 0
					#print(availableitems[temp].productCount)
					inventorySlotIndexes[temp].removeProductIcon()
					inventorySlotIndexes[temp].setProductCount("")
					inventorySlotIndexes[temp].setProductName("")
					availableitems.remove(temp)
				temp = temp + 1
				
			checkAvailableItems()
			setItems()
			var temp2 = 0
			for i in availableitems :
				inventorySlotIndexes[temp2].setCheckboxState(false)
				temp2 = temp2 + 1
			$deleteItems/garbageLabel.text = "Garbage"


	else:
		deleteMode = true
		setDeleteCheckBoxVisibility()
		$checkUi.start()
		$checkUi.autostart = 1
		

func _on_checkUi_timeout():
	var temp = 0
	var countItemsSelected = 0
	for i in availableitems :
		if inventorySlotIndexes[temp].getCheckboxState():
			countItemsSelected = countItemsSelected + 1
		temp += 1
	if countItemsSelected > 0:
		$deleteItems/garbageLabel.text = "Throw items"
	else:
		$deleteItems/garbageLabel.text = "Garbage"









