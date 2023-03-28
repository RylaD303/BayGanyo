extends Object

class_name HealthController

@export var max_health: int = 100
var current_health: int = self.max_health

func _init():
	pass

func take_damage(amount: int) -> void:
	if amount<0:
		pass
	self.current_health -= amount
	if self.current_health<0:
		self.current_health=0


func heal(amount: int) -> void:
	if amount<0:
		pass
	self.current_health += amount
	if self.current_health>self.max_health:
		self.current_health = self.max_health

func is_dead() -> bool:
	return self.current_health <= 0
