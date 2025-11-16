@abstract class_name AreaBit extends Bit
## Provides functionality to a AreaMaster.
## NOTE: The collision mask for this bit has to have some overlap with its master
## since any collisions are checked against the Area2D, THEN the AreaBit.

@export_flags_2d_physics var collision_mask := 0

## Single collision w/ Areas
func _on_area_entered(_area:Area2D) -> void:
	pass
func _on_area_exited(_area:Area2D) -> void:
	pass

## Single collision w/ ANYTHING (Areas or Bodies)
func _on_object_entered(_object:Node2D) -> void:
	pass
func _on_object_exited(_object:Node2D) -> void:
	pass

## Single collision w/ Bodies
func _on_body_entered(_body:Node2D) -> void:
	pass
func _on_body_exited(_body:Node2D) -> void:
	pass

## Constant collision w/ areas
func _while_overlapping_areas(_areas:Array[CollisionObject2D]):
	pass

## Constant collision w/ bodies
func _while_overlapping_bodies(_bodies:Array[CollisionObject2D]):
	pass

## Constant collision w/ ANYTHING (Areas or Bodies)
func _while_overlapping_objects(_objects:Array[CollisionObject2D]):
	pass
