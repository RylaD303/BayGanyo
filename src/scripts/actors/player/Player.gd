extends Actor


class_name Player
var speed: float = 1000
var direction: Vector2 = Vector2(0,0)

func _get_keys_pressed() -> void:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	direction = Vector2(x_axis, y_axis)

func _physics_process(delta: float) -> void:
	_get_keys_pressed()
	velocity = direction.normalized()
	velocity *= speed*delta
	move_and_slide()
