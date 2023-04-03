extends CharacterBody2D

class_name EnemyAI

enum State{
	IDLE,
	WANDERING,
	ATTACKING
}

@export var lower_bound_for_idle: int = 2
@export var higher_bound_for_idle: int = 4
@export var lower_bound_for_wandering: int = 2
@export var higher_bound_for_wandering: int = 4
@export var attack_time: int = 1

var gen: RandomNumberGenerator
var state: State
var time_in_idle_state: float 
var time_in_wandering_state: float

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
	self.velocity = random_velocity

func _init():
	self.gen = RandomNumberGenerator.new()
	self.state = State.IDLE
	self.time_in_idle_state = gen.randf_range(lower_bound_for_idle, higher_bound_for_idle)
	self.time_in_wandering_state = gen.randf_range(lower_bound_for_wandering, higher_bound_for_wandering)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	self.move_and_slide()
