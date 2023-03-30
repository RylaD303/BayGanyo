extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_player_not_moving():
	var player: Player = autofree(Player.new())
	player.global_position = Vector2(0, 0)
	player.speed = 1
	simulate(player, 1, 1)
	assert_eq(player.global_position, Vector2(0, 0))

func test_player_moving():
	var player: Player = autofree(Player.new())
	player.global_position = Vector2(0, 0)
	player.speed = 1
	Input.action_press("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.movement, Vector2(1, 0))
	assert_eq(player.global_position, Vector2(1, 0))
