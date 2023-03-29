extends GutTest


func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var hurtbox: HurtBox = HurtBox.new()
	hurtbox.free()
	assert_no_new_orphans('There is some memory allocated still.')
