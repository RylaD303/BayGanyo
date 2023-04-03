extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var enemy_AI: EnemyAI = EnemyAI.new()
	enemy_AI.free()
	assert_no_new_orphans('There is some memory allocated still.')

func test_initial_state():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	assert_eq(enemy_AI.state, EnemyAI.State.IDLE, "When first created an enemy AI is in the idle state")

func test_changing_state_wandering():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	enemy_AI._set_state_wandering()
	assert_eq(enemy_AI.state, enemy_AI.State.WANDERING)
	assert_ne(enemy_AI.velocity, Vector2(0,0))


