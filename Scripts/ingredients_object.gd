extends Resource


class_name ingredient
export var icon : String
export var name	: String
export var quantity : int 
export var produceTime : float
export var produceAmount : int
export var produceTimeMult : float
export var level : int
export var levelCost : float
export var levelCostMult : float


func addQuantity(amount : int):
	quantity = quantity + amount

func removeQuantity(amount : int):
	quantity = quantity - amount

func setProduceTime():
	produceTime = produceTime - (produceTime * pow(produceTimeMult, level))

func setProduceAmount():
	produceAmount = produceAmount + level

func setLevelCost():
	levelCost = levelCost * pow(levelCostMult,level)

func setProduceTimeMult(value : float):
	produceTimeMult = value
