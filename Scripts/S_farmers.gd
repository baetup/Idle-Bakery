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
	if globals.money >= totalSalary:
		globals.subFromMoney(totalSalary)
	elif globals.money < totalSalary:
		var negativeDifference = totalSalary - globals.money
		var unpaidFarmers = negativeDifference / salary
		var paidFarmers = count - unpaidFarmers
		globals.subFromMoney(paidFarmers * salary)
			

func paymentLeave():
	print("test1")
	if count > 0 :
		var differenceSum = globals.money - totalSalary
		if differenceSum > 0:
			print("test differenceSum > 0")
			var temp = 0
			for x in farmerArray:
				farmerArray[temp].dayOne = 0
				temp += 1
		
		if differenceSum < 0:
			print("test difference < 0")
			differenceSum = differenceSum * (-1)
			unpaidFarmersToday = differenceSum / salary
			var temp = 0
			var temp2 = 0
			var removedFarmers = 0
		
			for x in unpaidFarmersToday:
				if farmerArray[temp].dayOne == 1:
					print("farmer has day one checked")
					farmerArray.remove(temp)
					removeCount(1)
					setTotalSalary(count)
					removedFarmers += 1
					unpaidFarmersToday = unpaidFarmersToday - 1
				
			
			for x in unpaidFarmersToday - removedFarmers:
				print("test set day one to unpaid")
				farmerArray[temp2].dayOne = 1
				print(farmerArray[temp2].dayOne)
				temp2 += 1
			
			unpaidFarmersToday = 0
	

class farmer:
	
	var consecDaysUnpaid : int
	var dayOne : int
	var dayTwo : int


	func _init(setDays, setDOne, setDTwo):
		consecDaysUnpaid = setDays
		dayOne = setDOne
		dayTwo = setDTwo
		


