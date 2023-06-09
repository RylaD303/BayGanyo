extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_bullet_setting_damage_properly():
	var bullet: Bullet = autofree(Bullet.new())
	var hitbox: Hitbox = autofree(Hitbox.new())
	bullet.hitbox = hitbox
	bullet.set_damage(5)
	assert_eq(hitbox.get_damage(), 5)


func test_bullet_setting_movement():
	var bullet: Bullet = autofree(Bullet.new())
	bullet.speed = 10
	bullet.global_position = Vector2.ZERO
	bullet.set_direction_to_position(Vector2(50, 0))
	assert_eq(bullet.velocity, Vector2(10, 0))
	
func test_bullet_deleting_on_hit():
	var bullet: Bullet = autofree(Bullet.new())
	var hurtbox: Hurtbox = null
	bullet.hitbox = autofree(Hitbox.new())
	bullet.setup_hitbox()
	bullet.hitbox.emit_signal("entered_hurtbox", hurtbox)
	assert_true(bullet.is_queued_for_deletion())

func test_bullet_rotation():
	var bullet: Bullet = autofree(Bullet.new())
	bullet.global_position = Vector2.ZERO
	bullet.redirect_bullet(Vector2(0, 0), Vector2(-50, 0))
	assert_almost_eq(bullet.rotation, 3.14, 0.01)
