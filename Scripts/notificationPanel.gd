extends Panel

onready var vbox = $bkgr/vbox
var villagesDict = {"villageAvalonia" : "villageAvalonia", "villageAlbion" : "villageAlbion"} # I need a dict so I know where to redirect the notification click


func _on_closeNotifications_pressed():
	visible = 0

#add the children and children of children to the scene
func addNotifications():
	var temp = 0
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()
	
	for notification in globals.notificationArray:
		vbox.add_child(TextureButton.new())
	
	for child in vbox.get_children():
		child.set_name("icon" + str(temp))
		child.add_child(Label.new())
		temp += 1

func setNotifications():
	var temp = 0
	#positioning the label
	for x in vbox.get_children():
		var childrenOfChildren = x.get_children()
		childrenOfChildren[0].set_name("label")
		childrenOfChildren[0].anchor_left = 0
		childrenOfChildren[0].anchor_top = 0
		childrenOfChildren[0].anchor_right = 1
		childrenOfChildren[0].anchor_bottom = 1
		childrenOfChildren[0].margin_left = 80
		childrenOfChildren[0].margin_top = 20
		childrenOfChildren[0].margin_right = 0
		childrenOfChildren[0].margin_bottom = 0
		childrenOfChildren[0].set_autowrap(true)

	#setting the warning icons && giving proper text to the labels
	for child in vbox.get_children():
		child.set_normal_texture(load("res://Image-assets/notificationAlert.png"))
		if globals.notificationArray[temp].type == "bakery":
			get_node("bkgr/vbox/icon" + str(temp) + "/label").set_text("The production of " + globals.notificationArray[temp].target + " halted due to lack of some ingredients")
		elif globals.notificationArray[temp].type == "store":
			get_node("bkgr/vbox/icon" + str(temp) + "/label").set_text("The selling of " + globals.notificationArray[temp].target + " halted due to lack of some products")
		temp += 1
	createLinks()
	
#creating button signals for the notifications
func createLinks():
	var temp = 0
	for x in vbox.get_children():
		x.connect("pressed", self, "interceptLinks", [globals.notificationArray[temp].type, globals.notificationArray[temp].village])
		temp += 1

#redirecting the buttons to their proper location
func interceptLinks(type, village):
	#set current village visible
	get_node("/root/GameManager/" + village).visible = 1
	
	#set all other villages to not visible
	villagesDict.erase("villageAvalonia")
	for x in villagesDict :
		get_node("/root/GameManager" + x).visible = 0
	
	#set the type visible
	get_node("/root/GameManager/" + village +"/UiCanvas/" + type).visible = 1
	$".".visible = 0
	
