extends GutTest

func after_each():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var player = Player.new() 
	# I can use autofree() but the memory tree won't know I'm using it 
	# so the assert_no_new_orphans() will fail.
	player.free()
