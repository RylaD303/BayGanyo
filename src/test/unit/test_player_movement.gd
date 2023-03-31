extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_player_not_moving():
	var player: Player = autofree(Player.new())
	player.speed = 1
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(0, 0))

func test_player_input():
	var player: Player = autofree(Player.new())
	player.speed = 1
	Input.action_press("UI_right")
	assert_eq(player.get_input_direction(), Vector2(1, 0))

func test_player_moving():
	var player: Player = autofree(Player.new())
	player.speed = 1
	Input.action_press("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(1, 0))
	Input.action_release("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(0, 0))
	
func test_player_double_button_press():
	var player: Player = autofree(Player.new())
	player.speed = 1
	Input.action_press("UI_right")
	Input.action_press("UI_left")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(0, 0))
	Input.action_release("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(-1, 0))
	Input.action_release("UI_left")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(0, 0))
	

func test_player_button_held():
	var player: Player = autofree(Player.new())
	player.speed = 1
	Input.action_press("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(1, 0))
	simulate(player, 2, 1)
	assert_eq(player.velocity, Vector2(1, 0))
	Input.action_release("UI_right")
	simulate(player, 1, 1)
	assert_eq(player.velocity, Vector2(0, 0))
