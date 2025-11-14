class_name DeleteBit extends Bit

# Takes in a NodeValue
@export var ToDeleteBit: NodeValue

#Function that deletes that node
func DeleteBit(): 
	# Getting the node that needs to be removed 
	var RemoveBit: Node = ToDeleteBit.value()
	# Checks if its valid
	if not is_instance_valid(RemoveBit):
		return
	
	#Removes it from its parent (and deletes it)
	RemoveBit.queue_free()
	#print("DeleteBit Working!")
	
