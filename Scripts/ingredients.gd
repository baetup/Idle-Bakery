extends Node


var flour = ingredient.new("res://Image-assets/flourIcon.png", "Flour", 3, 1, 5 )

class ingredient :
	var icon
	var name
	var quantity
	var produceTime
	var produceAmount

	func _init(setIcon : String, setName : String, setCount : int, setProduceTime : float, setProduceAmount : float):
		icon = setIcon
		name = setName
		quantity = setCount
		produceTime = setProduceTime
		produceAmount = setProduceAmount
		
	func addToCount(amount : int):
		quantity = quantity + amount
	
	func setProduceTime():
		produceTime = produceTime - (produceTime * 0.02)
		
	func setProduceAmount(amount):
		produceAmount = amount
