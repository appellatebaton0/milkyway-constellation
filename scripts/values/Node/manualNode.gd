#Always returns a given Node
class_name ManualNode extends NodeValue

@export var input: Node

func value() -> Node:
	return input
