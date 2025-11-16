@abstract class_name MoveBit extends Bit

@onready var master:MoveMasterBit = get_master()

func get_master(with=self, depth := 4) -> MoveMasterBit:
	var parent = with.get_parent()
	
	if parent is MoveMasterBit:
		return parent
	else:
		return get_master(parent, depth -1)

@onready var next:Array[MoveBit] = get_sub_move_bit()
func get_sub_move_bit():
	var response:Array[MoveBit]
	
	for child in get_children():
		if child is MoveBit:
			response.append(child)
	
	return response

## Allows for calling a function down a chain of childed MoveBit
func recursive_call(function:String, arg=null):
	for bit in next:
		if arg != null:
			bit.call(function, arg)
			bit.recursive_call(function, arg)
		else:
			bit.call(function)
			bit.recursive_call(function)

# Ran once when the bit becomes active/inactive.
func _on_active() -> void:
	pass
func _on_inactive() -> void:
	pass

# Processes for when the bit is active/inactive
func _active(_delta:float) -> void:
	pass
func _inactive(_delta:float) -> void:
	pass

# Physics processes for when the bit is active / inactive.
func _physics_active(_delta:float) -> void:
	pass
func _physics_inactive(_delta:float) -> void:
	pass
