extends Actor

class_name EnemyAI

enum {
	CALM,
	ATTACKING
}

@export var lower_bound_for_calm: int = 2
@export var higher_bound_for_calm: int = 4
@export var attack_time: int = 1

var gen = RandomNumberGenerator.new()

var current_state = CALM
var time_in_calm_state = gen.randf_range(lower_bound_for_calm, higher_bound_for_calm)

func _change_state() -> void:
	if self.current_state == CALM:
		self.current_state = ATTACKING
	else:
		self.current_state = CALM
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
