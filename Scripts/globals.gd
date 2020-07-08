extends Node


var money = 1000
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

var breadAvalonia = product.new("bread", "res://Image-assets/breadIcon.png", 0, 0 ,15, 1, 0.2, 2, 0.2, 2, 2, 1, 0, 15,true) #name, count, level, levelCost, prod.amount, bakeSpeed, bakeTime
var cookieAvalonia = product.new("cookie", "res://Image-assets/cookieIcon.png", 0, 0, 250, 1,0.2, 5, 0.2, 2, 5, 1, 0, 300,false)


var breadBakAvaS = supervisor.new(false, 100, "breadAvalonia", "bakery") #isHired, price, targetProduct, type
var cookieBakAvaS = supervisor.new(false, 3, "cookieAvalonia", "bakery")
var breadStorAvaS = supervisor.new(false, 5, "breadAvalonia", "store")
var cookieStorAvaS = supervisor.new(false, 6, "cookieAvalonia", "store")

var arrayOfProducts = [breadAvalonia, cookieAvalonia]


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
	var productName : String
	var productIcon : String
	var productCount : int
	var bakeryProductLevel : int
	var bakeryLevelCost : float
	var produceAmount : int
	var bakeSpeed : float
	var bakeTime : float

	var sellSpeed : float
	var sellTime : float
	var sellPrice : int
	var sellAmount : int
	var storeLevelCount : int
	var storeLevelCost : float
	
	var isUnlocked : bool

	func _init(name : String, setProductIcon : String, setProductCount : int, setBakeryProductLevel : int, setBakeryLevelCost : float, setProduceAmount : int, setBakeSpeed : float, setBakeTime : float, setSellSpeed : float, setSellTime : float, setSellPrice : int, setSellAmount : int, setStoreLevelCount : int, setStoreLevelCost : float, setIsUnlocked:bool):
		productName = name
		productIcon = setProductIcon
		productCount = setProductCount
		bakeryProductLevel = setBakeryProductLevel
		bakeryLevelCost = setBakeryLevelCost
		produceAmount = setProduceAmount
		bakeSpeed = setBakeSpeed
		bakeTime = setBakeTime
		sellSpeed = setSellSpeed
		sellTime = setSellTime
		sellPrice = setSellPrice
		sellAmount = setSellAmount
		storeLevelCount = setStoreLevelCount
		storeLevelCost = setStoreLevelCost
		isUnlocked = setIsUnlocked

	func addToProductCount(amount : int):
		productCount += amount

	func addBakeryProductLevel(amount : int):
		bakeryProductLevel += amount

	func setBakeryLevelCost(percentage : float):
		bakeryLevelCost = bakeryLevelCost + (bakeryLevelCost * percentage)

	func setProduceAmount(amount : int):
		produceAmount = produceAmount * amount

	func setBakeSpeed(tinyFloat : float):
		bakeSpeed = bakeSpeed * tinyFloat

	func addStoreProductLevel(amount : int):
		storeLevelCount += amount

	func setStoreLevelCost(percentage : float):
		storeLevelCost = storeLevelCost + (storeLevelCost * percentage)

	func setSellAmount(amount : int):
		sellAmount = sellAmount * amount

	func removeFromProductCount(amount : int):
		productCount = productCount - amount
		
	func setIsUnlocked(answer:bool):
		isUnlocked = answer
