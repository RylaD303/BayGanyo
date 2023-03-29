extends Node

class_name HealthController

signal health_depleted

@export var max_health: int = 100
var current_health: int = self.max_health

func _init():
	pass

func take_damage(amount: int) -> void:
	if amount<0:
		return
	self.current_health -= amount
	if self.current_health<0:
		self.current_health=0
	if self.is_health_depleted():
		health_depleted.emit()


func heal(amount: int) -> void:
	if amount < 0:
		return
	self.current_health += amount
	if self.current_health > self.max_health:
		self.current_health = self.max_health

func is_health_depleted() -> bool:
	return self.current_health <= 0
