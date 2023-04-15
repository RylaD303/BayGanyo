extends CharacterBody2D

class_name Bullet

@export var hitbox: Hitbox
var speed = 100
func set_damage(amount: int):
	self.hitbox.set_damage(amount)
	self.hitbox.hit_hurtbox.connect(_hit_hurtbox)

func set_starting_position(position: Vector2):
	self.global_position = position
	
func set_direction_to_position(position: Vector2):
	# setting the movement vector to be pointiong to the given position
	self.velocity = position - self.global_position
	self.velocity = self.velocity.normalized()*speed

func _hit_hurtbox():
	self.queue_free()
