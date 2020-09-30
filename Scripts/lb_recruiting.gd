extends Panel

onready var lbCooldown = $lbFace/counter/value
onready var archeryRange = get_node("/root/GameManager/villageAvalonia/UiCanvas/archeryRange")

func _ready():
	set_process(false)
	reloadRecruitment()
	$lbFace/queueNo/queueSize.text = str(s_army.bowmenQueue)
	$lbFace/lbSweep.texture_progress = $lbFace.texture_normal
	if s_army.bowmenQueueInProgress == false:
		ui()

func _process(delta):
	lbCooldown.text = str(timeCalculus.calculate($lbFace/lbRecruit.time_left))
	$lbFace/lbSweep.value = int(($lbFace/lbRecruit.time_left / s_army.lbQueueTime) * 100)
	s_army.lbQueueTimeLeft = $lbFace/lbRecruit.time_left

func ui():
	$lbFace/lbRecruit.wait_time = s_army.lbQueueTime
	$lbFace/lbSweep.value = 0
	lbCooldown.hide()
	$lbFace/lbSweep.texture_progress = $lbFace.texture_normal
	$lbFace/queueNo/queueSize.text = str(s_army.lbQueue)
	set_process(false)

func reloadRecruitment():
	if s_army.lbQueueInProgress == true:
		lbCooldown.show()
		$lbFace/lbRecruit.wait_time = s_army.lbQueueTimeLeft
		set_process(true)
		$lbFace/lbRecruit.start()
		$lbFace/queueNo/queueSize.text = str(s_army.lbQueue)

func _on_lbFace_pressed():
	if globals.money >= s_army.avaloniaLB.cost && s_army.lbQueue < s_army.lbQueueLimit:
		s_army.lbQueueInProgress = true
		lbCooldown.show()
		s_army.lbQueue += 1
		s_army.lbQueueTime += s_army.avaloniaLB.trainingTime
		$lbFace/lbRecruit.wait_time = s_army.lbQueueTime
		set_process(true)
		$lbFace/lbRecruit.start()
		$lbFace/queueNo/queueSize.text = str(s_army.lbQueue)

func _on_lbRecruit_timeout():
	s_army.lbQueueInProgress = false
	$lbFace/lbSweep.value = 0
	s_army.lbQueueTime = 0
	s_army.avaloniaLB.count += s_army.lbQueue
	s_army.lbQueue = 0
	$lbFace/queueNo/queueSize.text = str(s_army.lbQueue)
	lbCooldown.hide()
	set_process(false)
	archeryRange.ui()
