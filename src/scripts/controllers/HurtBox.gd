extends Area2D


class_name HurtBox

@export var health_controller: HealthController

func _init():
	self.collision_layer = 4 # Bit value of hurtboxes
	self.collision_mask = 2 # Bit value of hitboxes
