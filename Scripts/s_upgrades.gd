extends Node

var resource_path = "res://"

var B_iBS1 = load(resource_path + "upgrades/B_iBS1.tres")
var S_iSP1 = load(resource_path + "upgrades/S_iSP1.tres")

var arrayOfUpgrades = [B_iBS1, S_iSP1]

func loadResource():
	B_iBS1 = load(resource_path + "upgrades/B_iBS1.tres")
	S_iSP1 = load(resource_path + "upgrades/S_iSP1.tres")
	
	arrayOfUpgrades = [B_iBS1, S_iSP1]
	
