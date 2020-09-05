extends Node

var resource_path = "res://"

var flour = load(resource_path + "ingredients/flour.tres")
var sugar = load(resource_path + "ingredients/sugar.tres")

func loadResource():
	flour = load(resource_path + "ingredients/flour.tres")
	sugar = load(resource_path + "ingredients/sugar.tres")

