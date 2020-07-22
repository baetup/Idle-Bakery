extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$paymentLabel/paySlider.value = S_farmers.salary
	updateUi()

func updateUi():
	$paymentLabel/paySlider.min_value = S_farmers.minSalary
	$paymentLabel/paySlider.max_value = S_farmers.maxSalary
	$paymentLabel.text = "Farmer salary / day: " + str(S_farmers.salary) + " coins"
	$staffPanel/hiredStaffLabel/staffCount.text = str(S_farmers.count)
	$staffPanel/hireStaffBtn/btnLabel.text = "Hire: " + str(shortenMoney.shortenMoney(S_farmers.hireCost)) + " coins"
	moodChecker()
	if S_farmers.hireCost > globals.money :
		$staffPanel/hireStaffBtn.disabled = 1
	else:
		$staffPanel/hireStaffBtn.disabled = 0


func _on_checkUi_timeout():
	updateUi()


func _on_paySlider_value_changed(value):
	S_farmers.setSalary(value)
	S_farmers.setTotalSalary(S_farmers.count)


func _on_hireStaffBtn_pressed():
	if globals.money >= S_farmers.hireCost:
		S_farmers.farmerArray.push_back(S_farmers.farmer.new(0,0,0))
		S_farmers.addCount(1)
		S_farmers.setTotalSalary(S_farmers.count)
		globals.subFromMoney(S_farmers.hireCost)
		S_farmers.increaseHireCost()


func moodChecker():	
# warning-ignore:integer_division
# warning-ignore:integer_division
# warning-ignore:integer_division
	if S_farmers.salary > ((S_farmers.maxSalary / 2)/2) && S_farmers.salary < S_farmers.maxSalary / 2:
		S_farmers.mood = "low"
		$staffPanel/staffMoodLabel.text = "Farmers mood : " + S_farmers.mood
# warning-ignore:integer_division
# warning-ignore:integer_division
	elif S_farmers.salary < ((S_farmers.maxSalary / 2 ) / 2):
		S_farmers.mood = "very low"
		$staffPanel/staffMoodLabel.text = "Farmers mood : " + S_farmers.mood
# warning-ignore:integer_division
# warning-ignore:integer_division
# warning-ignore:integer_division
	elif S_farmers.salary > S_farmers.maxSalary / 2 && S_farmers.salary < S_farmers.maxSalary - ((S_farmers.maxSalary / 2) / 2) :
		S_farmers.mood = "moderate"
		$staffPanel/staffMoodLabel.text = "Farmers mood : " + S_farmers.mood
# warning-ignore:integer_division
# warning-ignore:integer_division
	elif S_farmers.salary > S_farmers.maxSalary - ((S_farmers.maxSalary / 2) / 2):
		S_farmers.mood = "happy"
		$staffPanel/staffMoodLabel.text = "Farmers mood : " + S_farmers.mood


	
	
