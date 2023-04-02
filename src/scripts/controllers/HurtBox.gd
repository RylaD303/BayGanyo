extends Area2D

class_name HurtBox

signal hitbox_entered

func _init() -> void:
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox == null :
		return
	self.hitbox_entered.emit()
