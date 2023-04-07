extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_player_getting_damaged():
	var player: Player = autofree(Player.new())
	player.hurtbox =  autofree(Hurtbox.new())
	player.health_controller = autofree(HealthController.new())

	var hitbox: Hitbox = autofree(Hitbox.new())
	player.setup_hurtbox_connections()
	player.health_controller.set_max_health(10)
	player.health_controller.set_current_health(10)
	hitbox.set_damage(5)
	watch_signals(player.health_controller)
	assert_eq(player.health_controller.current_health, 10)
	player.hurtbox.emit_signal("area_entered", hitbox)
	assert_eq(player.health_controller.current_health, 5)
	player.hurtbox.emit_signal("area_entered", hitbox)
	assert_eq(player.health_controller.current_health, 0)
	assert_signal_emitted(player.health_controller, "health_depleted")
