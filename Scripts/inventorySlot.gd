extends Control

export var inventoryIndex : int

func setIndex(index):
	inventoryIndex = index

func setProductIcon(icon):
	$slotBkgr/itemIcon.set_normal_texture(load(icon))
	
func setProductCount(count):
	$slotBkgr/productCount.text = str(count)


func _on_checkUi_timeout():
	pass # Replace with function body.
