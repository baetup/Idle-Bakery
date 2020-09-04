extends Resource


class_name supervisor
export var isSupervisorHired : bool
export var supervisorCost : int
export var supervisorType : String #bakery or store for different path nodes
export var supervisorTarget : String


func setSupervisorHired(state:bool):
	isSupervisorHired = state
func addSupervisorCost(amount: int):
	supervisorCost += amount
func setSupervisorTarget(targetProduct:String):
	supervisorTarget = targetProduct
func setSupervisorType(type : String):
	supervisorType = type
