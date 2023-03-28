extends Actor

class_name Player

@export var max_health: int = 100
var current_health: int = self.max_health

func take_damage(amount: int) -> void:
	if amount<0:
		pass
	self.current_health -= amount
	if self.current_health<0:
		self.current_health=0
