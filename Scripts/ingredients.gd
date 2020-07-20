extends Node


var farmers = 0
var fishers = 0
var hunters = 0
var farmersLife = 5.00
var fishersLife = 5.00
var huntersLife = 5.00

var flour = ingredient.new("res://Image-assets/flourIcon.png", "Flour", 2, 1, 5, 1, 5)
var sugar = ingredient.new("res://Image-assets/flourIcon.png", "Sugar", 3, 1, 5, 1, 10)

class ingredient :
	var icon
	var name
	var quantity
	var produceTime
	var produceAmount
	var level
	var levelCost

	func _init(setIcon : String, setName : String, setCount : int, setProduceTime : float, setProduceAmount : float,setLevel:int, setLevelCost :int):
		icon = setIcon
		name = setName
		quantity = setCount
		produceTime = setProduceTime
		produceAmount = setProduceAmount
		level = setLevel
		levelCost = setLevelCost
		
	func addQuantity(amount : int):
		quantity = quantity + amount
	
	func removeQuantity(amount : int):
		quantity = quantity - amount
	
	func setProduceTime():
		produceTime = produceTime - (produceTime * 0.02)
		
	func setProduceAmount(amount):
		produceAmount += amount
	
	func setLevelCost(tinyFloat : float):
		levelCost = levelCost + (levelCost * tinyFloat )

