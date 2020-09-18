extends Node2D

onready var worldMapNodePath = get_node("/root/GameManager/worldMap")
onready var villageAvaloniaNodePath = get_node("/root/GameManager/villageAvalonia")
onready var cameraNodePath = get_node("/root/GameManager/Camera2D")
onready var anmationPlayer = get_node("/root/GameManager/UiCanvas/ColorRect/AnimationPlayer")
onready var colorRect = get_node("/root/GameManager/UiCanvas/ColorRect")

func _on_avaloniaVillage_pressed():
	colorRect.visible = true
	anmationPlayer.play("fade-in")
	var t = Timer.new()
	t.set_wait_time(0.4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	cameraNodePath.getLastLocation(true, false)
	cameraNodePath.getRootScreen("avalonia")
	cameraNodePath.setCameraLimits("avalonia")
	cameraNodePath.setCameraLimits("avalonia")
	worldMapNodePath.visible = 0
	villageAvaloniaNodePath.visible = 1
	
	anmationPlayer.play("fade-out")
	var t2 = Timer.new()
	t2.set_wait_time(0.5)
	t2.set_one_shot(true)
	self.add_child(t2)
	t2.start()
	yield(t2, "timeout")
	colorRect.visible = false



