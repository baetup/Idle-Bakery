extends Node

var resource_path = "res://"

#Archery Range Queue
var bowmenQueueLimit = 25
var bowmenQueue = 0
var bowmenQueueTime = 0
var bowmenQueueInProgress = false
var bowmenQueueTimeLeft = 0 

var lbQueueLimit = 25
var lbQueue = 0
var lbQueueTime = 0
var lbQueueInProgress = false
var lbQueueTimeLeft = 0

#avaloniaArmy
var avaloniaBowman = load(resource_path + "troops/bowman.tres")
var avaloniaLB = load(resource_path + "troops/longBowman.tres")
var avaloniaHC = load(resource_path + "troops/heavyCavalry.tres")
var avaloniaKnight = load(resource_path + "troops/knight.tres")
var avaloniaSpMan = load(resource_path + "troops/spearman.tres")
var avaloniaSwMan = load(resource_path + "troops/swordsman.tres")
var avaloniaLC = load(resource_path  + "troops/lightCavalry.tres")

#v1 army
var v1_bowman = load(resource_path + "troops/v1_bowman.tres")
var v1_LB = load(resource_path + "troops/v1_LB.tres")
var v1_HC = load(resource_path + "troops/v1_HC.tres")
var v1_Knight = load(resource_path + "troops/v1_knight.tres")
var v1_SpMan = load(resource_path + "troops/v1_SpMan.tres")
var v1_SwMan = load(resource_path + "troops/v1_SwMan.tres")
var v1_LC = load(resource_path + "troops/v1_LC.tres")


func battle(army1 : Array, playerAttacks : bool):
	if playerAttacks:
		var HC = s_army.avaloniaHC
		var LC = s_army.avaloniaLC
		var K = s_army.avaloniaKnight
		
	
	

func load_resource():
	avaloniaBowman = load(resource_path + "troops/bowman.tres")
	avaloniaLB = load(resource_path + "troops/longBowman.tres")
	avaloniaHC = load(resource_path + "troops/heavyCavalry.tres")
	avaloniaKnight = load(resource_path + "troops/knight.tres")
	avaloniaSpMan = load(resource_path + "troops/spearman.tres")
	avaloniaSwMan = load(resource_path + "troops/swordsman.tres")
	avaloniaLC = load(resource_path  + "troops/lightCavalry.tres")

	v1_bowman = load(resource_path + "troops/v1_bowman.tres")
	v1_LB = load(resource_path + "troops/v1_LB.tres")
	v1_HC = load(resource_path + "troops/v1_HC.tres")
	v1_Knight = load(resource_path + "troops/v1_Knight.tres")
	v1_SpMan = load(resource_path + "troops/v1_SpMan.tres")
	v1_SwMan = load(resource_path + "troops/v1_SwMan.tres")
	v1_LC = load(resource_path + "troops/v1_LC.tres")
