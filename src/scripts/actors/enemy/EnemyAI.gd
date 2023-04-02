extends CharacterBody2D

class_name EnemyAI

enum {
	CALM,
	ATTACKING
}

enum {
	IDLE,
	WANDERING
}

@export var lower_bound_for_calm: int = 2
@export var higher_bound_for_calm: int = 4
@export var attack_time: int = 1

var gen = RandomNumberGenerator.new()

var primary_state = CALM
var secondary_state = WANDERING

var time_in_calm_state = gen.randf_range(lower_bound_for_calm, higher_bound_for_calm)
var time_in_idle_state = gen.randf_range(0, time_in_calm_state/2)
var time_in_wandering_state = time_in_calm_state - time_in_idle_state

func change_state() -> void:
	if self.primary_state == CALM && self.secondary_state == WANDERING:
		self.secondary_state = IDLE
	elif self.primary_state == CALM && self.secondary_state == IDLE:
		self.primary_state = ATTACKING
	elif self.primary_state == ATTACKING:
		self.primary_state = CALM
		self.secondary_state = WANDERING


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
