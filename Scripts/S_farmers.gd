extends Node


var minSalary :int = (globals.money * 0.01) / 2
var maxSalary :int = (globals.money * 0.1) / 2
var count : int = 0
var salary : int = minSalary
var totalSalary = count * salary
var hireCost = 5
var hireCostMultiplier = 2.3
var mood = ""
var unpaidFarmersToday : int = 0
var vlowLeavePercent = 0.1
var lowLeavePercent  = 0.05
var moderateLeavePercent = 0.02
var dayPassed = false
var farmerArray = []


func setSalary(value):
	salary = value
	
func setTotalSalary(farmers):
	totalSalary = salary * farmers
		
func addCount(value):
	count += value
		
func removeCount(value):
	count = count - value

func increaseHireCost():
	hireCost = hireCost + (hireCost * hireCostMultiplier)

func checkDayPassed(day):
	dayPassed = day
	moodLeave()
	payday()
	paymentLeave()
	dayPassed = false
	

func moodLeave():
	
	if count > 0:
		if mood == "very low":
			var mustLeave = int(ceil(count * vlowLeavePercent))
			farmerArray.resize(farmerArray.size() - mustLeave)
			count = count - mustLeave
		if mood == "low":
			var mustLeave = int(ceil(count * lowLeavePercent))
			farmerArray.resize(farmerArray.size() - mustLeave)
			count = count - mustLeave
		if mood == "moderate":
			var mustLeave = int(ceil(count * moderateLeavePercent))
			farmerArray.resize(farmerArray.size() - mustLeave)
			count = count - mustLeave

func payday():
	#if I got money to pay all, pay all farmers
	if globals.money >= totalSalary:
		globals.subFromMoney(totalSalary)
	#if I dont have money to pay all the workers, pay only how many I can
	elif globals.money < totalSalary:
		var negativeDifference = totalSalary - globals.money
		var unpaidFarmers = negativeDifference / salary
		var paidFarmers = count - unpaidFarmers
		globals.subFromMoney(paidFarmers * salary)
			

#the case when I dont have money to pay all the farmers, some leave
func paymentLeave():


	if count > 0 :
		var differenceSum = globals.money - totalSalary # checking how much money I miss
		if differenceSum > 0: # if I dont miss any money, set that all workers have been payed today
			var temp = 0
			for x in farmerArray:
				farmerArray[temp].paidYestarday = 0
				temp += 1
		
		#if I miss some money, check how many I can't pay and set that they have not been payed today
		if differenceSum < 0:
			differenceSum = differenceSum * (-1)
			unpaidFarmersToday = differenceSum / salary
			var temp = 0
			var temp2 = 0
			var removedFarmers = 0
		
			#remove those that haven't been yestarday + today
			for x in unpaidFarmersToday:
				if farmerArray[temp].paidYestarday == 1:
					farmerArray.remove(temp)
					removeCount(1)
					setTotalSalary(count)
					removedFarmers += 1
					unpaidFarmersToday = unpaidFarmersToday - 1
				
			#tell how many haven't been payed today
			for x in unpaidFarmersToday - removedFarmers:
				farmerArray[temp2].paidYestarday = 1
				print(farmerArray[temp2].paidYestarday)
				temp2 += 1
			
			#reset 
			unpaidFarmersToday = 0
	

class farmer:
	
	var paidYestarday : int

	func _init(setDOne):
		paidYestarday = setDOne
		


