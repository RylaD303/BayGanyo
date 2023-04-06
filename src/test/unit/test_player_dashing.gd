extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func after_each():
	Input.action_release("UI_dash")

func test_default_state_dashing():
	var player: Player = autofree(Player.new())
	assert_false(player.dashing)
	assert_true(player.can_dash)


func test_dash_user_input():
	var player: Player = autofree(Player.new())
	Input.action_press("UI_dash")
	player.check_dash_input()
	assert_true(player.dashing)
	assert_false(player.can_dash)
