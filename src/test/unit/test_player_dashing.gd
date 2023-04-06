extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func after_each():
	Input.action_release("UI_dash")

func test_default_state_dashing():
	var player: Player = autofree(Player.new())
	assert_false(player.is_dashing)
	assert_true(player.can_dash)


func test_dash_user_input():
	var player: Player = autofree(Player.new())
	player.velocity = Vector2(1,0)
	Input.action_press("UI_dash")
	player.check_dash_input()
	assert_true(player.is_dashing)
	assert_false(player.can_dash)

func test_player_cannot_dash_with_no_velocity():
	var player: Player = autofree(Player.new())
	player.velocity = Vector2.ZERO
	Input.action_press("UI_dash")
	player.check_dash_input()
	assert_false(player.is_dashing)
	assert_true(player.can_dash)
