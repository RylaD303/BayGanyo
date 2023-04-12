extends Area2D

class_name Hitbox

var damage: int = 0

signal hit_hurtbox

func get_damage() -> int:
	return self.damage

func set_damage(amount: int) -> void:
	self.damage = max(0, amount)
