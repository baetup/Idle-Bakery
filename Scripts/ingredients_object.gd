extends Resource


class_name ingredient
export var icon : String
export var name	: String
export var quantity : int 
export var produceTime : float
export var produceAmount : int
export var level : int
export var levelCost : float


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
