class_name MoveMasterBit extends Bit
## Manages all the movement of a Bot; takes MoveBits as children for functionality.

@export var initial_state:MoveBit
var current_state:MoveBit

## Changes the current state to the one specified.
func change_state(to:MoveBit):
	current_state._on_inactive()
	current_state.recursive_call("_on_inactive")
	
	current_state = to
	
	current_state._on_ictive()
	current_state.recursive_call("_on_active")

@onready var mover = get_mover()
func get_mover() -> CharacterBody2D:
	
	var me = self
	if me is CharacterBody2D:
		return me
	
	var parent = get_parent()
	if parent is CharacterBody2D:
		return parent
	
	return null

@onready var movebits:Array[MoveBit] = get_move_bits()
func get_move_bits() -> Array[MoveBit]:
	var response:Array[MoveBit]
	
	for child in get_children():
		if child is MoveBit:
			response.append(child)
	
	return response

func _process(delta: float) -> void:
	for bit in movebits:
		if bit == current_state:
			bit._active(delta)
			bit.recursive_call("_active")
		else:
			bit._inactive(delta)
			bit.recursive_call("_inactive")
