extends Node

onready var bakeryNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery")
onready var storeNodePath = get_node("/root/GameManager/villageAvalonia/UiCanvas/store")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var gameManagerNodePath = get_node("/root/GameManager")

var clickMoney = 10


var building1Exp = 11
var building1Cost = 1000


#Receive money when you click the click money building
func _on_ClickMoneyButton_pressed():
	globals.addToMoney(clickMoney)
	$ClickMoneyButton/coin.one_shot = false
	var t = Timer.new()
	t.set_wait_time(0.8)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$ClickMoneyButton/coin.one_shot = true

#Updating UI elements
func _on_checkUi_timeout():
	#checking for production stops
	checkProductionStops()

func checkProductionStops():
	var counter = 0
	var stopsFound = 0
	for product in globals.arrayOfProducts:
		var counter2 = 0
		for ingredients in globals.arrayOfProducts[counter].ingredients :
			if globals.arrayOfProducts[counter].ingredients[counter2].quantity < 1 && globals.arrayOfProducts[counter].isUnlocked:
				stopsFound += 1
			counter2 += 1
		counter += 1
	
	if stopsFound > 0:
		$bakeryLabel/warning.visible = 1
	else:
		$bakeryLabel/warning.visible = 0

func _on_getCastleOpen_pressed():
	get_node("/root/GameManager/UiCanvas/castle").visible = 1
	get_node("/root/GameManager/UiCanvas/castle").checkStatus()

