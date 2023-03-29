extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_signal_connection():
	var hurtbox: HurtBox = autofree(HurtBox.new())
	watch_signals(hurtbox)
	hurtbox.emit_signal("area_entered")
	assert_signal_emitted(hurtbox, "area_entered")

func test_entering_hurtbox_with_hitbox():
	var hurtbox: HurtBox = autofree(HurtBox.new())
	var hitbox: HitBox = autofree(HitBox.new())
	watch_signals(hurtbox)
	hurtbox.emit_signal("area_entered", hitbox)
	assert_signal_emitted(hurtbox, "area_entered", [hitbox])
