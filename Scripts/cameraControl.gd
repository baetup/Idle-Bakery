extends Camera2D

var touch_vector = Vector2()
var primary_touch = false
onready var isBakeryVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/bakery").visible
onready var isAchievementsVisible = get_node("/root/GameManager/UiCanvas/achivements").visible
onready var isStoreVisible = get_node("/root/GameManager/villageAvalonia/UiCanvas/store").visible
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var tweenNodePath = get_node("/root/GameManager/Tween")
onready var villageNode = get_node("/root/GameManager/villageAvalonia/")

var isDrag = true

var rootScreen = "village"
var villageMinZoom = 1.0
var villageMaxZoom = 2.3
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


export(float) var pan_smooth := -5
export(float) var follow_smooth : float
var _cur_vel := Vector2(0,0)
var _last_cam_pos := Vector2(0,0)

export(float) var max_zoom = 2.5
export(float) var min_zoom = 1
#export(NodePath) var levelLoaderNode

#var levelLoaderRef

var _touches = {} # for pinch zoom and drag with multiple fingers
var _touches_info = {"num_touch_last_frame":0, "radius":0, "total_pan":0}
var _debug_cur_touch = 0

var _zoomin : bool = false
var _zoomout : bool = false
var _enable_input : bool = false
var _keep_centered : bool = true

var _wait_for_anim = false

func _ready():
	setCameraLimits("avalonia")
	$".". zoom = Vector2(1.5,1.5)

func _input(event):
	if _enable_input == false:
		return
	
	_unhandled_input(event)

func _unhandled_input(event):
		
	# Handle actual Multi-touch from capable devices
	if event is InputEventScreenTouch and event.pressed == true:
		_touches[event.index] = {"start":event, "current":event}
	if event is InputEventScreenTouch and event.pressed == false:
		_touches.erase(event.index)
	if event is InputEventScreenDrag:
		if not event.index in _touches:
			_touches[event.index] = {"start":event, "current":event}
		_touches[event.index]["current"] = event
		update_pinch_gesture()

	pretend_multi_touch(event)
	
	var key_str = ""
	if event is InputEventKey and event.unicode != 0:
		key_str = PoolByteArray([event.unicode]).get_string_from_utf8()
	
	# Wheel Up Event
	var zoom_factor :float = 0.0
		
	if zoom_factor != 0.0:
		_keep_centered = false
		var prev_zoom : Vector2 = zoom
		_zoom_camera(zoom_factor)
		var new_zoom : Vector2 = zoom
		if event is InputEventMouse and abs((prev_zoom - new_zoom).length_squared()) > 0.00001:
			var pos = event.position
			var vp_size = self.get_viewport().size
			if get_viewport().is_size_override_enabled():
				vp_size = get_viewport().get_size_override()
			var old_dist = ((event.position - (vp_size / 2.0))*prev_zoom)
			var new_dist = ((event.position - (vp_size / 2.0))*new_zoom)
			var cam_need_move = old_dist - new_dist
			self.position += cam_need_move
	get_tree().set_input_as_handled()
# Zoom Camera
func _zoom_camera(dir):
	zoom += Vector2(0.1, 0.1) * dir
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)
	
func CenterCam(obj):
	var pos
	if obj is Node2D:
		pos = obj.position
	elif obj is Vector2:
		pos = obj
	self.position = pos
	_last_cam_pos = self.position
	reset_smooth()
	
func update_touch_info():
	if _touches.size() <= 0:
		_touches_info.num_touch_last_frame = _touches.size()
		_touches_info["total_pan"] = 0
		return
		
	if _touches_info["num_touch_last_frame"] == 0:
		reset_smooth()
		
	var avg_touch = Vector2(0,0)
	for key in _touches:
		avg_touch += _touches[key].current.position
	_touches_info["cur_pos"] = avg_touch / _touches.size()
	if _touches_info.num_touch_last_frame != _touches.size():
		_touches_info["target"] = _touches_info["cur_pos"]
			
	_touches_info.num_touch_last_frame = _touches.size()
	
	do_multitouch_pan()
		
func do_multitouch_pan():
	var diff = _touches_info.target - _touches_info.cur_pos
	
	var new_pos = self.position + (diff * zoom.x)
	
	# hackish way to trigger OnCameraDragged only once per continuous touch
	if _touches_info["total_pan"] >= 0:
		var move : Vector2 = self.position - new_pos
		var vp_size = get_viewport().size
		move = move / vp_size
		_touches_info["total_pan"] += move.length()
		if _touches_info["total_pan"] > 0.1:
			#BehaviorEvents.emit_signal("OnCameraDragged")
			_touches_info["total_pan"] = -1.0
		
	self.position = new_pos
	
	_touches_info.target = _touches_info.cur_pos

func pretend_multi_touch(event):
	if event is InputEventKey and event.scancode == KEY_A:
		if event.pressed:
			if _debug_cur_touch == 0:
				_debug_cur_touch = 1
		else:
			if _debug_cur_touch == 1:
				_debug_cur_touch = 0
	if event is InputEventMouseButton:
		if event.pressed:
			_touches[_debug_cur_touch] = {"start":event, "current":event}
		else:
			_touches.erase(_debug_cur_touch)
	if event is InputEventMouseMotion:
		if _debug_cur_touch in _touches:
			_touches[_debug_cur_touch]["current"] = event
			
	update_touch_info()
	update_pinch_gesture()
			

func update_pinch_gesture():
	if _touches.size() < 2:
		_touches_info["radius"] = 0
		_touches_info["previous_radius"] = 0
		return

	_touches_info["previous_radius"] = _touches_info["radius"]
	_touches_info["radius"] = (_touches.values()[0].current.position - _touches_info["target"]).length()

	if _touches_info["previous_radius"] == 0:
		return
	
	var zoom_factor = (_touches_info["previous_radius"] - _touches_info["radius"]) / _touches_info["previous_radius"]
	var final_zoom = zoom.x + zoom_factor

	zoom = Vector2(final_zoom,final_zoom)
	zoom.x = clamp(zoom.x, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y, min_zoom, max_zoom)
	#BehaviorEvents.emit_signal("OnCameraZoomed", zoom)
		
	var vp_size = self.get_viewport().size
	if get_viewport().is_size_override_enabled():
		vp_size = get_viewport().get_size_override()
	var old_dist = ((_touches_info["target"] - (vp_size / 2.0))*(zoom-Vector2(zoom_factor, zoom_factor)))
	var new_dist = ((_touches_info["target"] - (vp_size / 2.0))*zoom)
	var cam_need_move = old_dist - new_dist
	self.position += cam_need_move
	
func reset_smooth():
	_last_cam_pos = self.position
	_cur_vel = Vector2(0,0)
	
func _process(delta):
	if delta <= 0:
		return
		
	if _zoomin == true:
		_zoom_camera(-20.0 * delta * zoom.x)
	if _zoomout == true:
		_zoom_camera(20.0 * delta * zoom.x)
		
	if _touches.size() > 0:
		_keep_centered = false
		update_vel(delta)
	if _touches.size() == 0:
		do_real_smoothing(delta)
	
func update_vel(delta : float):		
	var cur_cam_pos := self.position
	var move := _last_cam_pos - cur_cam_pos
	var move_speed : Vector2 = move / delta
	_cur_vel = (_cur_vel + move_speed) / 2.0
	_cur_vel.x = clamp(_cur_vel.x, -10000, 10000)
	_cur_vel.y = clamp(_cur_vel.y, -10000, 10000)
	_last_cam_pos = self.position
	
	
func do_real_smoothing(delta : float):
	var l = _cur_vel.length()
	var move_frame = 10 * exp(pan_smooth * ((log(l/10) / pan_smooth)+delta))
	_cur_vel = _cur_vel.normalized() * move_frame
	self.position -= _cur_vel * delta
	
func smooth_goto(target : Vector2, delta : float):
	var vec : Vector2 = target - self.position
	var l = vec.length()
	var move_frame = 10 * exp(follow_smooth * ((log(l/10) / follow_smooth)+delta))
	var total_move = vec.normalized() * move_frame * delta
	if total_move.length() > l:
		total_move = vec
	self.position += total_move
	
func _on_ZoomIn_down():
	_zoomin = true

func _on_ZoomOut_down():
	_zoomout = true

func _on_Zoom_up():
	_zoomin = false
	_zoomout = false

func setBakeryState(state):
	isBakeryVisible = state

func setAchievementsState(state):
	isAchievementsVisible = state

func setStoreState(state):
	isStoreVisible = state

#Set camera limits according to current location
func setCameraLimits(currentLocation : String):
	if currentLocation == "worldMap": #If rootScreen is worldMap, last location is either one of the villages
		cameraNodePath.limit_left = -4796
		cameraNodePath.limit_top = -5766
		cameraNodePath.limit_right = 3397
		cameraNodePath.limit_bottom = 3435
	elif currentLocation == "avalonia":
		cameraNodePath.limit_left = -2368
		cameraNodePath.limit_top = -864
		cameraNodePath.limit_right = 1452
		cameraNodePath.limit_bottom = 1291

#Needed for setting camera position on current screen
func getRootScreen(rootSceneString : String):
	rootScreen = rootSceneString

#Needed for remembering camera location on world map when switchin from village > worldMap
func getLastLocation(setWasLLWorldMap, setWasLLAvalonia):
	wasLLWorldMap = setWasLLWorldMap
	wasLLAvalonia = setWasLLAvalonia
