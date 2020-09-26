extends Control


var isDropdownOpen = false
onready var dropdown_bot = $panel/dropdown_bot
onready var bakeryBtn = $panel/dropdown_bot/vbox/bakeryBtn
onready var farmBtn = $panel/dropdown_bot/vbox/farmBtn
onready var storeBtn = $panel/dropdown_bot/vbox/storeBtn
onready var storeUpgrades = $panel/storeUpgrades
onready var bakeryUpgrades = $panel/bakeryUpgrades
onready var farmUpgrades = $panel/farmUpgrades
var currentlySelected = "Bakery"
onready var mainBuildingsColliders = get_node("/root/GameManager/villageAvalonia/buttonsCollider")

func _ready():
	updateUi()


func updateUi():
	$panel/dropdown_top/currentlySelected.text = currentlySelected


func _on_closeWorkshop_pressed():
	$".".hide()
	mainBuildingsColliders.showColliders()


func _on_dropdown_top_pressed():
	if isDropdownOpen == false:
		dropdown_bot.show()
		isDropdownOpen = true
	else :
		dropdown_bot.hide()
		isDropdownOpen = false


func _on_storeBtn_pressed():
	currentlySelected = "Store"
	bakeryBtn.show()
	farmBtn.show()
	storeBtn.hide()
	storeUpgrades.show()
	bakeryUpgrades.hide()
	farmUpgrades.hide()
	dropdown_bot.hide()
	updateUi()



func _on_farmBtn_pressed():
	currentlySelected = "Farm"
	bakeryBtn.show()
	farmBtn.hide()
	storeBtn.show()
	storeUpgrades.hide()
	bakeryUpgrades.hide()
	farmUpgrades.show()
	dropdown_bot.hide()
	updateUi()
	


func _on_bakeryBtn_pressed():
	currentlySelected = "Bakery"
	bakeryBtn.hide()
	farmBtn.show()
	storeBtn.show()
	storeUpgrades.hide()
	bakeryUpgrades.show()
	farmUpgrades.hide()
	dropdown_bot.hide()
	updateUi()

func upgradePurchased(destination : String, upgradeName : String ):
	var parentNode = get_node("panel/" + destination)
	var childNode = get_node("panel/" + destination +"/" + upgradeName)
	parentNode.move_child(childNode,parentNode.get_child_count())
	
	
	
	
	
