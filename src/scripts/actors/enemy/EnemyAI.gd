extends CharacterBody2D

class_name EnemyAI

enum State{
	IDLE,
	WANDERING,
	ATTACKING
}

@export var health_controller: HealthController
@export var hurtbox: Hurtbox

@export var speed: float = 20
@export var lower_bound_for_idle_time: float = 2
@export var upper_bound_for_idle_time: float = 4
@export var lower_bound_for_wandering_time: float = 2
@export var upper_bound_for_wandering_time: float = 4
@export var time_in_attack_state: float = 1

var random_number_generator: RandomNumberGenerator
var state: State
var time_in_idle_state: float 
var time_in_wandering_state: float
var state_timer: Timer

func get_player_position() -> Vector2:
	var player = self.get_tree().get_root().get_node("res://src/scripts/actors/player/Player.gd")
	if player:
		return player.position
	return Vector2.ZERO

func _set_state_attacking() -> void:
	self.state = State.ATTACKING
	self.velocity = Vector2.ZERO

func _set_state_idle() -> void:
	self.state = State.IDLE
	self.velocity = Vector2.ZERO

func _set_state_wandering() -> void:
	self.state = State.WANDERING
	
	var random_x: float = random_number_generator.randf_range(0,1)
	var random_y: float = random_number_generator.randf_range(0,1)
	var random_velocity: Vector2 = Vector2(random_x, random_y).normalized()
	self.velocity = random_velocity*self.speed

func _init() -> void:
	self.random_number_generator = RandomNumberGenerator.new()
	self.state = State.IDLE
	self.time_in_idle_state = random_number_generator.randf_range(lower_bound_for_idle_time, upper_bound_for_idle_time)
	self.time_in_wandering_state = random_number_generator.randf_range(lower_bound_for_wandering_time, upper_bound_for_wandering_time)

func _ready() -> void:
	self._create_timer()

func connect_hurtbox() -> void:
	self.hurtbox.hitbox_entered.connect(_on_hitbox_entered)

func _on_hitbox_entered(hitbox: Hitbox) -> void:
	if hitbox == null:
		return
	health_controller.take_damage(hitbox.get_damage())
	hitbox.entered_hurtbox.emit()

func _create_timer() -> void:
	self.state_timer = Timer.new()
	self.add_child(self.state_timer)
	self.state_timer.start(1)
	self.state_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if self.state == State.ATTACKING:
		self._set_state_idle()
		self.state_timer.start(self.time_in_idle_state)
	elif self.state == State.IDLE:
		self._set_state_wandering()
		self.state_timer.start(self.time_in_wandering_state)
	else:
		self._set_state_attacking()
		self.state_timer.start(self.time_in_attack_state)

func _physics_process(_delta) -> void:
	self.move_and_slide()


