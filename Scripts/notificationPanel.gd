extends Panel

onready var vbox = $bkgr/vbox

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_closeNotifications_pressed():
	visible = 0

func addNotifications():
	for child in vbox.get_children():
		vbox.remove_child(child)
		child.queue_free()
	
	for notification in globals.notificationArray:
		vbox.add_child(TextureRect.new())
	
	for child in vbox.get_children():
		child.add_child(Label.new())
		
func setNotifications(product):
	for child in vbox.get_children():
		child.set_texture(load("res://Image-assets/notificationAlert.png"))
	
		var childrenOfChildrens = child.get_children()
		var count = 0
		for x in childrenOfChildrens:
			if globals.notificationArray[count].type == "bakery":
				childrenOfChildrens[count].set_text("The production of " + product + " halted due to lack of some ingredients")
			elif globals.notificationArray[count].type == "store":
				childrenOfChildrens[count].set_text("The selling in store halted due to lack of some products")
			count += 1
