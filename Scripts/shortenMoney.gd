extends Node


func short(num, ends=["", "K", "M", "B", "T","QD", "QT", "SX", "SP", "OC", "NO", "DC", "UD", "DD", "TD"]):
	
	var mainDivision
	var stringifyNumber
	var splitDivision
	var sizeOfNum = str(num).length()
	
	#1 - 999 case
	if sizeOfNum > 0 && sizeOfNum < 4:
		return num
	#1000 - 999 999 case 
	if sizeOfNum > 3 && sizeOfNum < 7:
		mainDivision = num / pow (10, 3)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])
	#1 000 000 - 999 999 999
	if sizeOfNum > 6 && sizeOfNum < 10:
		mainDivision = num / pow (10, 6)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])
	#1 000 000 000 - 999 999 999 999
	if sizeOfNum > 9 && sizeOfNum < 13:
		mainDivision = num / pow (10, 9)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])
	#1 000 000 000 000 - 999 999 999 999 999
	if sizeOfNum > 12 && sizeOfNum < 16:
		mainDivision = num / pow (10, 12)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])
	#1 000 000 000 000 000 - 999 999 999 999 999 999
	if sizeOfNum > 15 && sizeOfNum < 19:
		mainDivision = num / pow (10, 15)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])
	#1 000 000 000 000 000 000 -  9 223 372 036 854 775 806
	if sizeOfNum == 19:
		mainDivision = num / pow (10, 18)
		stringifyNumber = str(mainDivision)
		splitDivision = stringifyNumber.split(".")
		return splitDivision[0] + "." + splitDivision[1].left(2) + str(ends[int(floor(logWithBase(num, 10))/3)])

func logWithBase(value, base):
	return log(value) / log(base)
