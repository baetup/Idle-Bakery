extends Node2D


onready var drag_timer = get_node("/root/GameManager/villageAvalonia/dragTimer")
onready var mainBuildings = get_node("/root/GameManager/villageAvalonia/buttonsCollider/mainBuildings")
onready var secondaryBuildings = get_node("/root/GameManager/villageAvalonia/buttonsCollider/secondaryBuildings")
onready var worldMap = get_node("/root/GameManager/worldMap")

func _input(event):

	if event is InputEventScreenTouch && event.is_pressed():
		drag_timer.start(1.25)
	if event is InputEventScreenTouch && event.is_pressed() == false && drag_timer.time_left > 1.10:
		#insert what needs to open here
		var mouse_pos = get_global_mouse_position()
		var node = identifyUI(mouse_pos)
		indentifyNode(node)
		drag_timer.stop()
		drag_timer.wait_time = 1

func identifyUI(position : Vector2):
	var space_state = get_world_2d().direct_space_state
	var collidingAreas = space_state.intersect_point( position, 1, [], 2147483647, true, true)
	var collidingNode = collidingAreas[0]['collider'] if collidingAreas.empty() != true else "ground"
	if typeof(collidingNode) == typeof(Node):
		return collidingNode.name
	else:
		return collidingNode

func indentifyNode(nodeValue : String):
	if nodeValue == "bakeryBtn":
		get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery").show()
	elif nodeValue == "storeBtn":
		get_node("/root/GameManager/villageAvalonia/UiCanvas/store").show()
		hideColliders()
	elif nodeValue == "farmBtn":
		get_node("/root/GameManager/villageAvalonia/UiCanvas/farm").show()
	elif nodeValue == "workshopBtn":
		get_node("/root/GameManager/villageAvalonia/UiCanvas/workshop").show()
	elif nodeValue == "fisheryProduce":
		get_node("/root/GameManager/villageAvalonia/fishery")._on_fisheryBtn_pressed()
	elif nodeValue == "fisheryUpgrade":
		get_node("/root/GameManager/villageAvalonia/fishery")._on_upgradefishery_pressed()
	elif nodeValue == "huntingProduce":
		get_node("/root/GameManager/villageAvalonia/huntingCabin")._on_huntingBtn_pressed()
	elif nodeValue == "huntingUpgrade":
		get_node("/root/GameManager/villageAvalonia/huntingCabin")._on_upgradehunting_pressed()
	elif nodeValue == "castleBtn":
		get_node("/root/GameManager/villageAvalonia")._on_getCastleOpen_pressed()
	elif nodeValue == "estateBtn":
		get_node("/root/GameManager/villageAvalonia")._on_ClickMoneyButton_pressed()
	elif nodeValue == "archeryRange":
		get_node("/root/GameManager/villageAvalonia/UiCanvas/archeryRange").show()
		hideColliders()
		hideSecondaryColliders()
	
	#secondary buildings
	elif nodeValue == "building1":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building1")._on_Buy_Buildings()
	elif nodeValue == "building2":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building2")._on_Buy_Buildings()
	elif nodeValue == "building3":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building3")._on_Buy_Buildings()
	elif nodeValue == "building4":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building4")._on_Buy_Buildings()
	elif nodeValue == "building5":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building5")._on_Buy_Buildings()
	elif nodeValue == "building6":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building6")._on_Buy_Buildings()
	elif nodeValue == "building7":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building7")._on_Buy_Buildings()
	elif nodeValue == "building8":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building8")._on_Buy_Buildings()
	elif nodeValue == "building9":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building9")._on_Buy_Buildings()
	elif nodeValue == "building10":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building10")._on_Buy_Buildings()
	elif nodeValue == "building11":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building11")._on_Buy_Buildings()
	elif nodeValue == "building12":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building12")._on_Buy_Buildings()
	elif nodeValue == "building13":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building13")._on_Buy_Buildings()
	elif nodeValue == "building14":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building14")._on_Buy_Buildings()
	elif nodeValue == "building15":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building15")._on_Buy_Buildings()
	elif nodeValue == "building16":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building16")._on_Buy_Buildings()
	elif nodeValue == "building17":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building17")._on_Buy_Buildings()
	elif nodeValue == "building18":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building18")._on_Buy_Buildings()
	elif nodeValue == "building19":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building19")._on_Buy_Buildings()
	elif nodeValue == "building20":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building20")._on_Buy_Buildings()
	elif nodeValue == "building21":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building21")._on_Buy_Buildings()
	elif nodeValue == "building22":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building22")._on_Buy_Buildings()
	elif nodeValue == "building23":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building23")._on_Buy_Buildings()
	elif nodeValue == "building24":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building24")._on_Buy_Buildings()
	elif nodeValue == "building25":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building25")._on_Buy_Buildings()
	elif nodeValue == "building26":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building26")._on_Buy_Buildings()
	elif nodeValue == "building27":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building27")._on_Buy_Buildings()
	elif nodeValue == "building28":
		get_node("/root/GameManager/villageAvalonia/incomeBuildings/building28")._on_Buy_Buildings()

	#world-map interactions
	elif nodeValue == "avalonia":
		get_node("/root/GameManager/worldMap")._on_avaloniaVillage_pressed()
	elif nodeValue == "v1":
		get_node("/root/GameManager/worldMap/canvas/attackMenu").showAttackMenu("village1")
		worldMap.disableWorldMapCollisions()

func hideColliders():
	
	for child in mainBuildings.get_children():
		var collision = child.get_children()
		collision[0].disabled = 1

func showColliders():
	for child in mainBuildings.get_children():
		var collision = child.get_children()
		collision[0].disabled = 0

func hideSecondaryColliders():
	for child in secondaryBuildings.get_children():
		var collision = child.get_children()
		collision[0].disabled = 1
			
func showSecondaryColliders():
	for child in secondaryBuildings.get_children():
		var collision = child.get_children()
		collision[0].disabled = 0
			
