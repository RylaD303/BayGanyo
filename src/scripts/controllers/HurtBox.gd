extends Area2D

class_name HurtBox

@export var health_controller: HealthController

func _init() -> void:
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null :
		return
	if self.health_controller != null:
		self.health_controller.take_damage(hitbox.get_damage())
