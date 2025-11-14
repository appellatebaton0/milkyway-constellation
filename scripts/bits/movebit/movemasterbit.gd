class_name MoveMasterBit extends Bit
## Manages all the movement of a Bot; takes MoveBits as children for functionality.

@export var initial_state:MoveBit
var current_state:MoveBit

## Changes the current state to the one specified.
func change_state(to:MoveBit):
	if current_state != null:
		current_state._on_inactive()
		current_state.recursive_call("_on_inactive")
	
	current_state = to
	
	if current_state != null:
		current_state._on_inactive()
		current_state.recursive_call("_on_active")

@onready var mover:CharacterBody2D = get_mover()
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

func _ready() -> void:
	# If no initial state given, default to the first childed one.
	if initial_state == null and len(movebits) > 0:
		initial_state = movebits[0]
	
	# If there is an initial state, make it the current state.
	if initial_state != null:
		change_state(initial_state)

func _process(delta: float) -> void:
	for bit in movebits:
		if bit == current_state:
			bit._active(delta)
			bit.recursive_call("_active", delta)
		else:
			bit._inactive(delta)
			bit.recursive_call("_inactive", delta)

func _physics_process(delta: float) -> void:
	for bit in movebits:
		if bit == current_state:
			bit._physics_active(delta)
			bit.recursive_call("_physics_active",delta)
		else:
			bit._physics_inactive(delta)
			bit.recursive_call("_physics_inactive",delta)
	
	if mover != null:
		#print("sliding with ", mover.velocity)
		mover.move_and_slide()
		
		if bot is Node2D:
			bot.global_position += mover.position
			mover.position = Vector2.ZERO
	
	
