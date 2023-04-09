extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var enemy_AI: EnemyAI = EnemyAI.new()
	enemy_AI.free()
	assert_no_new_orphans('There is some memory allocated still.')

func test_initial_setup():
	var enemy_AI: EnemyAI = autoqfree(EnemyAI.new())
	add_child(enemy_AI)
	assert_eq(enemy_AI.state, EnemyAI.State.IDLE, "When first created an enemy AI is in the idle state")
	assert_between(enemy_AI.time_in_idle_state, enemy_AI.lower_bound_for_idle, enemy_AI.higher_bound_for_idle)
	assert_between(enemy_AI.time_in_wandering_state, enemy_AI.lower_bound_for_wandering, enemy_AI.higher_bound_for_wandering)
	assert_almost_eq(enemy_AI.timer.wait_time, 1.0, 0.01)

func test_setting_state_wandering():
	var enemy_AI: EnemyAI = autoqfree(EnemyAI.new())
	enemy_AI._set_state_wandering()
	assert_eq(enemy_AI.state, enemy_AI.State.WANDERING)
	assert_ne(enemy_AI.velocity, Vector2(0,0))
	assert_almost_eq(enemy_AI.velocity.length(), enemy_AI.speed, 0.01)

func test_setting_state_idle():
	var enemy_AI: EnemyAI = autoqfree(EnemyAI.new())
	enemy_AI._set_state_idle()
	assert_eq(enemy_AI.state, enemy_AI.State.IDLE)
	assert_eq(enemy_AI.velocity, Vector2(0,0))

func test_setting_state_attacking():
	var enemy_AI: EnemyAI = autoqfree(EnemyAI.new())
	enemy_AI._set_state_attacking()
	assert_eq(enemy_AI.state, enemy_AI.State.ATTACKING)
	assert_eq(enemy_AI.velocity, Vector2(0,0))

func test_changing_states_with_timer():
	var enemy_AI: EnemyAI = autoqfree(EnemyAI.new())
	add_child(enemy_AI)
	
	await enemy_AI.timer.timeout
	assert_eq(enemy_AI.state, enemy_AI.State.WANDERING)
	assert_ne(enemy_AI.velocity, Vector2(0,0))
	
	await enemy_AI.timer.timeout
	assert_eq(enemy_AI.state, enemy_AI.State.ATTACKING)
	assert_eq(enemy_AI.velocity, Vector2(0,0))
	
	await enemy_AI.timer.timeout
	assert_eq(enemy_AI.state, enemy_AI.State.IDLE)
	assert_eq(enemy_AI.velocity, Vector2(0,0))
