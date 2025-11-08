class_name MoveMasterBit extends Bit
## Manages all the movement of a Bot; takes MoveBits as children for functionality.

@export var pa:PackedSceneValue

@export var initial_state:MoveBit
var current_state:MoveBit

## Changes the current state to the one specified.
func change_state(to:MoveBit):
	if current_state != null:
		current_state._on_inactive()
		current_state.recursive_call("_on_inactive")
	
	print("changed current to ", current_state)
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
			child.mover = mover
			child.master = self
			
			response.append(child)
	
	return response

func _ready() -> void:
	print("init: ", initial_state)
	print("bits: ", get_move_bits())
	# If no initial state given, default to the first childed one.
	if initial_state == null and len(movebits) > 0:
		initial_state = movebits[0]
	
	# If there is an initial state, make it the current state.
	print("init: ", initial_state)
	if initial_state != null:
		change_state(initial_state)

func _process(delta: float) -> void:
	for bit in movebits:
		if bit == current_state:
			bit._active(delta)
			bit.recursive_call("_active")
		else:
			bit._inactive(delta)
			bit.recursive_call("_inactive")

func _physics_process(delta: float) -> void:
	for bit in movebits:
		if bit == current_state:
			print("running ", bit)
			bit._physics_active(delta)
			bit.recursive_call("_physics_active")
		else:
			bit._physics_inactive(delta)
			bit.recursive_call("_physics_inactive")
	
	if mover != null:
		mover.move_and_slide()
		
		if bot is Node2D:
			bot.global_position += mover.position
			bot.position = Vector2.ZERO
	
	
