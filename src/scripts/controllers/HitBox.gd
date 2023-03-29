extends Area2D

class_name HitBox

var damage: int = 0

func get_damage() -> int:
	return self.damage

func set_damage(amount: int) -> void:
	self.damage = max(0, amount)

func _ready() -> void:
	self.collision_layer = 2 # Bit value of hurtboxes
	self.collision_mask = 4 # Bit value of hitboxes
