extends CenterContainer

onready var worldMap = get_node("/root/GameManager/worldMap")
onready var typeLabel = $pre_attackMenuBkgr/vbox/type
onready var errorLabel = $pre_attackMenuBkgr/vbox/margin2/btns/error
onready var bwCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits1/bw/margin/count
onready var lbCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits1/lb/margin/count
onready var spCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits1/sp/margin/count
onready var swCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits1/sw/margin/count
onready var hcCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits2/hc/margin/count
onready var kCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits2/k/margin/count
onready var lcCount = $pre_attackMenuBkgr/vbox/unitsMargin/vbox/hboxUnits2/lc/margin/count
onready var battleTimer = $battleTimer
onready var duration = $pre_attackMenuBkgr/vbox/durationMargin/duration/actualDuration
onready var attackNotification = get_node("/root/GameManager/UiCanvas/battleNotification")

var targetVillage = ""


func showAttackMenu(village):
	targetVillage = village
	$".".show()
	updateMyArmy()
	duration.text = str(timeCalculus.calculate(calculateDistance() * getSlowestUnit()))
	typeLabel.text = "Attack " + s_villages.get(targetVillage).type
	setIngredients()
	
	if s_army.battleInProgess:
		$pre_attackMenuBkgr/vbox/margin2/btns/attack_btn.material.set_shader_param('grayscale', true)

func _ready():
	updateMyArmy()

func calculateDistance():
	var targetX = s_villages.get(targetVillage).xCoord
	var targetY = s_villages.get(targetVillage).yCoord
	if targetX < 0:
		targetX *= -1
	if targetY < 0 :
		targetY *= -1
	var cellDiff = targetX + targetY
	return cellDiff

func _on_attack_btn_pressed():
	var troops = 0
	for x in s_villages.avaloniaVillage.army:
		troops += x.count
	
	if troops >= 50 && s_army.battleInProgess == false:
		s_army.setBattleTimer(calculateDistance() * getSlowestUnit())
		battleTimer.wait_time = s_army.battleTimer
		s_army.battleInProgess = true
		s_army.battleDetails = "Attacking " + s_villages.get(targetVillage).type + " at coords: (" + str(s_villages.get(targetVillage).xCoord) + "," + str(s_villages.get(targetVillage).yCoord) +")"
		battleTimer.start()
		attackNotification.show()
		_on_close_attackMenu_pressed()
	elif troops <50 && s_army.battleInProgess == false:
		errorLabel.show()
		errorLabel.text = "Not enought troops. At least 50 needed."
	else:
		errorLabel.show()
		errorLabel.text = "Another battle in progress."

func _on_close_attackMenu_pressed():
	$".".hide()
	errorLabel.hide()
	worldMap.enableWorldMapCollisions()

func updateMyArmy():
	bwCount.text = str(shortenMoney.short(s_army.avaloniaBowman.count))
	lbCount.text = str(shortenMoney.short(s_army.avaloniaLB.count))
	spCount.text = str(shortenMoney.short(s_army.avaloniaSpMan.count))
	swCount.text = str(shortenMoney.short(s_army.avaloniaSwMan.count))
	hcCount.text = str(shortenMoney.short(s_army.avaloniaHC.count))
	kCount.text = str(shortenMoney.short(s_army.avaloniaKnight.count))
	lcCount.text = str(shortenMoney.short(s_army.avaloniaLC.count))


func _on_battleTimer_timeout():
	s_army.battle(s_villages.avaloniaVillage, s_villages.get(targetVillage), true)
	s_army.battleInProgess = false
	s_army.battleDetails = ""
	s_army.battleTimer = 0

func getSlowestUnit() -> int:
	var slowestSpeed = 0
	
	for troop in s_villages.avaloniaVillage.army:
		if troop.count > 0 && troop.speed > slowestSpeed:
			slowestSpeed = troop.speed
	return slowestSpeed

func setIngredients():
	for x in s_villages.get(targetVillage).ingredients.size():
		print(s_villages.get(targetVillage).ingredients.size())
		$pre_attackMenuBkgr/vbox/resourcesMargin/ingredientsGrid/smallerVbox1.DUPLICATE_USE_INSTANCING
	
	var ingredientsGridChildren = $pre_attackMenuBkgr/vbox/resourcesMargin/ingredientsGrid.get_children()
	var temp = 0
	for eachChild in ingredientsGridChildren:
		get_node("pre_attackMenuBkgr/vbox/resourcesMargin/ingredientsGrid/"+eachChild.name +"/ingredientIcon").set_texture(load(ingredients.get(s_villages.get(targetVillage).ingredients[temp]).icon))
		get_node("pre_attackMenuBkgr/vbox/resourcesMargin/ingredientsGrid/"+eachChild.name +"/ingredientName").text = s_villages.get(targetVillage).ingredients[temp]
		temp += 1
