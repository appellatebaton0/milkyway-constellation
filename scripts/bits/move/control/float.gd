class_name FloatBit extends ControlBit
## Allows a bot to move as though floating / top down.

@export var amount:Vector2

func _physics_active(_delta:float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	master.mover.velocity = direction * 100
