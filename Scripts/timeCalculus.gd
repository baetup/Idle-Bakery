extends Node
 

func calculate(n):
	
	var time = int(n)
	var day = time / (24 * 3600) 
  
	time = time % (24 * 3600) 
	var hour = time / 3600
  
	time %= 3600
	var minutes = time / 60
  
	time %= 60
	var seconds = time 
	
	if day != 0 :
		return str(day) + "d "+ str(hour) +  "h " + str(minutes) + "min " + str(seconds) + "sec"
	elif day == 0 && hour != 0:
		return str(hour) +  "h " + str(minutes) + "min " + str(seconds) + "sec"
	elif day == 0 && hour == 0 && minutes != 0:
		return str(minutes) + "min " + str(seconds) + "sec"
	elif day == 0 && hour == 0 && minutes == 0 && seconds != 0:
		return str(seconds) + "sec"
	
