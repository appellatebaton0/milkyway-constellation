class_name AddBit extends Bit

# Takes in a NodeValue and PackedScene Value
@export var parent: NodeValue
@export var child: PackedSceneValue

#Function that makes an instance of the PackedScene and adds it as a child to the NodeValue
func AddBitToParent():
	
	# Getting the Parent Node
	var big_node: Node = parent.value()
	# Checks if Valid #1
	if not is_instance_valid(big_node):
		print("Parent Node Incorrect")
		return 
	
	# Getting the Child Node
	var small_scene: PackedScene = child.value()
	# Checks if Valid #2
	if not is_instance_valid(small_scene):
		print("Packed Scene Incorrect")
		return
	
	# Makes the Instance
	var add_child_scene: Node = small_scene.instantiate()
	# Checks if Valid #2
	if not is_instance_valid(add_child_scene): 
		print("Packed Scene Instantiate is not working properly")
		return
	
	# Adds the Instance as a child of the Parent Node
	big_node.add_child(add_child_scene)
	#print("AddBit Working!")
