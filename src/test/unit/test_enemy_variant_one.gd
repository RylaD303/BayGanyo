extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_ability_to_shoot_after_change_state():
	var enemy: EnemyVariantOne = autofree(EnemyVariantOne.new())
	enemy._set_state_attacking()
	assert_true(enemy.able_to_attack)

func test_inability_to_shoot_after_shooting():
	var enemy: EnemyVariantOne =EnemyVariantOne.new()
	enemy.able_to_attack = true
	add_child_autofree(enemy)
	enemy.attack()
	assert_false(enemy.able_to_attack)
