extends CharacterBody2D

class_name Player

@export var speed: int = 100
@export var acceleration: int = 10
@export var friction: int = 15 # how fast the player stops moving

var movement: Vector2 = Vector2(0,0)

func get_input_direction() -> Vector2:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	return Vector2(x_axis, y_axis).normalized()

func calculate_velocity() -> void:
	var direction = self.get_input_direction()
	if direction == Vector2.ZERO:
		self.apply_friction()
	else:
		self.accelerate(direction)

func accelerate(direction: Vector2) -> void:
	self.velocity = self.velocity.move_toward(self.speed*direction, self.acceleration)

func apply_friction() -> void:
	self.velocity = self.velocity.move_toward(Vector2.ZERO, self.friction)

func move() -> void:
	self.move_and_slide()

func _physics_process(_delta: float) -> void:
	self.calculate_velocity()
	self.move()
