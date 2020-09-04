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

var mainCastle =load("res://misc_objects/mainCastle.tres")


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



