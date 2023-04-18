extends CharacterBody2D

class_name Player

@export var health_controller : HealthController
@export var hurtbox : Hurtbox

@export var speed: int = 100
@export var acceleration: int = 10
@export var friction: int = 15
@export var dash_speed: int = 200
@export var dash_duration: float = 1
@export var dash_length_time: float = 0.5

var can_dash = true
var is_dashing = false
var dash_length_timer: Timer
var dash_duration_timer: Timer

func _init():
	pass


func _ready():
	self._setup_timers()

func _setup_timers() -> void:
	self.dash_length_timer = Timer.new()
	self.add_child(self.dash_length_timer)
	self.dash_duration_timer = Timer.new()
	self.add_child(self.dash_duration_timer)
	self.dash_length_timer.timeout.connect(stop_dash)
	self.dash_duration_timer.timeout.connect(refresh_ability_to_dash)

func setup_hurtbox_connections() -> void:
	self.hurtbox.hitbox_entered.connect(_on_hitbox_entered)

func get_input_direction() -> Vector2:
	var x_axis: = Input.get_action_strength("UI_right") - Input.get_action_strength("UI_left")
	var y_axis: = Input.get_action_strength("UI_down") - Input.get_action_strength("UI_up")
	return Vector2(x_axis, y_axis).normalized()

func _start_dash_timers() -> void:
	#checks if the timers were setup already
	if self.dash_duration_timer && self.dash_length_timer:
		self.dash_length_timer.start(dash_length_time)
		self.dash_duration_timer.start(dash_duration)

func dash() -> void:
	if can_dash and get_input_direction() != Vector2.ZERO:
		can_dash = false
		is_dashing = true
		velocity = get_input_direction().normalized()*dash_speed
		self._start_dash_timers()

func check_input_dash() -> void:
	if Input.is_action_pressed("UI_dash"):
		self.dash()

func calculate_velocity() -> void:
	var direction = self.get_input_direction()
	if direction == Vector2.ZERO:
		self.apply_friction()
	else:
		self.accelerate(direction)

func change_velocity() -> void:
	if !self.is_dashing:
		self.calculate_velocity()

func accelerate(direction: Vector2) -> void:
	self.velocity = self.velocity.move_toward(self.speed*direction, self.acceleration)

func apply_friction() -> void:
	self.velocity = self.velocity.move_toward(Vector2.ZERO, self.friction)

func move() -> void:
	self.move_and_slide()

func _physics_process(_delta: float) -> void:
	self.change_velocity()
	self.check_input_dash()
	self.move()

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if self.is_dashing:
		return
	self.health_controller.apply_damage(hitbox.get_damage())

func stop_dash() -> void:
	self.is_dashing = false
	self.change_velocity()

func refresh_ability_to_dash() -> void:
	self.can_dash = true
