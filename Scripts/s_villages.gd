extends Node
var resource_path = "res://"

#avalonia
var avaloniaVillage = load(resource_path + "villages/avalonia.tres")
var village1 = load(resource_path + "villages/village1.tres")

func load_resource():
	#avalonia army village
	avaloniaVillage = load(resource_path + "villages/avalonia.tres")
	avaloniaVillage.army[0] = s_army.avaloniaBowman
	avaloniaVillage.army[1] = s_army.avaloniaHC
	avaloniaVillage.army[2] = s_army.avaloniaKnight
	avaloniaVillage.army[3] = s_army.avaloniaLC
	avaloniaVillage.army[4] = s_army.avaloniaLB
	avaloniaVillage.army[5] = s_army.avaloniaSpMan
	avaloniaVillage.army[6] = s_army.avaloniaSwMan

	#village1
	village1 = load(resource_path + "villages/village1.tres")
	village1.army[0] = s_army.v1_bowman
