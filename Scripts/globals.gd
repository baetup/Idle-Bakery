extends Node

var day = 1
var money = 500
var username : String = ""
var avatar : String= ""
var prestigeLevel : int = 50
var charPoints : int = 5
var neededExp : int = 10 #For level 1
var curExp : int = 0
var cunStat : int = 0
var chrStat : int = 0
var intStat : int = 0
var invStat : int = 0
var notificationArray = []
var avatarPlayerGender = "male"




var breadAvalonia = product.new("bread", "res://Image-assets/breadIcon.png", 0, 0 ,15, 1, 0.01, 2, 0.02, 2, 2, 1, 0, 15,true, [ingredients.flour], "villageAvalonia") #name, count, level, levelCost, prod.amount, bakeSpeed, bakeTime
var cookieAvalonia = product.new("cookie", "res://Image-assets/cookieIcon.png", 0, 0, 250, 1,0.01, 5, 0.02, 2, 5, 1, 0, 300,false, [ingredients.flour, ingredients.sugar],"villageAvalonia")


var breadBakAvaS = supervisor.new(false, 100, "breadAvalonia", "bakery") #isHired, price, targetProduct, type
var cookieBakAvaS = supervisor.new(false, 3, "cookieAvalonia", "bakery")
var breadStorAvaS = supervisor.new(false, 5, "breadAvalonia", "store")
var cookieStorAvaS = supervisor.new(false, 6, "cookieAvalonia", "store")

var arrayOfIngredients = [ingredients.flour, ingredients.sugar]
var arrayOfProducts = [breadAvalonia, cookieAvalonia]
var arrayOfItems = [breadAvalonia, cookieAvalonia, ingredients.flour, ingredients.sugar]

var mainCastle = castle.new(false,false,"", Timer.new(), false) #there should only be one castle instance

func setUsername(name):
	username = name

func setAvatar(filePath):
	avatar = filePath

func addToMoney(amount):
	money = money + amount

func subFromMoney(amount):
	money = money - amount

func setPlayerGender(gender):
	avatarPlayerGender = gender

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
	var sellPrice : float
	var sellAmount : int
	var storeProductLevelCount : int
	var storeLevelCost : float

	var isUnlocked : bool
	var ingredients : Array
	var originBakery : String

	func _init(setName : String, setProductIcon : String, setProductCount : int, setBakeryProductLevel : int, setBakeryLevelCost : float, setProduceAmount : int, setBakeSpeed : float, setBakeTime : float, setSellSpeed : float, setSellTime : float, setSellPrice : int, setSellAmount : int, setStoreLevelCount : int, setStoreLevelCost : float, setIsUnlocked:bool,setIngredients : Array, setBakery):
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
		originBakery = setBakery

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

class notification :
	
	var type : String
	var village: String
	var target : String
	var isActive : bool
	
	func _init(setType, setVillage, setTarget,setActive):
		type = setType
		village = setVillage
		target = setTarget
		isActive = setActive
		
class castle:
	var isFirstOpen : bool
	var isPlayerMarried : bool
	var playerPartner : String
	var monokeCurseTimer : Timer
	var monokeCurseOn : bool

	
	func _init(setIsFirstOpen, setIsPlayerMarried,setPlayerParner,setMonokeCurseTimer, isMonokeCurseOn):
		isFirstOpen = setIsFirstOpen
		isPlayerMarried = setIsPlayerMarried
		playerPartner = setPlayerParner
		monokeCurseTimer = setMonokeCurseTimer
		monokeCurseOn = isMonokeCurseOn
		
	
	func setPlayerPartner(partnerName):
		playerPartner = partnerName
	
	func setMonokeCurseWaitTime(waitTime):
		monokeCurseTimer.wait_time = waitTime
	
	func setMonokeCurseOneshot(boolean):
		monokeCurseTimer.one_shot = boolean
	
	func setMonokeCurseAutostart(boolean):
		monokeCurseTimer.autostart = boolean
	
	func setMonokeCurseState(state):
		monokeCurseOn = state
	
