extends Panel

export var supervisor = ""
export var productControl = ""
export var targetVillage = ""
var productPath = "/root/GameManager"

# Called when the node enters the scene tree for the first time.
func _ready():
	UpdateUi()

			
func UpdateUi():
	$costLabel.text = str(globals.get(supervisor).supervisorCost)
	if globals.get(supervisor).isSupervisorHired :
		$costLabel.text = "Supervisor Hired !"
		$costLabel/costCoinsLabel.text = ""
		$buyInvisible.disabled = 1
	


func _on_buyInvisible_pressed():
	if globals.money >= globals.get(supervisor).supervisorCost:

		globals.subFromMoney(globals.get(supervisor).supervisorCost)
		globals.get(supervisor).setSupervisorHired(true)
		if globals.get(supervisor).supervisorType == "bakery":
			productPath = "/root/GameManager/" + targetVillage + "/UiCanvas/bakery/productScroll/VBoxContainer/"+productControl+ "/"+str(globals.get(supervisor).supervisorTarget)
			get_node(productPath).onBakeryHiredSupervisor()
		elif globals.get(supervisor).supervisorType == "store":
			productPath	 = "/root/GameManager/" + targetVillage+"/UiCanvas/store/ScrollContainer/VBoxContainer/"+productControl+"/"+str(globals.get(supervisor).supervisorTarget)
			get_node(productPath).onStoreHiredSupervisor()
	UpdateUi()
