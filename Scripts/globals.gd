extends Node

var day = 1
var money = 500
var username : String = ""
var avatar : String= ""
var prestigeLevel : int = 0
var charPoints : int = 5
var neededExp : int = 10 #For level 1
var curExp : int = 0
var cunStat : int = 0
var chrStat : int = 0
var intStat : int = 0
var invStat : int = 0


var breadAvalonia = product.new("bread", "res://Image-assets/breadIcon.png", 0, 0 ,15, 1, 0.01, 2, 0.02, 2, 2, 1, 0, 15,true, [ingredients.flour]) #name, count, level, levelCost, prod.amount, bakeSpeed, bakeTime
var cookieAvalonia = product.new("cookie", "res://Image-assets/cookieIcon.png", 0, 0, 250, 1,0.01, 5, 0.02, 2, 5, 1, 0, 300,false, [ingredients.flour, ingredients.sugar])


var breadBakAvaS = supervisor.new(false, 100, "breadAvalonia", "bakery") #isHired, price, targetProduct, type
var cookieBakAvaS = supervisor.new(false, 3, "cookieAvalonia", "bakery")
var breadStorAvaS = supervisor.new(false, 5, "breadAvalonia", "store")
var cookieStorAvaS = supervisor.new(false, 6, "cookieAvalonia", "store")


var arrayOfItems = [breadAvalonia, cookieAvalonia, ingredients.flour, ingredients.sugar]


func setUsername(name):
	username = name

func setAvatar(filePath):
	avatar = filePath

func addToMoney(amount):
	money = money + amount

func subFromMoney(amount):
	money = money - amount


class bakery:
	var productsDict = {}
	var supervisorDict = {}

	func _init(dictOfProducts : Dictionary, dictOfSupervisors : Dictionary):
		productsDict = dictOfProducts
		supervisorDict = dictOfSupervisors
	func addProduct(key : String, product : product):
		productsDict[key] = product
	func remove(key : String):
		productsDict.erase(key)

class store:
	var supervisorDict = {}

	func _init(setSupervisorDict : Dictionary):
		supervisorDict = setSupervisorDict

class supervisor:
	var isSupervisorHired : bool
	var supervisorCost : int
	var supervisorType : String #bakery or store for different path nodes
	var supervisorTarget : String

	func _init(setSupervisorCount : int, setSupervisorCost:int, setSupervisorTarget:String, setSupervisorType : String):
		isSupervisorHired = setSupervisorCount
		supervisorCost = setSupervisorCost
		supervisorTarget = setSupervisorTarget
		supervisorType = setSupervisorType

	func setSupervisorHired(state:bool):
		isSupervisorHired = state
	func addSupervisorCost(amount: int):
		supervisorCost += amount
	func setSupervisorTarget(targetProduct:String):
		supervisorTarget = targetProduct
	func setSupervisorType(type : String):
		supervisorType = type

class product:
	var name : String
	var icon : String
	var quantity : int
	var bakeryProductLevel : int
	var bakeryLevelCost : float
	var produceAmount : int
	var bakeSpeedMultiplier : float
	var bakeTime : float

	var sellSpeedMultiplier : float
	var sellTime : float
	var sellPrice : int
	var sellAmount : int
	var storeProductLevelCount : int
	var storeLevelCost : float

	var isUnlocked : bool
	var ingredients : Array

	func _init(setName : String, setProductIcon : String, setProductCount : int, setBakeryProductLevel : int, setBakeryLevelCost : float, setProduceAmount : int, setBakeSpeed : float, setBakeTime : float, setSellSpeed : float, setSellTime : float, setSellPrice : int, setSellAmount : int, setStoreLevelCount : int, setStoreLevelCost : float, setIsUnlocked:bool,setIngredients : Array):
		name = setName
		icon = setProductIcon
		quantity = setProductCount
		bakeryProductLevel = setBakeryProductLevel
		bakeryLevelCost = setBakeryLevelCost
		produceAmount = setProduceAmount
		bakeSpeedMultiplier = setBakeSpeed
		bakeTime = setBakeTime
		sellSpeedMultiplier = setSellSpeed
		sellTime = setSellTime
		sellPrice = setSellPrice
		sellAmount = setSellAmount
		storeProductLevelCount = setStoreLevelCount
		storeLevelCost = setStoreLevelCost
		isUnlocked = setIsUnlocked
		ingredients = setIngredients

	func addToProductCount(amount : int):
		quantity += amount

	func addBakeryProductLevel(amount : int):
		bakeryProductLevel += amount

	func setBakeryLevelCost(percentage : float):
		bakeryLevelCost = bakeryLevelCost + (bakeryLevelCost * percentage)

	func setBakeTime():
		bakeTime = bakeTime - (bakeTime * bakeSpeedMultiplier)

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

