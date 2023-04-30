extends Node

class_name EnemySpawner

@export var number_of_enemies: int = 3

func _ready():
	var random_number_generator: RandomNumberGenerator = RandomNumberGenerator.new()
	var scene_size = get_viewport().get_visible_rect().size
	
	for i in range (0, number_of_enemies):
		var enemy: Enemy = Enemy.new()
		random_number_generator.randomize()
		var x_coordinate = random_number_generator.randf_range(0, scene_size.x)
		random_number_generator.randomize()
		var y_coordinate = random_number_generator.randf_range(0, scene_size.y)
		enemy.position = Vector2(x_coordinate, y_coordinate)
		add_child(enemy)


