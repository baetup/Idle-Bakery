extends Control




func _ready():
	firstOpen()



func firstOpen():
	if globals.castleFirstOpen:
		$kingDialog1.visible = 1
		globals.castleFirstOpen = false
	else:
		$kingDialog1.visible = 0
	
		



func _on_close_pressed():
	visible = 0


func _on_next1_pressed():
	$kingDialog1/text1.visible = 0
	$kingDialog1/text2.visible = 1


func _on_next2_pressed():
	$kingDialog1.visible = 0
