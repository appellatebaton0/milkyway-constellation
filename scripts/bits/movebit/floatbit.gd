class_name FloatBit extends MoveBit
## Allows a bot to move as though floating / top down.

func _physics_active(_delta:float) -> void:
	
	print("applied to ", mover)
	mover.velocity += Vector2(1, 0)
