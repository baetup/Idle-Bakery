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
const BUILDINGS_DIR = "user://buildings"
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
	
	var dir_buildings = Directory.new()
	if !dir_buildings.dir_exists(BUILDINGS_DIR):
		dir_buildings.make_dir(BUILDINGS_DIR)

	#products
	ResourceSaver.save("user://products/breadAvalonia.tres", globals.breadAvalonia)
	ResourceSaver.save("user://products/cookieAvalonia.tres", globals.cookieAvalonia)
	
	#ingredients - farm
	ResourceSaver.save("user://ingredients/flour.tres", ingredients.flour)
	ResourceSaver.save("user://ingredients/sugar.tres", ingredients.sugar)
	
	#supervisors
	ResourceSaver.save("user://supervisors/breadBakAvaS.tres", globals.breadBakAvaS)
	ResourceSaver.save("user://supervisors/cookieBakAvaS.tres", globals.cookieBakAvaS)
	ResourceSaver.save("user://supervisors/breadStorAvaS.tres", globals.breadStorAvaS)
	ResourceSaver.save("user://supervisors/cookieStorAvaS.tres", globals.cookieStorAvaS)
	
	#castle
	ResourceSaver.save("user://misc_objects/mainCastle.tres", globals.mainCastle)
	
	#upgrades
	ResourceSaver.save("user://upgrades/B_iBS1.tres", s_upgrades.B_iBS1)
	ResourceSaver.save("user://upgrades/S_iSP1.tres", s_upgrades.S_iSP1)
	
	#ingredients - fish
	ResourceSaver.save("user://ingredients/fish_cod.tres", s_fish.codFish)
	ResourceSaver.save("user://ingredients/fish_herring.tres", s_fish.herringFish)
	ResourceSaver.save("user://ingredients/fish_trout.tres", s_fish.troutFish)
	
	#ingredients - hunt
	ResourceSaver.save("user://ingredients/meatBoar.tres", s_hunting.meatBoar)
	ResourceSaver.save("user://ingredients/meatDeer.tres", s_hunting.meatDeer)
	ResourceSaver.save("user://ingredients/meatWildChicken.tres", s_hunting.meatWildChicken)
	
	#buildings
	ResourceSaver.save("user://buildings/building1.tres", s_buildings.building1)
	ResourceSaver.save("user://buildings/building2.tres", s_buildings.building2)
	ResourceSaver.save("user://buildings/building3.tres", s_buildings.building3)
	ResourceSaver.save("user://buildings/building4.tres", s_buildings.building4)
	ResourceSaver.save("user://buildings/building5.tres", s_buildings.building5)
	ResourceSaver.save("user://buildings/building6.tres", s_buildings.building6)
	ResourceSaver.save("user://buildings/building7.tres", s_buildings.building7)
	ResourceSaver.save("user://buildings/building8.tres", s_buildings.building8)
	ResourceSaver.save("user://buildings/building9.tres", s_buildings.building9)
	ResourceSaver.save("user://buildings/building10.tres", s_buildings.building10)
	ResourceSaver.save("user://buildings/building11.tres", s_buildings.building11)
	ResourceSaver.save("user://buildings/building12.tres", s_buildings.building12)
	ResourceSaver.save("user://buildings/building13.tres", s_buildings.building13)
	ResourceSaver.save("user://buildings/building14.tres", s_buildings.building14)
	ResourceSaver.save("user://buildings/building15.tres", s_buildings.building15)
	ResourceSaver.save("user://buildings/building16.tres", s_buildings.building16)
	ResourceSaver.save("user://buildings/building17.tres", s_buildings.building17)
	ResourceSaver.save("user://buildings/building18.tres", s_buildings.building18)
	ResourceSaver.save("user://buildings/building19.tres", s_buildings.building19)
	ResourceSaver.save("user://buildings/building20.tres", s_buildings.building20)
	ResourceSaver.save("user://buildings/building21.tres", s_buildings.building21)
	ResourceSaver.save("user://buildings/building22.tres", s_buildings.building22)
	ResourceSaver.save("user://buildings/building23.tres", s_buildings.building23)
	ResourceSaver.save("user://buildings/building24.tres", s_buildings.building24)
	ResourceSaver.save("user://buildings/building25.tres", s_buildings.building25)
	ResourceSaver.save("user://buildings/building26.tres", s_buildings.building26)
	ResourceSaver.save("user://buildings/building27.tres", s_buildings.building27)
	ResourceSaver.save("user://buildings/building28.tres", s_buildings.building28)

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
		'avatarPlayerGender' : globals.avatarPlayerGender,
		'fishingLevel' : s_fish.fishingLevel,
		'fishingTime' : s_fish.fishingTime,
		'fishingTimeMult' : s_fish.fishingTimeMult,
		'fishingLevelCost' : s_fish.fishingLevelCost,
		'fishingLevelMult' : s_fish.fishingLevelMult,
		'fatherNoble' : globals.fatherNoble,
		'fatherMerchant' : globals.fatherMerchant,
		'fatherHunter' : globals.fatherHunter,
		'fatherThief' : globals.fatherFarmer,
		'fatherAngler': globals.fatherAngler,
		'fatherFarmer' : globals.fatherFarmer,
		'youthApprentice' : globals.youthApprentice,
		'youthServant' : globals.youthServant,
		'youthStreetThief' : globals.youthStreetThief,
		'youthCircusTrainee' : globals.youthCircusTrainee
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
	s_fish.fishingLevel = data['fishingLevel']
	s_fish.fishingTime = data['fishingTime']
	s_fish.fishingTimeMult = data['fishingTimeMult']
	s_fish.fishingLevelCost = data['fishingLevelCost']
	s_fish.fishingLevelMult = data['fishingLevelMult']
	
	globals.fatherNoble = data['fatherNoble']
	globals.fatherMerchant = data['fatherMerchant']
	globals.fatherHunter = data['fatherHunter']
	globals.fatherThief = data['fatherThief']
	globals.fatherAngler = data['fatherAngler']
	globals.fatherFarmer = data['fatherFarmer']
	
	globals.youthApprentice = data['youthApprentice']
	globals.youthServant = data['youthServant']
	globals.youthStreetThief = data['youthStreetThief']
	globals.youthCircusTrainee = data['youthCircusTrainee']
	
	
	
	
	
	
	
	
	
	
