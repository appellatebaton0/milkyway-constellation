class_name DeleteBit extends Bit

@export var ToDeleteBit: NodeValue

func DeleteBit(): 
	var RemoveBit: Node = ToDeleteBit.value()
	
	if not is_instance_valid(RemoveBit):
		return
	
	RemoveBit.queue_free()
	print("DeleteBit Working!")
	
