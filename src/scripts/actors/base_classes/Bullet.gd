extends Node2D

class_name Bullet

var movement_vector := Vector2(1, 0)
@export var speed := 300.0
@export var delete_bullet_on_exit : bool = true


func _physics_process(delta):
	global_position += movement_vector.rotated(rotation) * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	if delete_bullet_on_exit:
		queue_free()
	
	
func setup(global_position, transform_rotation):
	self.global_position = global_position
	self.look_at(transform_rotation)
