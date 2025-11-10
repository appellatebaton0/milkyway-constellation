@abstract class_name DeleteBit extends Bit

## IDK but here should be where the bit gets added 
#func delBit(ParentBit, ToDeleteBit: PackedSceneValue): 
	#ParentBit = self
	#ToDeleteBit.queue_free()
	#
