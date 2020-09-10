extends Node

#Fishes in one village can't be found in the other village

var resource_path = "res://"

var fishingTime : float = 3.00
var fishingTimeMult : float = 0.34
var fishingLevel : int = 1
var fishingLevelCost : float = 5.00
var fishingLevelMult : float = 1.07

var troutFish = load(resource_path + "fish/trout.tres")
var herringFish = load(resource_path + "fish/herring.tres")
var codFish = load(resource_path + "fish/cod.tres")

var fishArray = [troutFish, herringFish, codFish]

func setFishingLevelCost():
	fishingLevelCost = fishingLevelCost * pow(fishingLevelMult, fishingLevel)

func _get_fishing_time() -> float :
	return fishingTime
	
func set_fishing_time():
	fishingTime = fishingTime - (fishingTime * pow(fishingTimeMult,fishingLevel))
	
func set_fishing_time_mult(value : float):
	fishingTimeMult = value

func loadResource():
	troutFish = load(resource_path + "res://fish/trout.tres")
	herringFish = load(resource_path + "res://fish/herring.tres")
	codFish = load(resource_path + "res://fish/cod.tres")
