extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func check_default_state_dashing():
	var player: Player = autofree(Player.new())
	assert_false(player.can_dash)
