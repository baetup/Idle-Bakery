extends Control

onready var gameManager = get_node("/root/GameManager")

func _ready():
	firstOpen()
	setNames()
	checkStatus()
	

#Setting the names of the characters
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
	if globals.mainCastle.isFirstOpen:
		$kingDialog1.visible = 1
		globals.mainCastle.isFirstOpen = false
	else:
		$kingDialog1.visible = 0

#First dialogue with the King : Box1
func _on_next1_pressed():
	$kingDialog1/text1.visible = 0
	$kingDialog1/text2.visible = 1

#First dialogue with the King : Box2
func _on_next2_pressed():
	$kingDialog1.visible = 0

#Checking if condition has been met to marry, triggers when
#opening the castle, check gameManager
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


#If condition has been met to marry and first btn is pressed:
func _on_actionFirst_pressed():

	globals.mainCastle.isPlayerMarried = true


	#setting player partner
	if globals.avatarPlayerGender == "male":
		globals.mainCastle.setPlayerPartner("Monoke")
	elif globals.avatarPlayerGender == "female":
		globals.mainCastle.setPlayerPartner("Arthur")
	else:
		globals.mainCastle.setPlayerPartner("Suqoo")
		
	checkPlayerPartner()
	
	$castlePanel/bkgr/vbox/portrait0/actualStatus.text = "Married"
	
	#disconnecting the existing signal to assign the region
	$castlePanel/bkgr/vbox/portrait0/actionFirst.disconnect("pressed",self,"_on_actionFirst_pressed")
	# warning-ignore:return_value_discarded
	$castlePanel/bkgr/vbox/portrait0/actionFirst.connect("pressed",self,"changeActionFirst")
	$castlePanel/bkgr/vbox/portrait0/actionFirst/btnLabel.text = "Assign"

#If condition has been met to marry and second btn is pressed:
func _on_actionSecond_pressed():

	globals.mainCastle.isPlayerMarried = true


	#setting player partner
	if globals.avatarPlayerGender == "male":
		globals.mainCastle.setPlayerPartner("Ary")
	elif globals.avatarPlayerGender == "female":
		globals.mainCastle.setPlayerPartner("Casmo")
	else:
		globals.mainCastle.setPlayerPartner("Cebus")

	checkPlayerPartner()

	$castlePanel/bkgr/vbox/portrait1/actualStatus.text = "Married"

	#disconnecting the existing signal to assign the region
	$castlePanel/bkgr/vbox/portrait1/actionSecond.disconnect("pressed",self,"_on_actionSecond_pressed")
	# warning-ignore:return_value_discarded
	$castlePanel/bkgr/vbox/portrait1/actionSecond.connect("pressed",self,"changeActionSecond")
	$castlePanel/bkgr/vbox/portrait1/actionSecond/btnLabel.text = "Assign"

#Changing what the first button is and does after marriage
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

#Changing what the second button is and does after marriage
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

func _on_info_pressed():
	$castlePanel/bkgr/infoDisket.visible = 1
	if globals.avatarPlayerGender == "male":
		$castlePanel/bkgr/infoDisket/desc.bbcode_text = "[color=yellow]Monoke[/color] is known to the public as the older and adventurous daughter of the King. She's always trying something new."
		$castlePanel/bkgr/infoDisket/traits.bbcode_text = "Main traits:\n- Charistmatic\n- Adventurous\n- [color=yellow]Entrepreneur[/color]\n- [color=red]Jealous[/color]"
	elif globals.avatarPlayerGender == "female":
		$castlePanel/bkgr/infoDisket/desc.bbcode_text = "[color=yellow]Arthur[/color] is not the Prince you expect him to be. He enjoys being in war and staying in the barracks with other soldiers."
		$castlePanel/bkgr/infoDisket/traits.bbcode_text = "Main traits:\n- Brave\n- [color=yellow]Will stand up to uprising[/color]\n - [color=red]Weak fighting skills[/color]"
	else:
		$castlePanel/bkgr/infoDisket/desc.bbcode_text = "[color=yellow]Suqoo[/color] is the first born of the King. Many believe that her look is the cause of someone cursing the King."
		$castlePanel/bkgr/infoDisket/traits.bbcode_text = "Main traits:\n- Fierce\n- Suspicious\n - [color=yellow]Rules with an iron fist\n- [color=red]Desires to be the sole ruler[/color]"
		

func _on_infoDisket_pressed():
	$castlePanel/bkgr/infoDisket.visible = 0

func _on_info2_pressed():
	$castlePanel/bkgr/infoDisket2.visible = 1
	if globals.avatarPlayerGender == "male":
		$castlePanel/bkgr/infoDisket2/desc.bbcode_text = "[color=yellow]Ary[/color] is the shy daughter of the King.Many believe she will always leave in her bigger sister's shadow."
		$castlePanel/bkgr/infoDisket2/traits.bbcode_text = "Main traits:\n- Shy\n- Ambitious\n- [color=yellow]Caring[/color]\n-[color=red] Has her own plans[/color]"
	elif globals.avatarPlayerGender == "female":
		$castlePanel/bkgr/infoDisket2/desc.bbcode_text = "[color=yellow]Casmo[/color] has the lifestyle of the kings of old, he enjoys staying at court and dealing with the matters of the people."
		$castlePanel/bkgr/infoDisket2/traits.bbcode_text = "Main traits:\n- Ruler of the people\n- [color=yellow]Listens to the people's needs[/color]\n- [color=red]Has hidden ambitioun[/color] "
	else:
		$castlePanel/bkgr/infoDisket2/desc.bbcode_text = "[color=yellow]Cebus[/color] does not agree the peasants that look at him in disgrace, he will punish anyone."
		$castlePanel/bkgr/infoDisket2/traits.bbcode_text = "Main traits:\n- Fierce\n- [color=yellow]Entrepreneur[/color]\n- [color=red]Peasants don't like him[/color]"

func _on_infoDisket2_pressed():
	$castlePanel/bkgr/infoDisket2.visible = 0

func _on_close_pressed():
	visible = 0


func _on_closeInfoDiske2t_pressed():
	$castlePanel/bkgr/infoDisket2.visible = 0


func _on_closeInfoDisket_pressed():
	$castlePanel/bkgr/infoDisket.visible = 0

func checkPlayerPartner():
	if globals.mainCastle.playerPartner == "Monoke":
		print("monoke")
	if globals.mainCastle.playerPartner == "Ary":
		print("ary")


