extends Node

var preConditions = {
	"playedBefore" : false
}

var data = {}

const INGREDIENT_DIR = "user://ingredients/"
const MISC_OBJ_DIR = "user://misc_objects/"
const PRODUCTS_DIR = "user://products/"
const SUPERVISOR_DIR = "user://supervisors/"
const UPGRADES_DIR = "user://upgrades/"
const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.save"
var save_path_precond = SAVE_DIR + "save_precond.save"

func _ready():
	loadPreconditions()

func save_resources():
	var dir_ingredient = Directory.new()
	if !dir_ingredient.dir_exists(INGREDIENT_DIR):
		dir_ingredient.make_dir(INGREDIENT_DIR)
	
	var dir_misc_obj = Directory.new()
	if !dir_misc_obj.dir_exists(MISC_OBJ_DIR):
		dir_misc_obj.make_dir(MISC_OBJ_DIR)
		
	var dir_products = Directory.new()
	if !dir_products.dir_exists(PRODUCTS_DIR):
		dir_products.make_dir(PRODUCTS_DIR)
	
	var dir_supervisors = Directory.new()
	if !dir_supervisors.dir_exists(SUPERVISOR_DIR):
		dir_supervisors.make_dir(SUPERVISOR_DIR)
		
	var dir_upgrades = Directory.new()
	if !dir_upgrades.dir_exists(UPGRADES_DIR):
		dir_upgrades.make_dir(UPGRADES_DIR)
	
	ResourceSaver.save("user://products/breadAvalonia.tres", globals.breadAvalonia)
	ResourceSaver.save("user://products/cookieAvalonia.tres", globals.cookieAvalonia)
	ResourceSaver.save("user://ingredients/flour.tres", ingredients.flour)
	ResourceSaver.save("user://ingredients/sugar.tres", ingredients.sugar)
	ResourceSaver.save("user://supervisors/breadBakAvaS.tres", globals.breadBakAvaS)
	ResourceSaver.save("user://supervisors/cookieBakAvaS.tres", globals.cookieBakAvaS)
	ResourceSaver.save("user://supervisors/breadStorAvaS.tres", globals.breadStorAvaS)
	ResourceSaver.save("user://supervisors/cookieStorAvaS.tres", globals.cookieStorAvaS)
	ResourceSaver.save("user://misc_objects/mainCastle.tres", globals.mainCastle)
	ResourceSaver.save("user://upgrades/B_iBS1.tres", s_upgrades.B_iBS1)
	ResourceSaver.save("user://upgrades/S_iSP1.tres", s_upgrades.S_iSP1)

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
	
		data = preConditions 
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
	
	
	
	
