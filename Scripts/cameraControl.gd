extends Camera2D

var touch_vector = Vector2()
var primary_touch = false
onready var isBakeryVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery").visible
onready var isAchievementsVisible = get_node("/root/GameManager/UiCanvas/achivements").visible
onready var isStoreVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/store").visible
onready var isUpgradesBakeryVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesBakery").visible
onready var isUpgradesStoreVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/upgradesStore").visible
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var tweenNodePath = get_node("/root/GameManager/Tween")


var rootScreen = "village"
var villageMinZoom = 1.3
var villageMaxZoom = 2.0
var worldMapMinZoom = 5
var worldMapMaxZoom = 8
var avaloniaCameraPosition = Vector2(217,384)
var albionCameraPosition = Vector2(500, 700)
var zoom_sensitivity = 10
var zoom_speed = 0.15

var events = {}
var last_drag_distance = 0

var current_zoom = get_zoom()
var transition_time = 0.7

var wasLLWorldMap = false
var wasLLAvalonia = true
var wasLLAlbion = false

func _ready():
	set_process_input(true)
	$".". zoom = Vector2(villageMaxZoom,villageMaxZoom)

#Zooming and panning feature
func _unhandled_input(event):
	if isBakeryVisible != true && isStoreVisible != true && isAchievementsVisible != true && isUpgradesBakeryVisible != true && isUpgradesStoreVisible != true:
		if event is InputEventScreenTouch:
			$".".smoothing_enabled = true
			if event.pressed:
				events[event.index] = event
			else:
				events.erase(event.index)

	if isBakeryVisible != true && isStoreVisible != true && isAchievementsVisible != true && isUpgradesBakeryVisible != true && isUpgradesStoreVisible != true:
		if event is InputEventScreenDrag:
			events[event.index] = event
			if events.size() == 1:
				$".".smoothing_enabled = true
				position -= event.relative * zoom.x
			elif events.size() == 2:
				$".".smoothing_enabled = true
				var drag_distance = events[0].position.distance_to(events[1].position)
				if abs(drag_distance - last_drag_distance) > zoom_sensitivity:
					var new_zoom = (1 + zoom_speed) if drag_distance < last_drag_distance else (1 - zoom_speed)
					if rootScreen == "worldMap":
						new_zoom = clamp(zoom.x * new_zoom, worldMapMinZoom, worldMapMaxZoom)
					else:
						new_zoom = clamp(zoom.x * new_zoom, villageMinZoom, villageMaxZoom)
					zoom = Vector2.ONE * new_zoom
					last_drag_distance = drag_distance
				current_zoom = get_zoom() # Updating zoom: needed for transition between villages - worldMap
	get_tree().set_input_as_handled()

func setBakeryState(state):
	isBakeryVisible = state

func setAchievementsState(state):
	isAchievementsVisible = state

func setStoreState(state):
	isStoreVisible = state
	
func setUpgradesBakeryState(state):
	isUpgradesBakeryVisible = state
	
func setUpgradesStoreState(state):
	isUpgradesStoreVisible = state

#Set camera limits according to current location
func setCameraLimits(currentLocation):
	if currentLocation == "worldMap": #If rootScreen is worldMap, last location is either one of the villages
		cameraNodePath.limit_left = -4796
		cameraNodePath.limit_top = -5766
		cameraNodePath.limit_right = 3397
		cameraNodePath.limit_bottom = 3435
	elif currentLocation == "avalonia":
		cameraNodePath.limit_left = -1400
		cameraNodePath.limit_top = -1300
		cameraNodePath.limit_right = 2200
		cameraNodePath.limit_bottom = 1900

#Needed for setting camera position on current screen
func getRootScreen(rootSceneString):
	rootScreen = rootSceneString

#Needed for remembering camera location on world map when switchin from village > worldMap
func getLastLocation(setWasLLWorldMap, setWasLLAvalonia):
	wasLLWorldMap = setWasLLWorldMap
	wasLLAvalonia = setWasLLAvalonia

func zoom_in_village(): # I'm on the world map when I press this
	if wasLLWorldMap == true && rootScreen == "avalonia":
		transition_camera(Vector2(villageMinZoom, villageMinZoom), villageMaxZoom, avaloniaCameraPosition)
	elif wasLLAlbion == true:
		transition_camera(Vector2(villageMinZoom, villageMinZoom), villageMaxZoom, albionCameraPosition)		
func zoom_out_worldMap(): # I'm on the village when I press this
	if wasLLAvalonia:
		transition_camera(Vector2(worldMapMinZoom,worldMapMinZoom), worldMapMaxZoom, avaloniaCameraPosition)
	elif wasLLAlbion:
		transition_camera(Vector2(worldMapMinZoom,worldMapMinZoom), worldMapMaxZoom, albionCameraPosition)

func transition_camera(new_zoom, zoomLimit,target_position):
	if new_zoom != current_zoom:
		current_zoom = get_zoom()
		var setZoomLimit = Vector2(zoomLimit,zoomLimit)
		tweenNodePath.interpolate_property(self, "zoom", current_zoom, setZoomLimit, transition_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tweenNodePath.interpolate_property(self, "position", get_position(), target_position, transition_time, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$".".zoom = setZoomLimit
		tweenNodePath.start()

