extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$staffPanel/paymentLabel/paySlider.value = S_farmers.salary
	updateUi()

func updateUi():
	$staffPanel/paymentLabel/paySlider.min_value = S_farmers.minSalary
	$staffPanel/paymentLabel/paySlider.max_value = S_farmers.maxSalary
	$staffPanel/paymentLabel.text = "Farmer salary / day: " + str(shortenMoney.shortenMoney(S_farmers.salary)) + " coins"
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
		S_farmers.farmerArray.push_back(S_farmers.farmer.new(0))
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

func _on_upgradesButton_pressed():
	$upgradesBkgr.visible = 1
	$upgradesBtnBkgr.set_texture(load("res://Image-assets/title blue-no-text.png"))
	$farmBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$staffPanel.visible = 0
	$farmBkgr.visible = 0

func _on_farmButton_pressed():
	$farmBkgr.visible = 1
	$farmBtnBkgr.set_texture(load("res://Image-assets/title blue-no-text.png"))
	$upgradesBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$openStaff.set_normal_texture(load("res://Image-assets/title-grey-small.png"))
	$upgradesBkgr.visible = 0
	$staffPanel.visible = 0

func _on_openStaff_pressed():
	$staffPanel.visible = 1
	$openStaff.set_normal_texture(load("res://Image-assets/title-blue-small.png"))
	$farmBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$upgradesBtnBkgr.set_texture(load("res://Image-assets/title grey-no-text.png"))
	$upgradesBkgr.visible = 0
	$farmBkgr.visible = 0

func _on_close_pressed():
	$".".visible = 0
