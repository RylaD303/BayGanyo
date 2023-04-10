extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func after_each():
	Input.action_release("UI_right")
	Input.action_release("UI_left")

func set_player_default(player: Player) -> void:
	player.speed = 1
	player.acceleration = 1
	player.friction = 1

func test_player_not_moving():
	var player: Player = autofree(Player.new())
	set_player_default(player)
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))
	assert_eq(player.get_input_direction(), Vector2(0, 0))

func test_player_input():
	var player: Player = autofree(Player.new())
	set_player_default(player)
	Input.action_press("UI_right")
	assert_eq(player.get_input_direction(), Vector2(1, 0))

func test_player_moving():
	var player: Player = autofree(Player.new())
	set_player_default(player)
	Input.action_press("UI_right")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(1, 0))
	Input.action_release("UI_right")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))
	
func test_player_double_button_press():
	var player: Player = autofree(Player.new())
	set_player_default(player)
	Input.action_press("UI_right")
	Input.action_press("UI_left")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))
	Input.action_release("UI_right")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(-1, 0))
	Input.action_release("UI_left")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))
	

func test_player_button_held():
	var player: Player = autofree(Player.new())
	set_player_default(player)
	Input.action_press("UI_right")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(1, 0))
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(1, 0))
	Input.action_release("UI_right")
	player.calculate_velocity()
	assert_eq(player.velocity, Vector2(0, 0))

func test_player_acceleration():
	var player: Player = autofree(Player.new())
	player.speed = 10
	player.acceleration = 5
	Input.action_press("UI_right")
	player.calculate_velocity()
	assert_true(player.velocity.x > 0 && player.velocity.x < 10)
	player.calculate_velocity()
	assert_true(player.velocity.x == 10)
	
	

func test_player_friction():
	var player: Player = autofree(Player.new())
	player.friction = 5
	player.velocity = Vector2(10, 0)
	player.calculate_velocity()
	assert_true(player.velocity.x > 0 && player.velocity.x < 10)
	player.calculate_velocity()
	assert_true(player.velocity.x == 0)
