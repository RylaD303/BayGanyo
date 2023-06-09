extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func after_each():
	Input.action_release("UI_dash")
	Input.action_release("UI_right")
	Input.action_release("UI_left")

func test_default_state_dashing():
	var player: Player = autofree(Player.new())
	assert_false(player.is_dashing)
	assert_true(player.can_dash)

func test_player_changes_speed_when_dashing():
	var player: Player = autofree(Player.new())
	Input.action_press("UI_right")
	player.dash()
	assert_eq(player.velocity, Vector2(player.dash_speed, 0))

func test_dash_user_input():
	var player: Player = autofree(Player.new())
	Input.action_press("UI_right")
	Input.action_press("UI_dash")
	player.check_input_dash()
	assert_true(player.is_dashing)
	assert_false(player.can_dash)

func test_player_cannot_dash_with_no_velocity():
	var player: Player = autofree(Player.new())
	player.velocity = Vector2.ZERO
	player.dash()
	assert_false(player.is_dashing)
	assert_true(player.can_dash)

func test_player_cannot_change_direction_while_dashing():
	var player: Player = autofree(Player.new())
	Input.action_press("UI_right")
	player.dash()
	assert_eq(player.velocity, Vector2(player.dash_speed, 0))
	Input.action_press("UI_left")
	player.change_velocity()
	assert_eq(player.velocity, Vector2(player.dash_speed, 0))

func test_player_dashability_changes_on_timer_timeout():
	var player: Player = autofree(Player.new())
	add_child(player) 
	# connecting player to the tree, so the player's
	# timers are connected to the tree and start
	# counting down.
	Input.action_press("UI_right")
	player.dash()
	assert_true(player.is_dashing)
	assert_false(player.can_dash)
	player.dash_duration_timer.timeout.emit()
	assert_false(player.is_dashing)
	assert_false(player.can_dash)
	player.dash_cooldown_timer.timeout.emit()
	assert_false(player.is_dashing)
	assert_true(player.can_dash)

func test_player_can_dash_again():
	var player: Player = autofree(Player.new())
	add_child(player)
	Input.action_press("UI_right")
	player.dash()
	player.dash_duration_timer.timeout.emit()
	player.dash_cooldown_timer.timeout.emit()
	assert_false(player.is_dashing)
	assert_true(player.can_dash)
	player.dash()
	assert_true(player.is_dashing)
	assert_false(player.can_dash)
