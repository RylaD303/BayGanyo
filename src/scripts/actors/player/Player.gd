extends CharacterBody2D

class_name Player

@export var speed: float = 100
var movement: Vector2 = Vector2(0,0)

func get_input_direction() -> Vector2:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	return Vector2(x_axis, y_axis).normalized()

func calculate_velocity():
	self.velocity *= self.speed

func move():
	move_and_slide()

func _physics_process(delta: float) -> void:
	self.velocity = get_input_direction()
	self.calculate_velocity()
	self.move()
