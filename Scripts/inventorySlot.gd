extends Control

export var inventoryIndex : int
var isSelected : bool

func setIndex(index):
	inventoryIndex = index

func setProductIcon(icon):
	$slotBkgr/itemIcon.set_normal_texture(load(icon))

func removeProductIcon():
	$slotBkgr/itemIcon.set_normal_texture(null)	

func setProductCount(count):
	$slotBkgr/productCount.text = str(count)

func setProductName(name):
	$slotBkgr/productName.text = name

func setCheckboxVisibility(boolean):
	print("test")
	$deleteCheckbox.visible = boolean
