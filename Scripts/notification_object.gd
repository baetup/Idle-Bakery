extends Resource


class_name notification
	
export var type : String # bakery or store ex.
export var village: String
export var target : String
export var isActive : bool
	
func _init(setType='', setVillage='', setTarget='',setActive=''):
	type = setType
	village = setVillage
	target = setTarget
	isActive = setActive
