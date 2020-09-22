extends Node

var resource_path = "res://"



var building1 = load(resource_path + "buildings/building1.tres")
var building2 = load(resource_path + "buildings/building2.tres")


func loadResource():
	building1 = load(resource_path + "buildings/building1.tres")
	building2 = load(resource_path + "buildings/building2.tres")
