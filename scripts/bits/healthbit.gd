class_name HealthBit extends Bit


signal health_damaged
signal health_zero

@export var max_health: int = 1
@onready var health = max_health


#func _ready() -> void:
	#pass


# Handles damage calculations before applying
func apply_damage(damage_bit: DamageBit):
	var damage_value = damage_bit.damage
	# If sucessful crit
	if damage_bit.crit_chance > randf_range(0.0, 100.0):
		damage_value *= damage_bit.crit_multiplier

	damage(damage_value)


func heal(amount):
	health = min(health + amount, max_health)
	#print(get_parent(), " healed for amount: ", amount)


func damage(amount):
	health = max(health - amount, 0)
	#print(get_parent(), " damaged for amount: ", amount)

	if amount > 0:
		health_damaged.emit()

	if health == 0:
		health_zero.emit()
