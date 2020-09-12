extends Node



var resource_path = "res://"

var huntingTime : float = 3.00
var huntingTimeMult : float = 0.34
var huntingLevel : int = 1
var huntingLevelCost : float = 5.00
var huntingLevelMult : float = 1.07

var meatBoar = load(resource_path + "ingredients/meatBoar.tres")
var meatDeer = load(resource_path + "ingredients/meatDeer.tres")
var meatWildChicken = load(resource_path + "ingredients/meatWildChicken.tres")

var avaloniaMeatArr = [meatBoar, meatDeer, meatWildChicken]

func setHuntingLevelCost():
	huntingLevelCost = huntingLevelCost * pow(huntingLevelMult, huntingLevel)

func _get_hunting_time() -> float :
	return huntingTime
	
func set_hunting_time():
	huntingTime = huntingTime - (huntingTime * pow(huntingTimeMult,huntingLevel))
	
func set_hunting_time_mult(value : float):
	huntingLevelMult = value

func loadResource():
	meatBoar = load(resource_path + "ingredients/meatBoar.tres")
	meatDeer = load(resource_path + "ingredients/meatDeer.tres")
	meatWildChicken = load(resource_path + "ingredients/meatWildChicken.tres")
	
	avaloniaMeatArr = [meatBoar, meatDeer, meatWildChicken]
