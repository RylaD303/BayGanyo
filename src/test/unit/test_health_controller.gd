extends GutTest

func after_all():
	assert_no_new_orphans('There is some memory allocated still.')

func test_memory_freeing():
	var health_controller: HealthController = HealthController.new()
	health_controller.free()
	# There is a script that checks after all the tests are done 
	# if the memory is freed properly.

func test_health():
	var health_controller: HealthController = autofree(HealthController.new())
	assert_eq(health_controller.current_health, health_controller.max_health)

func test_taking_damage():
	var health_controller: HealthController = autofree(HealthController.new())
	health_controller.take_damage(0)
	assert_eq(health_controller.current_health, health_controller.max_health)
	
	health_controller.take_damage(health_controller.max_health)
	assert_eq(health_controller.current_health, 0)
	
	health_controller.take_damage(1)
	assert_eq(health_controller.current_health, 0)

func test_healing():
	var health_controller: HealthController = autofree(HealthController.new())
	health_controller.current_health = 0
	
	health_controller.heal(0)
	assert_eq(health_controller.current_health, 0)
	
	health_controller.heal(health_controller.max_health)
	assert_eq(health_controller.current_health, health_controller.max_health)
	
	health_controller.heal(1)
	assert_eq(health_controller.current_health, health_controller.max_health)
