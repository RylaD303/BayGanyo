class_name Player extends Actor
var speed: = 1000
func _physics_process(delta: float) -> void:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	velocity = Vector2(x_axis, y_axis).normalized()
	velocity *= speed*delta
	print(velocity)
	move_and_slide()
