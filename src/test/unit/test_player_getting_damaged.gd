extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_player_getting_damaged():
	var player: Player = autofree(Player.new())
	var hitbox: Hitbox =
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))
	assert_eq(player.get_input_direction(), Vector2(0, 0))
