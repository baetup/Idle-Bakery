extends Control


func _ready():
	firstOpen()
	setNames()
	checkStatus()

func setNames():
	if globals.avatarPlayerGender == "male":
		$castlePanel/bkgr/vbox/portrait0/name.text = "Monoke"
		$castlePanel/bkgr/vbox/portrait1/name.text = "Ary"
	if globals.avatarPlayerGender == "female":
		$castlePanel/bkgr/vbox/portrait0/name.text = "Arthur"
		$castlePanel/bkgr/vbox/portrait1/name.text = "Casmo"
	if globals.avatarPlayerGender == "other":
		$castlePanel/bkgr/vbox/portrait0/name.text = "Suqoo"
		$castlePanel/bkgr/vbox/portrait1/name.text = "Cebus"

#If it is the first time opening the castle
func firstOpen():
	if globals.castleFirstOpen:
		$kingDialog1.visible = 1
		globals.castleFirstOpen = false
	else:
		$kingDialog1.visible = 0

#First dialogue with the King : Box1
func _on_next1_pressed():
	$kingDialog1/text1.visible = 0
	$kingDialog1/text2.visible = 1

#First dialogue with the King : Box2
func _on_next2_pressed():
	$kingDialog1.visible = 0

#Checking if condition has been met to marry the first
func checkStatus():

	if globals.prestigeLevel >= 50 :
		$castlePanel/bkgr/vbox/portrait0/actionFirst.disabled = 0
		$castlePanel/bkgr/vbox/portrait0/actualStatus.text = "Willing"
		
		$castlePanel/bkgr/vbox/portrait1/actionSecond.disabled = 0
		$castlePanel/bkgr/vbox/portrait1/actualStatus.text = "Willing"

	else:
		$castlePanel/bkgr/vbox/portrait0/actionFirst.disabled = 1
		$castlePanel/bkgr/vbox/portrait0/actualStatus.text = "Unwilling"
		
		$castlePanel/bkgr/vbox/portrait1/actionSecond.disabled = 1
		$castlePanel/bkgr/vbox/portrait1/actualStatus.text = "Unwilling"


#If condition has been met to marry and btn is pressed:
func _on_actionFirst_pressed():

	globals.isPlayerMarried = true
	$castlePanel/bkgr/vbox/portrait0/actualStatus.text = "Married"
	
	#disconnecting the existing signal to assign the region
	$castlePanel/bkgr/vbox/portrait0/actionFirst.disconnect("pressed",self,"_on_actionFirst_pressed")
	# warning-ignore:return_value_discarded
	$castlePanel/bkgr/vbox/portrait0/actionFirst.connect("pressed",self,"changeActionFirst")
	$castlePanel/bkgr/vbox/portrait0/actionFirst/btnLabel.text = "Assign"


func _on_actionSecond_pressed():

	globals.isPlayerMarried = true
	$castlePanel/bkgr/vbox/portrait1/actualStatus.text = "Married"
	
	#disconnecting the existing signal to assign the region
	$castlePanel/bkgr/vbox/portrait1/actionSecond.disconnect("pressed",self,"_on_actionSecond_pressed")
	# warning-ignore:return_value_discarded
	$castlePanel/bkgr/vbox/portrait1/actionSecond.connect("pressed",self,"changeActionSecond")
	$castlePanel/bkgr/vbox/portrait1/actionSecond/btnLabel.text = "Assign"

#Changing what the button is and does after marriage
func changeActionFirst():
	$castlePanel/bkgr/vbox/portrait1/actionSecond.disabled = 1
	$castlePanel/bkgr/vbox/portrait0/actualStatus.text = ""
	if globals.avatarPlayerGender == "male":
		$"castlePanel/bkgr/vbox/portrait0/status ".text = "Avalonia Princess"
	elif globals.avatarPlayerGender == "female":
		$"castlePanel/bkgr/vbox/portrait0/status ".text = "Avalonia Prince"
	else:
		$"castlePanel/bkgr/vbox/portrait0/status ".text = "Avalonia Princess"
	$castlePanel/bkgr/vbox/portrait0/actionFirst/btnLabel.text = "Married"
	$castlePanel/bkgr/vbox/portrait1/actualStatus.text = "Unwilling"
	$castlePanel/bkgr/vbox/portrait0/actionFirst.disabled = 1

func changeActionSecond():
	$castlePanel/bkgr/vbox/portrait0/actionFirst.disabled = 1
	$castlePanel/bkgr/vbox/portrait1/actualStatus.text = ""
	if globals.avatarPlayerGender == "male":
		$"castlePanel/bkgr/vbox/portrait1/status ".text = "Avalonia Princess"
	elif globals.avatarPlayerGender == "female":
		$"castlePanel/bkgr/vbox/portrait1/status ".text = "Avalonia Prince"
	else:
		$"castlePanel/bkgr/vbox/portrait1/status ".text = "Avalonia Prince"
	$castlePanel/bkgr/vbox/portrait1/actionSecond/btnLabel.text = "Married"
	$castlePanel/bkgr/vbox/portrait0/actualStatus.text = "Unwilling"
	$castlePanel/bkgr/vbox/portrait1/actionSecond.disabled = 1

func _on_close_pressed():
	visible = 0


func _on_info_pressed():
	$castlePanel/bkgr/infoDisket.visible = 1
	
	$castlePanel/bkgr/infoDisket/desc.text = "Content description for character"
	$castlePanel/bkgr/infoDisket/traits.text = "Disadvantages + traits"


func _on_infoDisket_pressed():
	$castlePanel/bkgr/infoDisket.visible = 0


func _on_info2_pressed():
	$castlePanel/bkgr/infoDisket2.visible = 1

	$castlePanel/bkgr/infoDisket2/desc.text = "Content description for character"
	$castlePanel/bkgr/infoDisket2/traits.text = "Disadvantages + traits"

func _on_infoDisket2_pressed():
	$castlePanel/bkgr/infoDisket2.visible = 0


