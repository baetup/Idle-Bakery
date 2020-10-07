extends Node

var resource_path = "res://"

var battleInProgess = false
var battleTimer = 0
var battleDetails = ""

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


func battle(sendingVillage, targetVillage, playerAttacks : bool):
	var sVPwr = 0 # sending village army power
	var tVPwr = 0 # target village army power
	
	# calculating sending village army power (attack)
	for troop in sendingVillage.army :
		sVPwr = sVPwr + (troop.count * troop.attack)
	
	# calculating target village army power (defense)
	for troop in targetVillage.army :
		tVPwr = tVPwr + (troop.count * troop.armor)
		
	# if attacker wins
	if sVPwr > tVPwr :
		print("attacking village won")
		#setting looser side army to 0
		for troop in targetVillage.army:
			troop.count = 0

		# calculating casualties for winning side
		var totalBattlePwr = sVPwr + tVPwr
		var pwrDiff = sVPwr - tVPwr
		var casualtiesPercentage = ((pwrDiff * 100) / totalBattlePwr) * 0.01

		# substracting casualties from the winning army
		for troop in sendingVillage.army:
			troop.count *= casualtiesPercentage
	# if defender wins
	elif sVPwr < tVPwr :
		print("target village won")
		#setting loserside army to 0
		for troop in sendingVillage.army:
			troop.count = 0

		# calculating casualties for winning side
		var totalBattlePwr = sVPwr + tVPwr
		var pwrDiff = tVPwr - sVPwr
		var casualtiesPercentge = ((pwrDiff * 100) / totalBattlePwr) * 0.01

		# substracting casualties from winning army
		for troop in targetVillage.army:
			troop.count *= casualtiesPercentge
	# if its a power tie
	elif sVPwr == tVPwr:
		#set both armies to 0
		for troop in sendingVillage.army:
			troop.count = 0
			
		for troop in targetVillage.army:
			troop.count = 0

func setBattleTimer(value) :
	battleTimer = value

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
