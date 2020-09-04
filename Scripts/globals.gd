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




var breadAvalonia = load("res://products/breadAvalonia.tres")
var cookieAvalonia = load("res://products/cookieAvalonia.tres")


var breadBakAvaS = load("res://supervisors/breadBakAvaS.tres")
var cookieBakAvaS = load("res://supervisors/cookieBakAvaS.tres")
var breadStorAvaS = load("res://supervisors/breadStorAvaS.tres")
var cookieStorAvaS = load("res://supervisors/cookieStorAvaS.tres")

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


class notification :
	
	var type : String
	var village: String
	var target : String
	var isActive : bool
	
	func _init(setType='', setVillage='', setTarget='',setActive=''):
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

	
	func _init(setIsFirstOpen='', setIsPlayerMarried='',setPlayerParner='',setMonokeCurseTimer='', isMonokeCurseOn=''):
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
	
