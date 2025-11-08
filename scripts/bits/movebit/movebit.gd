@abstract class_name MoveBit extends Bit

var master:MoveMasterBit
var mover:CharacterBody2D

@onready var next:Array[MoveBit] = get_sub_move_bit()
func get_sub_move_bit():
	var response:Array[MoveBit]
	
	for child in get_children():
		if child is MoveBit:
			response.append(child)
	
	return response

## Allows for calling a function down a chain of childed MoveBit
func recursive_call(function:String):
	for bit in next:
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
