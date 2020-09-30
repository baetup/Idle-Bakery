extends Panel

onready var bowmanCooldown = $bowmanFace/counter/value
onready var archeryRange = get_node("/root/GameManager/villageAvalonia/UiCanvas/archeryRange")

func _ready():
	set_process(false)
	reloadRecruitment()
	$bowmanFace/queueNo/queueSize.text = str(s_army.bowmenQueue)
	$bowmanFace/sweep.texture_progress = $bowmanFace.texture_normal
	if s_army.bowmenQueueInProgress == false:
		ui()

func _process(delta):
	bowmanCooldown.text = str(timeCalculus.calculate($bowmanFace/bowmenRecruit.time_left))
	$bowmanFace/sweep.value = int(($bowmanFace/bowmenRecruit.time_left / s_army.bowmenQueueTime) * 100)
	s_army.bowmenQueueTimeLeft = $bowmanFace/bowmenRecruit.time_left

func ui():
	$bowmanFace/bowmenRecruit.wait_time = s_army.bowmenQueueTime
	$bowmanFace/sweep.value = 0
	bowmanCooldown.hide()
	$bowmanFace/sweep.texture_progress = $bowmanFace.texture_normal
	$bowmanFace/queueNo/queueSize.text = str(s_army.bowmenQueue)
	set_process(false)

func _on_bowmanFace_pressed():
	if globals.money >= s_army.avaloniaBowman.cost && s_army.bowmenQueue < s_army.bowmenQueueLimit:
		s_army.bowmenQueueInProgress = true
		bowmanCooldown.show()
		s_army.bowmenQueue += 1
		s_army.bowmenQueueTime += s_army.avaloniaBowman.trainingTime
		$bowmanFace/bowmenRecruit.wait_time = s_army.bowmenQueueTime
		set_process(true)
		$bowmanFace/bowmenRecruit.start()
		$bowmanFace/queueNo/queueSize.text = str(s_army.bowmenQueue)

func _on_bowmenRecruit_timeout():
	s_army.bowmenQueueInProgress = false
	$bowmanFace/sweep.value = 0
	s_army.bowmenQueueTime = 0
	s_army.avaloniaBowman.count += s_army.bowmenQueue
	s_army.bowmenQueue = 0
	$bowmanFace/queueNo/queueSize.text = str(s_army.bowmenQueue)
	bowmanCooldown.hide()
	set_process(false)
	archeryRange.ui()

func reloadRecruitment():
	if s_army.bowmenQueueInProgress == true:
		bowmanCooldown.show()
		$bowmanFace/bowmenRecruit.wait_time = s_army.bowmenQueueTimeLeft
		set_process(true)
		$bowmanFace/bowmenRecruit.start()
		$bowmanFace/queueNo/queueSize.text = str(s_army.bowmenQueue)
