extends Node

class_name HealthController

signal health_depleted

@export var max_health: int = 100
var current_health: int = self.max_health

func is_health_depleted() -> bool:
	return self.current_health <= 0

func take_damage(amount: int) -> void:
	if amount < 0:
		return
	self.current_health -= amount
	if self.is_health_depleted():
		self.current_health=0
		health_depleted.emit()

func heal(amount: int) -> void:
	if amount < 0:
		return
	self.current_health += amount
	if self.current_health > self.max_health:
		self.current_health = self.max_health

func set_current_health(amount: int) -> void:
	if amount < 0:
		return
	self.current_health = min(amount, self.max_health)

func set_max_health(amount: int) -> void:
	if amount < 0:
		return
	self.max_health = amount
	self.current_health = min(current_health, max_health)
