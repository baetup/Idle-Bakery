extends Node


var flour = ingredient.new("res://Image-assets/flourIcon.png", "Flour", 3, 1, 5 )

class ingredient :
	var productIcon
	var productName
	var quantity
	var produceTime
	var produceAmount

	func _init(setIcon : String, setName : String, setCount : int, setProduceTime : float, setProduceAmount : float):
		productIcon = setIcon
		productName = setName
		quantity = setCount
		produceTime = setProduceTime
		produceAmount = setProduceAmount
		
	func addToCount(amount : int):
		quantity = quantity + amount
	
	func setProduceTime():
		produceTime = produceTime - (produceTime * 0.02)
		
	func setProduceAmount(amount):
		produceAmount = amount
