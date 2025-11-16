class_name AreaMasterBit extends Bit
## Provides a master for doing any Area2D-related activities. Functionalities provided by AreaBits.

@onready var area:Area2D = get_area()
func get_area() -> Area2D:
	var me = self
	if me is Area2D: return me
	
	var parent = get_parent()
	if parent is Area2D: return parent
	
	return null

## Allows for comparing a collision_layer to a collision_mask.
func layer_match(layer:int, mask:int) -> bool:
	
	for i in range(32): # For all 32 layers...
		
		# Perform bitwise functions to see if they match.
		# NOTE: this is how get_collision_layer() works!
		var matches_layer = bool(layer & (1 << i))
		var matches_mask = bool(mask & (1 << i))
		
		# If both are true on this bit, there's some overlap.
		if matches_layer and matches_mask:
			return true
	
	return false # No matches found on any layer.

@onready var area_bits:Array[AreaBit] = get_area_bits()
func get_area_bits() -> Array[AreaBit]:
	var response:Array[AreaBit]
	
	# Append any AreaBit children.
	for child in get_children(): if child is AreaBit: response.append(child)
	# Append any AreaBit siblings.
	for sibling in get_parent().get_children(): if sibling is AreaBit: response.append(sibling)
	
	return response

## Returns the array given with any non-matching Nodes removed.
func mask_objects(array:Array, mask:int):
	var response:Array[CollisionObject2D]
	
	for object in array: if object is CollisionObject2D: # Straight-up ignores non-collisionobjects.
		if layer_match(object.collision_layer, mask):
			response.append(object)
	
	return response

func _ready() -> void: # Connect all the signals...
	if area != null:
		area.area_entered.connect(_on_area_entered)
		area.area_exited.connect(_on_area_exited)
		
		area.body_entered.connect(_on_body_entered)
		area.body_exited.connect(_on_body_exited)

## Single-Collision Functions

func _on_area_entered(area_in:Area2D):
	# For every bit with a matching layer...
	for bit in area_bits: if layer_match(area_in.collision_layer, bit.collision_mask):
		bit._on_area_entered(area_in) # Call the corresponding function.
		bit._on_object_entered(area_in)
func _on_area_exited(area_in:Area2D):
	# For every bit with a matching layer...
	for bit in area_bits: if layer_match(area_in.collision_layer, bit.collision_mask):
		bit._on_area_exited(area_in) # Call the corresponding function.
		bit._on_object_exited(area_in)

func _on_body_entered(body:Node2D):
	# For every bit with a matching layer...
	for bit in area_bits: if layer_match(body.collision_layer, bit.collision_mask):
		bit._on_body_entered(body) # Call the corresponding function.
		bit._on_object_entered(body)
func _on_body_exited(body:Node2D):
	# For every bit with a matching layer...
	for bit in area_bits: if layer_match(body.collision_layer, bit.collision_mask):
		bit._on_body_exited(body) # Call the corresponding function.
		bit._on_object_exited(body)

## Constant Functions

func _process(_delta: float) -> void: if area != null:
	
	# Get the overlapping areas / bodies
	var areas = area.get_overlapping_areas()
	var bodies = area.get_overlapping_bodies()
	
	for bit in area_bits:
		
		# Get the overlapping areas, bodies, and object.
		var overlapping_areas = mask_objects(areas, bit.collision_mask)
		var overlapping_bodies = mask_objects(bodies, bit.collision_mask)
		var overlapping_objects = overlapping_areas.duplicate() 
		overlapping_objects.append_array(overlapping_bodies)
		
		# Call the relative functions for each.
		if len(overlapping_areas) > 0: bit._while_overlapping_areas(overlapping_areas)
		if len(overlapping_bodies) > 0: bit._while_overlapping_bodies(overlapping_bodies)
		if len(overlapping_objects) > 0: bit._while_overlapping_objects(overlapping_objects)
		
	
