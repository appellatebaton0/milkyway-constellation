@abstract class_name Bit extends Bot
## Provides functionality to its bot.

@export var isolated = false

@onready var bot = get_bot()
func get_bot(with = self, depth:int = 5) -> Bot:
	if isolated:
		return self
	if depth == 0:
		return null
	
	var parent = with.get_parent()
	
	if parent is Bot and parent is not Bit:
		return parent
	
	elif parent is Bit:
		return parent.get_bot(parent, depth - 1)
	
	else:
		return get_bot(parent, depth - 1)
