extends Node2D


onready var drag_timer = get_node("/root/GameManager/villageAvalonia/dragTimer")


	
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
	#elif nodeValue == "farmBtn":
		#get_node("/root/GameManager/villageAvalonia/UiCanvas/farm").show()
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
	
	
	
	
