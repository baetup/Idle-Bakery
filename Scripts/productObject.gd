extends Resource


class_name productObject
export var name : String
export var icon : String
export var quantity : int
export var bakeryProductLevel : int
export var bakeryLevelCost : float
export var bakeryLevelCostMult : float
export var produceAmount : int
export var bakeTimeMult : float
export var bakeTime : float

export var sellTimeMult : float
export var sellTime : float
export var sellPrice : float
export var sellPriceMult: float
export var sellAmount : int
export var storeProductLevel : int
export var storeLevelCost : float
export var storeLevelCostMult : float

export var isUnlocked : bool
export var ingredients : Array
export var originBakery : String
export var hasBakerySupervisor : bool
export var hasStoreSupervisor : bool


func addToProductCount(amount : int):
	quantity += amount

func addBakeryProductLevel():
	bakeryProductLevel += 1

func setBakeryLevelCost():
	bakeryLevelCost = bakeryLevelCost * pow(bakeryLevelCostMult, bakeryProductLevel)

func setBakeTime():
	bakeTime = bakeTime - (bakeTime *pow(bakeTimeMult,bakeryProductLevel))
	
func addToSellPrice():
	sellPrice = sellPrice + pow(sellPriceMult,storeProductLevel)

func addStoreProductLevel():
	storeProductLevel += 1

func setStoreLevelCost():
	storeLevelCost = storeLevelCost * pow(storeLevelCostMult, storeProductLevel)

func setSellTime():
	sellTime = sellTime - (sellTime * pow(sellTimeMult, storeProductLevel))

func removeFromProductCount():
	quantity -= 1
		
func setIsUnlocked(answer:bool):
	isUnlocked = answer

func set_has_bakery_supervisor(value : bool):
	hasBakerySupervisor = value

func set_has_store_supervisor(value : bool):
	hasStoreSupervisor = value

func _get_has_bakery_supervisor() -> bool:
	return hasBakerySupervisor
	
func _get_has_store_supervisor() -> bool:
	return hasStoreSupervisor

func setBakeTimeMult(value : float):
	bakeTimeMult = value

func setSellTimeMult(value : float):
	sellTimeMult = value
