extends CharacterBody2D

signal bullet_shot(bullet)

var bullet_scene = preload("res://src/scenes/bullet_scene.tscn").instantiate()


func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot_bullet()


func shoot_bullet():
	var bullet = bullet_scene.duplicate()
	bullet.setup(global_position, get_global_mouse_position())
	emit_signal("bullet_shot", bullet)
