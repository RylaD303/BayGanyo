extends CharacterBody2D

class_name EnemyAI

enum State{
	IDLE,
	WANDERING,
	ATTACKING
}

@export var speed: float = 20
@export var lower_bound_for_idle: float = 2
@export var higher_bound_for_idle: float = 4
@export var lower_bound_for_wandering: float = 2
@export var higher_bound_for_wandering: float = 4
@export var time_in_attack_state: float = 1

var gen: RandomNumberGenerator
var state: State
var time_in_idle_state: float 
var time_in_wandering_state: float
var timer: Timer

func _set_state_attacking() -> void:
	self.state = State.ATTACKING
	self.velocity = Vector2(0,0)

func _set_state_idle() -> void:
	self.state = State.IDLE
	self.velocity = Vector2(0,0)

func _set_state_wandering() -> void:
	self.state = State.WANDERING
	
	var random_x: float = gen.randf_range(0,1)
	var random_y: float = gen.randf_range(0,1)
	var random_velocity: Vector2 = Vector2(random_x, random_y).normalized()
	self.velocity = random_velocity*self.speed

func _init():
	self.gen = RandomNumberGenerator.new()
	self.state = State.IDLE
	self.time_in_idle_state = gen.randf_range(lower_bound_for_idle, higher_bound_for_idle)
	self.time_in_wandering_state = gen.randf_range(lower_bound_for_wandering, higher_bound_for_wandering)

func _ready():
	self._create_timer()

func _create_timer() -> void:
	self.timer = Timer.new()
	self.add_child(self.timer)
	self.timer.start(1)
	self.timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if self.state == State.ATTACKING:
		self._set_state_idle()
		self.timer.start(self.time_in_idle_state)
	elif self.state == State.IDLE:
		self._set_state_wandering()
		self.timer.start(self.time_in_wandering_state)
	else:
		self._set_state_attacking()
		self.timer.start(self.time_in_attack_state)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	self.move_and_slide()
