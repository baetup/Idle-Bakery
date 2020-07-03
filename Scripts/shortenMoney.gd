extends Node



func _ready():
	pass # Replace with function body.

#Function created to abbreviate money
static func shortenMoney(money):
	var stageOne = 1000.00
	var stringDot = "."
	var suffixArray = ["K", "M", "B", "T", "QD", "QI", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD"]
	var moneyLabel = str(money)
	
	if money < 1000:
		var stringMoney = str(money)
		var splitNumber = stringMoney.split(".")
		moneyLabel = splitNumber[0]
	
	if money > 999: # Case for 1k ~ 999k
		var splitMoney = money / stageOne #Dividing in order to get shorter version of the number
		var stringSplitMoney = str(splitMoney) #Transforming the result of the divide into a string
		var splitNumber = stringSplitMoney.split(".") #Separating the number into an array with two indexes

		var firstDigit = ""
		var secondDigit = ""
		
		moneyLabel = str(splitMoney) + suffixArray[0]
		
		if splitNumber.size() > 1:
			firstDigit = splitNumber[0]
			var secondDecimalArray = splitNumber[1]
			secondDigit = secondDecimalArray[0] #Assigning the first entry in the array to the first digit variable

		else:
			firstDigit= splitNumber[0]
			secondDigit= ""
		
		if stringDot in stringSplitMoney:
			moneyLabel = firstDigit + "." + secondDigit + suffixArray[0]

	if money > 999999: # Case for 1k ~ 999 999k
		var splitMoney = money / (stageOne * stageOne) #Dividing in order to get shorter version of the number
		var stringSplitMoney = str(splitMoney) #Transforming the result of the divide into a string
		var splitNumber = stringSplitMoney.split(".") #Separating the number into an array with two indexes

		var firstDigit = ""
		var secondDigit = ""
		
		moneyLabel = str(splitMoney) + suffixArray[1]
		
		if splitNumber.size() > 1:
			firstDigit = splitNumber[0]
			var secondDecimalArray = splitNumber[1]
			secondDigit = secondDecimalArray[0] #Assigning the first entry in the array to the first digit variable

		else:
			firstDigit= splitNumber[0]
			secondDigit= ""
		
		if stringDot in stringSplitMoney:
			moneyLabel = firstDigit + "." + secondDigit + suffixArray[1]
			
	return str(moneyLabel)
