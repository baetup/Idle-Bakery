extends Control


export var targetUpgrade = ""
onready var buyBtn = $panel/buy
onready var icon = $panel/icon
onready var workshop = get_node("/root/GameManager/"+ s_upgrades.get(targetUpgrade).village + "/UiCanvas/workshop")

# Called when the node enters the scene tree for the first time.
func _ready():
	updateUi()


func updateUi():
	icon.set_texture(load(s_upgrades.get(targetUpgrade).icon))
	$panel/title.text = s_upgrades.get(targetUpgrade).title
	$panel/description.text = s_upgrades.get(targetUpgrade).description
	$cost.text = str(s_upgrades.get(targetUpgrade).cost)
	if s_upgrades.get(targetUpgrade).isBought:
		buyBtn.disabled = true



func _on_buy_pressed():
	if globals.money >= s_upgrades.get(targetUpgrade).cost:
		globals.subFromMoney(s_upgrades.get(targetUpgrade).cost)
		if s_upgrades.get(targetUpgrade).destination == "bakery":
			if s_upgrades.get(targetUpgrade).type == "increaseBakingSpeed":
				globals.get(s_upgrades.get(targetUpgrade).target).upgradeBakingTime(s_upgrades.get(targetUpgrade).increaseBakeSpeed)
			elif s_upgrades.get(targetUpgrade).type == "decreaseLevelCost":
				globals.get(s_upgrades.get(targetUpgrade).target).upgradeBakeryLevelCost(s_upgrades.get(targetUpgrade).decreaseLevelCost)
			
			workshop.upgradePurchased("bakeryUpgrades", s_upgrades.get(targetUpgrade).upgradeIdentifier)
		elif s_upgrades.get(targetUpgrade).destination == "store":
			if s_upgrades.get(targetUpgrade).type == "increaseSellingSpeed":
				globals.get(s_upgrades.get(targetUpgrade).target).upgradeSellingTime(s_upgrades.get(targetUpgrade).increaseSellSpeed)
			elif s_upgrades.get(targetUpgrade).type == "decreaseLevelCost":
				globals.get(s_upgrades.get(targetUpgrade).target).upgradeStoreLevelCost(s_upgrades.get(targetUpgrade).decreaseLevelCost)
			elif s_upgrades.get(targetUpgrade).type == "increaseSellPrice":
				globals.get(s_upgrades.get(targetUpgrade).target).upgradeSellPrice(s_upgrades.get(targetUpgrade).increaseSellPrice)
				
			workshop.upgradePurchased("storeUpgrades", s_upgrades.get(targetUpgrade).upgradeIdentifier)
		elif s_upgrades.get(targetUpgrade).destination == "farm":
			if s_upgrades.get(targetUpgrade).type == "increaseProduceTime":
				ingredients.get(s_upgrades.get(targetUpgrade).target).upgradeProduceTime(s_upgrades.get(targetUpgrade).increaseBakeSpeed)
			elif s_upgrades.get(targetUpgrade).type == "increaseProduceAmount":
				ingredients.get(s_upgrades.get(targetUpgrade).target).upgradeProduceAmount(s_upgrades.get(targetUpgrade).increaseProduceAmount)
			elif s_upgrades.get(targetUpgrade).type == "decreaseLevelCost":
				ingredients.get(s_upgrades.get(targetUpgrade).target).upgradeLevelCost(s_upgrades.get(targetUpgrade).decreaseLevelCost)
			workshop.upgradePurchased("farmUpgrades", s_upgrades.get(targetUpgrade).upgradeIdentifier)
			
		buyBtn.disabled = true
		icon.material.set_shader_param('grayscale', true)
		s_upgrades.get(targetUpgrade).set_isBought(true)

