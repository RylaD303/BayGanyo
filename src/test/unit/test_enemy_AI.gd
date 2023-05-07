extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_initial_setup():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	add_child(enemy_AI)
	assert_eq(enemy_AI.state, EnemyAI.State.IDLE, "When first created an enemy AI is in the idle state")
	assert_between(enemy_AI.time_in_idle_state, enemy_AI.lower_bound_for_idle_time, enemy_AI.upper_bound_for_idle_time)
	assert_between(enemy_AI.time_in_wandering_state, enemy_AI.lower_bound_for_wandering_time, enemy_AI.upper_bound_for_idle_time)
	assert_almost_eq(enemy_AI.state_timer.wait_time, 1.0, 0.01)

func test_setting_state_wandering():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	enemy_AI._set_state_wandering()
	assert_eq(enemy_AI.state, enemy_AI.State.WANDERING)
	assert_ne(enemy_AI.velocity, Vector2.ZERO)
	assert_almost_eq(enemy_AI.velocity.length(), enemy_AI.speed, 0.01)

func test_setting_state_idle():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	enemy_AI._set_state_idle()
	assert_eq(enemy_AI.state, enemy_AI.State.IDLE)
	assert_eq(enemy_AI.velocity, Vector2.ZERO)

func test_setting_state_attacking():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	enemy_AI._set_state_attacking()
	assert_eq(enemy_AI.state, enemy_AI.State.ATTACKING)
	assert_eq(enemy_AI.velocity, Vector2.ZERO)

func test_changing_states_with_timer():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	add_child(enemy_AI)
	
	enemy_AI.state_timer.emit_signal("timeout")
	assert_eq(enemy_AI.state, enemy_AI.State.WANDERING)
	assert_ne(enemy_AI.velocity, Vector2.ZERO)
	
	enemy_AI.state_timer.emit_signal("timeout")
	assert_eq(enemy_AI.state, enemy_AI.State.ATTACKING)
	assert_eq(enemy_AI.velocity, Vector2.ZERO)
	
	enemy_AI.state_timer.emit_signal("timeout")
	assert_eq(enemy_AI.state, enemy_AI.State.IDLE)
	assert_eq(enemy_AI.velocity, Vector2.ZERO)

func test_enemy_AI_gets_position_of_player():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	assert_eq(enemy_AI.get_player_position(), Vector2.ZERO)
	var player: Player = autofree(preload("res://src/objects/player/player.tscn").instantiate())
	player.position = Vector2(10, 2)
	enemy_AI.set_player_reference(player)
	assert_eq(enemy_AI.get_player_position(), Vector2(10, 2))
	player.position = Vector2(5, 3)
	assert_eq(enemy_AI.get_player_position(), Vector2(5, 3))
