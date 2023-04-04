extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_hitbox_damage_by_itself():
	# The hitbox should't have damage by itself,
	# only when connected to entity that has damage
	var hitbox: Hitbox = autofree(Hitbox.new())
	assert_eq(hitbox.get_damage(), 0)

func test_hitbox_damage():
	var hitbox: Hitbox = autofree(Hitbox.new())
	hitbox.set_damage(5)
	assert_eq(hitbox.get_damage(), 5)
