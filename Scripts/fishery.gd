extends Control



func _ready():
	ui()


func ui():
	$fishTimer.wait_time = s_fish.fishingTime
	$fisheryBtn/levelBkgr/levelCost.text = shortenMoney.shortenMoney(s_fish.fishingLevelCost)
	$fisheryBtn/levelBkgr/levelCount.text = str(s_fish.fishingLevel)

func _on_fisheryBtn_pressed():
	$fisheryBtn/progressBarBody.show()
	$fishTimer.start()
	$progressTimer.start()
	$fishTimer.autostart = 0
	$progressTimer.autostart = 0
	$fisheryBtn.disabled = 1
	pass # Replace with function body
	#show progress bar -done
	#start timer and progress bar - done
	#at timeout give player a random quantity of random species
	#add fishes to inventory


func _on_progressTimer_timeout():
	var current_progress = ($fishTimer.wait_time - $fishTimer.time_left) / $fishTimer.wait_time 
	$fisheryBtn/progressBarBody/progressBar.set("value", current_progress)
	ui()


func _on_fishTimer_timeout():
	$fishTimer.stop()
	$progressTimer.stop()
	$fisheryBtn/progressBarBody/progressBar.set("value", 0.00)
	$fisheryBtn.disabled = 0
	$fisheryBtn/progressBarBody.hide()
	print("test")
