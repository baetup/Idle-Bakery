extends Node

var preConditions = {
	"playedBefore" : false
}

var data = {}

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.save"
var save_path_precond = SAVE_DIR + "save_precond.save"

func _ready():
	loadPreconditions()

func save_resources():
	ResourceSaver.save("res://products/breadAvalonia.tres", globals.breadAvalonia)
	ResourceSaver.save("res://products/cookieAvalonia.tres", globals.cookieAvalonia)
	ResourceSaver.save("res://ingredients/flour.tres", ingredients.flour)
	ResourceSaver.save("res://ingredients/sugar.tres", ingredients.sugar)
	ResourceSaver.save("res://supervisors/breadBakAvaS.tres", globals.breadBakAvaS)
	ResourceSaver.save("res://supervisors/cookieBakAvaS.tres", globals.cookieBakAvaS)
	ResourceSaver.save("res://supervisors/breadStorAvaS.tres", globals.breadStorAvaS)
	ResourceSaver.save("res://supervisors/cookieStorAvaS.tres", globals.cookieStorAvaS)
	ResourceSaver.save("res://misc_objects/mainCastle.tres", globals.mainCastle)


func save_data():
	data = {
		'day' : globals.day,
		'money' : globals.money,
		'username' : globals.username,
		'avatar' : globals.avatar,
		'prestigeLevel' : globals.prestigeLevel,
		'charPoints' : globals.charPoints,
		'neededExp' : globals.neededExp,
		'curExp' : globals.curExp,
		'cunStat' : globals.cunStat,
		'chrStat' : globals.chrStat,
		'intStat' : globals.intStat,
		'invStat' : globals.invStat,
		'avatarPlayerGender' : globals.avatarPlayerGender
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data, true)
		file.close()


func load_data():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			data = file.get_var(true)
			file.close()
			assign_data()




func savePreconditions():
	
		var data = preConditions 
		var dir = Directory.new()
		if !dir.dir_exists(SAVE_DIR):
			dir.make_dir(SAVE_DIR)
		var file = File.new()
		var error = file.open_encrypted_with_pass(save_path_precond, File.WRITE, "idle2020@123")
		if error == OK:
			file.store_var(data)
			file.close()


func loadPreconditions():
	var file = File.new()
	if file.file_exists(save_path_precond):
		var error = file.open_encrypted_with_pass(save_path_precond, File.READ,"idle2020@123")
		if error == OK:
			preConditions = file.get_var()
			file.close()

func assign_data():
	globals.day = data['day']
	globals.money = data['money']
	globals.username = data['username']
	globals.avatar = data['avatar']
	globals.prestigeLevel = data['prestigeLevel']
	globals.charPoints = data['charPoints']	
	globals.neededExp = data['neededExp']
	globals.curExp = data['curExp']
	globals.cunStat = data['cunStat']
	globals.chrStat = data['chrStat']
	globals.intStat = data['intStat']
	globals.invStat = data['invStat']
	globals.avatarPlayerGender = data['avatarPlayerGender']
	
	
	
	
