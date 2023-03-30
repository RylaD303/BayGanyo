extends CharacterBody2D

class_name Player

@export var speed: float = 100
var movement: Vector2 = Vector2(0,0)

func _evaluate_keys_pressed() -> void:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	self.movement = Vector2(x_axis, y_axis)

func _physics_process(delta: float) -> void:
	_evaluate_keys_pressed()
	velocity = self.movement.normalized()* self.speed
	move_and_slide()
