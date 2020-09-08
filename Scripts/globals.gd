extends Node

var resource_path = "res://"
var day = 1
var money = 920
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
var avatarPlayerGender = "male"



var breadAvalonia = load(resource_path + "products/breadAvalonia.tres")
var cookieAvalonia = load(resource_path +  "products/cookieAvalonia.tres")


var breadBakAvaS = load(resource_path +  "supervisors/breadBakAvaS.tres")
var cookieBakAvaS = load(resource_path +  "supervisors/cookieBakAvaS.tres")
var breadStorAvaS = load(resource_path + "supervisors/breadStorAvaS.tres")
var cookieStorAvaS = load(resource_path +  "supervisors/cookieStorAvaS.tres")

var arrayOfIngredients = [ingredients.flour, ingredients.sugar]
var arrayOfProducts = [breadAvalonia, cookieAvalonia]
var arrayOfItems = [breadAvalonia, cookieAvalonia, ingredients.flour, ingredients.sugar]

var mainCastle = load(resource_path +  "misc_objects/mainCastle.tres")


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

func loadResource():
	breadAvalonia = load(resource_path + "products/breadAvalonia.tres")
	breadAvalonia.ingredients[0] = ingredients.flour
	
	cookieAvalonia = load(resource_path +  "products/cookieAvalonia.tres")
	cookieAvalonia.ingredients[0] = ingredients.flour
	cookieAvalonia.ingredients[1] = ingredients.sugar
			
	breadBakAvaS = load(resource_path +  "supervisors/breadBakAvaS.tres")
	cookieBakAvaS = load(resource_path +  "supervisors/cookieBakAvaS.tres")
	breadStorAvaS = load(resource_path + "supervisors/breadStorAvaS.tres")
	cookieStorAvaS = load(resource_path +  "supervisors/cookieStorAvaS.tres")
	
	mainCastle =load(resource_path +  "misc_objects/mainCastle.tres")

	arrayOfIngredients = [ingredients.flour, ingredients.sugar]
	arrayOfProducts = [breadAvalonia, cookieAvalonia]
	arrayOfItems = [breadAvalonia, cookieAvalonia, ingredients.flour, ingredients.sugar]
