extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var enemy_AI: EnemyAI = EnemyAI.new()
	enemy_AI.free()
	assert_no_new_orphans('There is some memory allocated still.')

func test_initial_state():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	assert_eq(enemy_AI.primary_state, EnemyAI.CALM, "When first created an enemy AI is in the calm state")
	assert_eq(enemy_AI.secondary_state, EnemyAI.WANDERING, "When first created an enemy AI is in the wandering state")
	

func test_changing_state():
	var enemy_AI: EnemyAI = autofree(EnemyAI.new())
	enemy_AI.change_state()
	assert_eq(enemy_AI.primary_state, EnemyAI.CALM)
	assert_eq(enemy_AI.secondary_state, EnemyAI.IDLE)
	enemy_AI.change_state()
	assert_eq(enemy_AI.primary_state, EnemyAI.ATTACKING)
	assert_eq(enemy_AI.secondary_state, EnemyAI.IDLE)
	enemy_AI.change_state()
	assert_eq(enemy_AI.primary_state, EnemyAI.CALM)
	assert_eq(enemy_AI.secondary_state, EnemyAI.WANDERING)


