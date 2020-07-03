extends Node2D

onready var worldMapNodePath = get_node("/root/GameManager/worldMap")
onready var villageAvaloniaNodePath = get_node("/root/GameManager/villageAvalonia")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")

var cloudsLeftInPosition = Vector2(3, 286)
var cloudsRightInPosition = Vector2(0,0)
var cloudsLeftOutPosition = Vector2(-725, 286)
var cloudsRightOutPosition = Vector2(632, 0)
var maxSlideAtZoom = Vector2(4.857142, 4.857142)
var minSlideAtZoom = Vector2(3.999998, 3.999998)
var worldMapExitClouds = false
var villageExitClouds = false

func _on_avaloniaVillage_pressed():
	var getLL1 = true
	var getLL2 = false
	cameraNodePath.getLastLocation(getLL1, getLL2)
	var tmp = "avalonia"
	cameraNodePath.getRootScreen(tmp)
	cameraNodePath.setCameraLimits("avalonia")
	cameraNodePath.zoom_in_village()
	worldMapExitClouds = true
	moveClouds()
	var t = Timer.new()
	t.set_wait_time(0.8)
	t.set_one_shot(true)
	call_deferred("add_child", t)
	t.autostart = true
	yield(t, "timeout")
	var temp2 = "avalonia"
	cameraNodePath.setCameraLimits(temp2)
	worldMapNodePath.visible = 0
	villageAvaloniaNodePath.visible = 1
	worldMapExitClouds = false

#Transition of clouds/animation
func slideClouds(leftOut : Vector2, rightOut : Vector2, rightIn : Vector2, leftIn : Vector2, cloudsLeft, cloudsRight):
	$Tween.interpolate_property(cloudsLeft, "position", leftIn, leftOut, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
	$Tween.interpolate_property(cloudsRight, "position", rightIn, rightOut, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT )
	$Tween.start()
	print("andreea2")

#Resetting clouds position after sliding
func resetCloudsPosition(pos : Vector2, pos2 : Vector2, cloudsLeft, cloudsRight):
	cloudsLeft.position = pos
	cloudsRight.position = pos2

#Depending on the zoom level and rootScreen, deciding to either slide clouds in or out
func moveClouds():
	if villageExitClouds == true && cameraNodePath.wasLLAvalonia == true && cameraNodePath.rootScreen == "worldMap": # avalonia click case
		slideClouds(cloudsLeftOutPosition, cloudsRightOutPosition, cloudsRightInPosition, cloudsLeftInPosition, $nodeLeft, $nodeRight)
		print("andreea")
	elif worldMapExitClouds == true && cameraNodePath.wasLLWorldMap == true && cameraNodePath.rootScreen == "avalonia":
		slideClouds(cloudsLeftOutPosition, cloudsRightOutPosition, cloudsLeftInPosition, cloudsRightInPosition,$nodeLeft, $nodeRight)


#when rootscreen is worldMap and zoom is at a certain amount
#only then tween clouds

