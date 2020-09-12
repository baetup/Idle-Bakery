extends Node

#Fishes in one village can't be found in the other village

var resource_path = "res://"

var fishingTime : float = 3.00
var fishingTimeMult : float = 0.34
var fishingLevel : int = 1
var fishingLevelCost : float = 5.00
var fishingLevelMult : float = 1.07

var troutFish = load(resource_path + "ingredients/fish_trout.tres")
var herringFish = load(resource_path + "ingredients/fish_herring.tres")
var codFish = load(resource_path + "ingredients/fish_cod.tres")

var avaloniaFishArr = [troutFish, herringFish, codFish]

func setFishingLevelCost():
	fishingLevelCost = fishingLevelCost * pow(fishingLevelMult, fishingLevel)

func _get_fishing_time() -> float :
	return fishingTime
	
func set_fishing_time():
	fishingTime = fishingTime - (fishingTime * pow(fishingTimeMult,fishingLevel))
	
func set_fishing_time_mult(value : float):
	fishingTimeMult = value

func loadResource():
	troutFish = load(resource_path + "ingredients/fish_trout.tres")
	herringFish = load(resource_path + "ingredients/fish_herring.tres")
	codFish = load(resource_path + "ingredients/fish_cod.tres")
	
	avaloniaFishArr = [troutFish, herringFish, codFish]
