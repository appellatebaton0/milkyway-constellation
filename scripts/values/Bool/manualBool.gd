#Always returns a given Bool, Extends BoolValue
class_name ManualBool extends BoolValue

@export var input: bool

func value() -> bool:
	return input
