extends Resource

class_name upgrade

export var upgradeIdentifier : String
export var isBought : bool
export var icon : String
export var title : String
export var description : String
export var cost : float
export var village: String
export var destination : String # ex: store, bakery, farm
export var target : String # target products or ingredient
export var type : String # if its meant to increase sell speed or bake speed or etc.
export var increaseSellSpeed : float
export var increaseBakeSpeed : float
export var decreaseLevelCost : float
export var increaseProduceAmount : float
export var increaseSellPrice : float

func set_isBought(value : bool):
	isBought = value
