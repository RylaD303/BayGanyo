extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_signal_connection():
	var hurtbox: HurtBox = autofree(HurtBox.new())
	watch_signals(hurtbox)
	hurtbox.emit_signal("area_entered", null)
	assert_signal_emitted(hurtbox, "area_entered")

func test_entering_hurtbox_with_hitbox():
	var hurtbox: HurtBox = autofree(HurtBox.new())
	var hitbox: HitBox = autofree(HitBox.new())
	watch_signals(hurtbox)
	hurtbox.emit_signal("area_entered", hitbox)
	assert_signal_emitted(hurtbox, "area_entered", [hitbox])

func test_taking_damage_when_hurtbox_gets_hit():
	var hurtbox: HurtBox = autofree(HurtBox.new())
	var hitbox: HitBox = autofree(HitBox.new())
	var health_controller: HealthController = autofree(HealthController.new())
	health_controller.set_max_health(10)
	health_controller.set_current_health(10)
	hurtbox.health_controller = health_controller
	hitbox.set_damage(5) 
	hurtbox.emit_signal("area_entered", hitbox)
	assert_eq(hurtbox.health_controller.current_health, 5) 
