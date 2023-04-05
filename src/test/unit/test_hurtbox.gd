extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_entering_hurtbox_with_hitbox():
	var hurtbox: Hurtbox = autofree(Hurtbox.new())
	var hitbox: Hitbox = autofree(Hitbox.new())
	watch_signals(hurtbox)
	hurtbox.emit_signal("area_entered", hitbox)
	assert_signal_emitted(hurtbox, "hitbox_entered", [hitbox])
