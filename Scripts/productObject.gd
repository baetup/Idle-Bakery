extends Resource


class_name productObject
export var name : String
export var icon : String
export var quantity : int
export var bakeryProductLevel : int
export var bakeryLevelCost : float
export var produceAmount : int
export var bakeSpeedMultiplier : float
export var bakeTime : float

export var sellSpeedMultiplier : float
export var sellTime : float
export var sellPrice : float
export var sellAmount : int
export var storeProductLevelCount : int
export var storeLevelCost : float

export var isUnlocked : bool
export var ingredients : Array
export var originBakery : String
export var hasSupervisor : bool


func addToProductCount(amount : int):
	quantity += amount

func addBakeryProductLevel(amount : int):
	bakeryProductLevel += amount

func setBakeryLevelCost(percentage : float):
	bakeryLevelCost = bakeryLevelCost + (bakeryLevelCost * percentage)

func setBakeTime():
	bakeTime = bakeTime - (bakeTime * bakeSpeedMultiplier)
	
func addToSellPrice(amount):
	sellPrice = sellPrice + amount

func addStoreProductLevel(amount : int):
	storeProductLevelCount += amount

func setStoreLevelCost(percentage : float):
	storeLevelCost = storeLevelCost + (storeLevelCost * percentage)

func setSellTime():
	sellTime = sellTime- (sellTime * sellSpeedMultiplier)

func removeFromProductCount(amount : int):
	quantity = quantity - amount
		
func setIsUnlocked(answer:bool):
	isUnlocked = answer

func set_has_supervisor(value : bool):
	hasSupervisor = value
	
func _get_has_supervisor() -> bool:
	return hasSupervisor
