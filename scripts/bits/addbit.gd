class_name AddBit extends Bit

@export var parent: NodeValue
@export var child: PackedSceneValue

func AddBitToParent():
	
	var big_node: Node = parent.value()
	
	if not is_instance_valid(big_node):
		print("Parent Node Incorrect")
		return 
	
	var small_scene: PackedScene = child.value()
	
	if not is_instance_valid(small_scene):
		print("Packed Scene Incorrect")
		return
	
	var add_child_scene: Node = small_scene.instantiate()
	
	if not is_instance_valid(add_child_scene): 
		print("Packed Scene Instantiate is not working properly")
		return
	
	big_node.add_child(add_child_scene)
	print("AddBit Working!")
